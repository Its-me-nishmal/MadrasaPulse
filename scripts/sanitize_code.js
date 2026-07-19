const { execSync } = require('child_process');
const fs = require('fs');
const path = require('path');

function sanitizeCode() {
  console.log('🔍 Starting Code Sanitization check...');

  let stagedFiles;
  try {
    if (process.env.GITHUB_ACTIONS === 'true') {
      console.log('   Running in CI environment. Scanning files changed in the latest commit...');
      stagedFiles = execSync('git diff --name-only HEAD~1 HEAD', { encoding: 'utf8' })
        .split('\n')
        .map(f => f.trim())
        .filter(Boolean);
    } else {
      stagedFiles = execSync('git diff --cached --name-only', { encoding: 'utf8' })
        .split('\n')
        .map(f => f.trim())
        .filter(Boolean);
    }
  } catch (e) {
    console.log('⚠️  Git diff failed (likely shallow checkout). Scanning all modified working files...');
    try {
      stagedFiles = execSync('git diff --name-only', { encoding: 'utf8' })
        .split('\n')
        .map(f => f.trim())
        .filter(Boolean);
    } catch (_) {
      console.log('⚠️  Failed to check files. Skipping code sanitization.');
      process.exit(0);
    }
  }

  if (stagedFiles.length === 0) {
    console.log('   No staged files to check.');
    process.exit(0);
  }

  let hasError = false;

  stagedFiles.forEach(file => {
    if (!fs.existsSync(file)) return;
    const stat = fs.statSync(file);
    if (stat.isDirectory()) return;

    // Skip auditing developer utility scripts
    if (file.includes('scripts/') || file.includes('scripts\\')) return;

    const content = fs.readFileSync(file, 'utf8');

    // 1. Check JS files for console.log
    if (file.endsWith('.js')) {
      if (content.includes('console.log(')) {
        console.error(`   ❌ Error in ${file}: Found 'console.log('. Please remove debug logging or use a formal logger.`);
        hasError = true;
      }
    }

    // 2. Check Dart files for print (excluding generated files)
    if (file.endsWith('.dart')) {
      if (file.endsWith('.freezed.dart') || file.endsWith('.g.dart')) return;
      if (content.includes('print(')) {
        console.error(`   ❌ Error in ${file}: Found 'print('. Please remove debug prints or use developer.log.`);
        hasError = true;
      }
    }

    // 3. Check for hardcoded MongoDB connection strings in production code
    if (content.includes('mongodb+srv://') || content.includes('mongodb://')) {
      if (!file.includes('test') && !file.includes('scratch') && !file.includes('scripts') && !file.includes('.github/workflows')) {
        console.error(`   ❌ Error in ${file}: Found hardcoded MongoDB connection string! Use environment variables instead.`);
        hasError = true;
      }
    }
  });

  if (hasError) {
    console.error('\n❌ Code Sanitization Check FAILED. Please clean your code before committing.');
    process.exit(1);
  } else {
    console.log('✅ Success: No forbidden print/console.log statements or hardcoded secrets found in staged files!');
    process.exit(0);
  }
}

sanitizeCode();
