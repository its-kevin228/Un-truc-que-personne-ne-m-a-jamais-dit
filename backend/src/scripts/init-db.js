require('dotenv').config();
const pool = require('../config/database');

const initDatabase = async () => {
  console.log('🔧 Initialisation de la base de données...\n');

  try {
    // Création de la table phrases
    await pool.query(`
      CREATE TABLE IF NOT EXISTS phrases (
        id SERIAL PRIMARY KEY,
        content TEXT NOT NULL,
        is_active BOOLEAN DEFAULT true,
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      )
    `);
    console.log('✅ Table "phrases" créée');

    // Création de la table app_stats
    await pool.query(`
      CREATE TABLE IF NOT EXISTS app_stats (
        id INT PRIMARY KEY DEFAULT 1,
        total_views INT DEFAULT 0,
        last_view_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        CONSTRAINT single_row CHECK (id = 1)
      )
    `);
    console.log('✅ Table "app_stats" créée');

    // Insérer la ligne de stats si elle n'existe pas
    await pool.query(`
      INSERT INTO app_stats (id, total_views, last_view_at) 
      VALUES (1, 0, NOW()) 
      ON CONFLICT (id) DO NOTHING
    `);
    console.log('✅ Ligne de statistiques initialisée');

    console.log('\n🎉 Base de données initialisée avec succès!');

  } catch (error) {
    console.error('❌ Erreur lors de l\'initialisation:', error.message);
  } finally {
    await pool.end();
  }
};

initDatabase();
