/**
 * Migration 002: Create audit_logs collection for tracking changes
 */
module.exports = {
  name: '002_add_audit_logs',
  up: async (db) => {
    // Check if collection already exists
    const collections = await db.listCollections({ name: 'audit_logs' }).toArray();
    if (collections.length === 0) {
      await db.createCollection('audit_logs', {
        capped: true,
        size: 52428800, // 50MB capped collection
        max: 100000,
      });
      console.log('Created "audit_logs" capped collection.');
    }

    const auditLogs = db.collection('audit_logs');
    await auditLogs.createIndex({ madrasaId: 1, createdAt: -1 });
    await auditLogs.createIndex({ userId: 1 });
    await auditLogs.createIndex({ action: 1 });
    await auditLogs.createIndex({ entityType: 1, entityId: 1 });

    console.log('Migration 002 complete.');
  },
};
