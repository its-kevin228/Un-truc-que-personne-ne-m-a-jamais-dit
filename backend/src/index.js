require('dotenv').config();
const express = require('express');
const cors = require('cors');
const phraseRoutes = require('./routes/phraseRoutes');

const app = express();
const PORT = process.env.PORT || 3000;

// Middlewares
app.use(cors());
app.use(express.json());

// Routes
app.use('/api/phrase', phraseRoutes);

// Route de santé
app.get('/health', (req, res) => {
  res.json({ status: 'OK', timestamp: new Date().toISOString() });
});

// Route racine
app.get('/', (req, res) => {
  res.json({
    name: "Un truc que personne ne m'a jamais dit - API",
    version: '1.0.0',
    endpoints: {
      random: 'GET /api/phrase/random',
      health: 'GET /health'
    }
  });
});

// Gestion des erreurs 404
app.use((req, res) => {
  res.status(404).json({ error: 'Route non trouvée' });
});

// Gestion des erreurs globales
app.use((err, req, res, next) => {
  console.error('Erreur:', err.message);
  res.status(500).json({ error: 'Erreur interne du serveur' });
});

app.listen(PORT, () => {
  console.log(`🚀 Serveur démarré sur http://localhost:${PORT}`);
  console.log(`📖 API disponible sur http://localhost:${PORT}/api/phrase/random`);
});
