const express = require('express');
const { register, login, refresh } = require('../controllers/authController');
const { requireAuth } = require('../middleware/auth');

const router = express.Router();

// Authentication Endpoints
router.post('/register', register);
router.post('/login', login);
router.post('/refresh', refresh);

// Protected Test Route to verify JWT validation
router.get('/me', requireAuth, (req, res) => {
  res.status(200).json({
    success: true,
    data: {
      user: req.user
    }
  });
});

module.exports = router;
