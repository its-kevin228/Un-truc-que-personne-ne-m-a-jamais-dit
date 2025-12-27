const pool = require('../config/database');

const phraseController = {
  // Obtenir une phrase aléatoire
  async getRandomPhrase(req, res) {
    try {
      // Récupérer une phrase active aléatoire
      const phraseResult = await pool.query(`
        SELECT id, content 
        FROM phrases 
        WHERE is_active = true 
        ORDER BY RANDOM() 
        LIMIT 1
      `);

      if (phraseResult.rows.length === 0) {
        return res.status(404).json({ error: 'Aucune phrase disponible' });
      }

      // Incrémenter le compteur de vues
      await pool.query(`
        UPDATE app_stats 
        SET total_views = total_views + 1, 
            last_view_at = NOW() 
        WHERE id = 1
      `);

      const phrase = phraseResult.rows[0];
      
      res.json({
        id: phrase.id,
        content: phrase.content
      });

    } catch (error) {
      console.error('Erreur lors de la récupération de la phrase:', error.message);
      res.status(500).json({ error: 'Erreur serveur' });
    }
  }
};

module.exports = phraseController;
