/**
 * Database migration runner for MadrasaPulse
 * Usage: node scripts/migrate.js [migration-name]
 */
require('dotenv').config({ path: require('path').join(__dirname, '..', 'backend', '.env') });
const mongoose = require('mongoose');
const path = require('path');
const fs = require('fs');

const MIGRATIONS_DIR = path.join(__dirname, 'migrations');

// Ensure migrations directory exists
if (!fs.existsSync(MIGRATIONS_DIR)) {
  fs.mkdirSync(MIGRATIONS_DIR, { recursive: true });
}

const runMigrations = async () => {
  const migrationName = process.argv[2];

  await mongoose.connect(process.env.MONGODB_URI || 'mongodb://localhost:27017/madrasapulse');
  console.log('Connected to MongoDB for migrations.');

  // Ensure migrations collection exists
  const db = mongoose.connection.db;
  const migrationsCol = db.collection('_migrations');

  const applied = await migrationsCol.find().sort({ appliedAt: 1 }).toArray();
  const appliedNames = new Set(applied.map(m => m.name));

  const files = fs.readdirSync(MIGRATIONS_DIR)
    .filter(f => f.endsWith('.js'))
    .sort();

  if (migrationName) {
    // Run specific migration
    const file = files.find(f => f === `${migrationName}.js`);
    if (!file) {
      console.error(`Migration "${migrationName}" not found.`);
      console.log('Available migrations:', files.map(f => f.replace('.js', '')).join(', '));
      process.exit(1);
    }
    if (appliedNames.has(migrationName)) {
      console.log(`Migration "${migrationName}" already applied. Skipping.`);
    } else {
      console.log(`Running migration: ${migrationName}`);
      const migration = require(path.join(MIGRATIONS_DIR, `${migrationName}.js`));
      await migration.up(db);
      await migrationsCol.insertOne({ name: migrationName, appliedAt: new Date() });
      console.log(`Migration "${migrationName}" applied.`);
    }
  } else {
    // Run all pending migrations
    for (const file of files) {
      const name = file.replace('.js', '');
      if (appliedNames.has(name)) {
        console.log(`Skipping already applied: ${name}`);
        continue;
      }
      console.log(`Running migration: ${name}`);
      const migration = require(path.join(MIGRATIONS_DIR, file));
      await migration.up(db);
      await migrationsCol.insertOne({ name, appliedAt: new Date() });
      console.log(`Migration "${name}" applied.`);
    }
  }

  await mongoose.disconnect();
  console.log('Migrations complete.');
  process.exit(0);
};

runMigrations().catch(err => {
  console.error('Migration error:', err);
  process.exit(1);
});
