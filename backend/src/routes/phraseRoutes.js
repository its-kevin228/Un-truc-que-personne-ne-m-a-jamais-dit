const express = require('express');
const router = express.Router();
const phraseController = require('../controllers/phraseController');

// GET /api/phrase/random - Obtenir une phrase aléatoire
router.get('/random', phraseController.getRandomPhrase);

module.exports = router;
