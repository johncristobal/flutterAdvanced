const { Router } = require('express');
const { googleAuth } = require('../controllers/auth');

router = Router();

router.post('/google', googleAuth);

module.exports = router;