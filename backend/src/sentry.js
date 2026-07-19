/**
 * Sentry error tracking configuration
 * Initializes Sentry only if SENTRY_DSN is configured
 */
let Sentry;

const initSentry = (app) => {
  const dsn = process.env.SENTRY_DSN;
  if (!dsn) {
    console.warn('Sentry not configured — skipping initialization');
    return;
  }

  Sentry = require('@sentry/node');
  const { profilingIntegration } = require('@sentry/profiling-node');

  Sentry.init({
    dsn,
    environment: process.env.NODE_ENV || 'development',
    integrations: [
      profilingIntegration(),
    ],
    tracesSampleRate: process.env.NODE_ENV === 'production' ? 0.1 : 1.0,
    profilesSampleRate: process.env.NODE_ENV === 'production' ? 0.1 : 1.0,
  });

  app.use(Sentry.Handlers.requestHandler());
  app.use(Sentry.Handlers.tracingHandler());
};

const requestHandler = () => {
  return (req, res, next) => {
    if (Sentry) {
      Sentry.setUser(req.user ? { id: req.user.userId, madrasaId: req.user.madrasaId } : null);
    }
    next();
  };
};

const errorHandler = () => {
  if (!Sentry) {
    return (err, req, res, next) => next(err);
  }
  return Sentry.Handlers.errorHandler();
};

module.exports = { initSentry, requestHandler, errorHandler };
