/**
 * Migration 001: Create Class collection and add classId indexes
 */
module.exports = {
  name: '001_add_class_collection',
  up: async (db) => {
    const classes = db.collection('classes');

    // Check if collection already exists
    const collections = await db.listCollections({ name: 'classes' }).toArray();
    if (collections.length === 0) {
      await db.createCollection('classes');
      console.log('Created "classes" collection.');
    }

    // Create indexes
    await classes.createIndex({ madrasaId: 1, name: 1 }, { unique: true });
    await classes.createIndex({ madrasaId: 1 });

    // Insert default classes
    const existingCount = await classes.countDocuments();
    if (existingCount === 0) {
      await classes.insertMany([
        { name: 'Class 1', section: 'A', madrasaId: null },
        { name: 'Class 2', section: 'A', madrasaId: null },
        { name: 'Class 3', section: 'A', madrasaId: null },
        { name: 'Class 4', section: 'A', madrasaId: null },
        { name: 'Class 5', section: 'A', madrasaId: null },
      ]);
      console.log('Inserted default classes.');
    }

    // Add indexes on related collections
    const students = db.collection('students');
    await students.createIndex({ classId: 1 });

    const teachers = db.collection('teachers');
    await teachers.createIndex({ 'assignedClasses.classId': 1 });

    console.log('Migration 001 complete.');
  },
};
