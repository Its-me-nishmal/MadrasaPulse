module.exports = {
  testEnvironment: 'node',
  testMatch: ['**/__tests__/**/*.js', '**/?(*.)+(spec|test).js'],
  testPathIgnorePatterns: ['/node_modules/', '/src/config/env/'],
  collectCoverage: true,
  coverageDirectory: 'coverage',
  coverageReporters: ['text', 'lcov', 'clover'],
  collectCoverageFrom: [
    'src/**/*.js',
    '!src/index.js',
    '!**/node_modules/**',
  ],
  coverageThreshold: {
    global: {
      branches: 25,
      functions: 50,
      lines: 50,
      statements: 50,
    },
  },
  verbose: true,
  forceExit: true,
  detectOpenHandles: true,
};
