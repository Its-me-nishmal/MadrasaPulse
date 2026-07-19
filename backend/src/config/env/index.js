const development = require('./development');
const production = require('./production');
const staging = require('./staging');
const test = require('./test');

const env = process.env.NODE_ENV || 'development';

const configs = {
  development,
  production,
  staging,
  test,
};

module.exports = configs[env] || development;
