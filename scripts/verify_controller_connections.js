const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');

const rootDir = path.join(__dirname, '..');
const featuresDir = path.join(rootDir, 'frontend', 'lib', 'features');

function checkControllerConnections() {
  console.log('🔍 Auditing Frontend Controllers for active API/Repository connections...');

  if (!fs.existsSync(featuresDir)) {
    console.log('   No features directory found. Skipping controller connections audit.');
    process.exit(0);
  }

  // Find all controller files recursively
  const controllers = [];
  function findControllers(dir) {
    const files = fs.readdirSync(dir);
    for (const file of files) {
      const fullPath = path.join(dir, file);
      if (fs.statSync(fullPath).isDirectory()) {
        findControllers(fullPath);
      } else if (file.endsWith('_controller.dart')) {
        controllers.push(fullPath);
      }
    }
  }

  findControllers(featuresDir);
  console.log(`   Found ${controllers.length} controllers to check.`);

  let hasHollowController = false;

  controllers.forEach(controllerPath => {
    const relativePath = path.relative(rootDir, controllerPath);
    const content = fs.readFileSync(controllerPath, 'utf8');

    // Check if the controller modifies state
    const modifiesState = content.includes('state =') || content.includes('.copyWith(');
    if (!modifiesState) {
      // Controller might just be a simple provider or read-only service, which is fine
      return;
    }

    // Check if the controller is connected to any repository, network client, or API configuration
    const hasApiReference = 
      content.includes('Repository') || 
      content.includes('DioClient') || 
      content.includes('_dio') || 
      content.includes('ApiConfig') ||
      content.includes('authControllerProvider') || // cross-controller delegation
      relativePath.includes('router_notifier');     // router notifier is an exception

    if (!hasApiReference) {
      console.error(`   ❌ Error in ${relativePath}: Controller modifies state but contains NO references to Repositories, DioClient, or ApiConfig! (Likely a static mock controller).`);
      hasHollowController = true;
    } else {
      console.log(`   ✅ Controller ${relativePath} is connected to API/Repository.`);
    }
  });

  if (hasHollowController) {
    console.error('\n❌ Controller Connection Check FAILED. Ensure all state-modifying controllers fetch data from a Repository or API.');
    process.exit(1);
  } else {
    console.log('\n✅ Success: All state-modifying controllers are properly connected to active data sources!');
    process.exit(0);
  }
}

checkControllerConnections();
