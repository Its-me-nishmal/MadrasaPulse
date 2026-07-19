const fs = require('fs');
const path = require('path');

const rootDir = path.join(__dirname, '..');
const apiConfigPath = path.join(rootDir, 'frontend', 'lib', 'core', 'network', 'api_config.dart');
const appJsPath = path.join(rootDir, 'backend', 'src', 'app.js');

function normalizeRoute(route) {
  // Convert standard dynamic Flutter string interpolation values like $id or $studentId to Express style :id or :studentId
  let normalized = route
    .replace(/\$([a-zA-Z0-9_]+)/g, ':$1')
    .replace(/\/+/g, '/')
    .trim();
  
  if (normalized.endsWith('/') && normalized.length > 1) {
    normalized = normalized.slice(0, -1);
  }
  return normalized;
}

function verifyAlignment() {
  console.log('🔍 Starting API Endpoint Alignment check...');

  if (!fs.existsSync(apiConfigPath)) {
    console.error(`❌ Error: api_config.dart not found at ${apiConfigPath}`);
    process.exit(1);
  }

  if (!fs.existsSync(appJsPath)) {
    console.error(`❌ Error: app.js not found at ${appJsPath}`);
    process.exit(1);
  }

  // 1. Extract API paths from Flutter's api_config.dart
  const apiConfigContent = fs.readFileSync(apiConfigPath, 'utf8');
  const flutterRoutes = new Set();
  
  // Match single-quoted or double-quoted paths starting with /
  const pathRegex = /'(\/[^'\s]+)'|"(\/[^"\s]+)"/g;
  let match;
  while ((match = pathRegex.exec(apiConfigContent)) !== null) {
    const rawPath = match[1] || match[2];
    flutterRoutes.add(normalizeRoute(rawPath));
  }

  console.log(`Found ${flutterRoutes.size} endpoints defined in Flutter's ApiConfig:`);
  flutterRoutes.forEach(r => console.log(`   📱 ${r}`));

  // 2. Extract API routes from Express backend
  const appJsContent = fs.readFileSync(appJsPath, 'utf8');
  const backendRoutes = new Set();
  
  // Add health check route which is defined inline in app.js
  backendRoutes.add('/health');

  // Match app.use('/api/v1/auth', authRoutes)
  const routeRegisterRegex = /app\.use\('\/api\/v1(\/[a-zA-Z0-9_-]+)',\s*([a-zA-Z0-9_]+)\)/g;
  const mounts = [];
  while ((match = routeRegisterRegex.exec(appJsContent)) !== null) {
    mounts.push({
      prefix: match[1],
      routesVarName: match[2]
    });
  }

  // Find the file imports for each routes variable
  mounts.forEach(mount => {
    const importRegex = new RegExp(`const\\s+${mount.routesVarName}\\s*=\\s*require\\('([^']+)'\\)`);
    const importMatch = importRegex.exec(appJsContent);
    if (importMatch) {
      const routeFilePath = path.resolve(rootDir, 'backend', 'src', importMatch[1] + '.js');
      if (fs.existsSync(routeFilePath)) {
        const routeFileContent = fs.readFileSync(routeFilePath, 'utf8');
        // Match router.get('/...', ...), router.post('/...', ...), etc.
        const routerRegex = /router\.(get|post|put|delete|patch)\(\s*'(\/[^']*)'/g;
        let routeMatch;
        while ((routeMatch = routerRegex.exec(routeFileContent)) !== null) {
          const fullPath = normalizeRoute(mount.prefix + routeMatch[2]);
          backendRoutes.add(fullPath);
        }
      }
    }
  });

  console.log(`\nFound ${backendRoutes.size} routes registered in Express Backend:`);
  backendRoutes.forEach(r => console.log(`   💻 ${r}`));

  // 3. Compare Flutter routes with backend routes
  console.log('\n⚖️  Checking for mismatches (Strict Two-Way Alignment)...');
  let hasMismatch = false;

  flutterRoutes.forEach(route => {
    if (!backendRoutes.has(route)) {
      console.error(`❌ Mismatch: Flutter calls '${route}', but this endpoint is NOT registered in the Express backend!`);
      hasMismatch = true;
    }
  });

  backendRoutes.forEach(route => {
    if (!flutterRoutes.has(route)) {
      console.error(`❌ Mismatch: Backend registers '${route}', but this endpoint is NOT defined in Flutter's ApiConfig!`);
      hasMismatch = true;
    }
  });

  if (hasMismatch) {
    console.error('\n❌ API Alignment Check FAILED. Please align the frontend ApiConfig paths with your backend routes.');
    process.exit(1);
  } else {
    console.log('\n✅ Success: All Flutter API endpoints are fully aligned with the Express backend routes!');
    process.exit(0);
  }
}

verifyAlignment();
