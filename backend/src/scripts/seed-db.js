require('dotenv').config();
const pool = require('../config/database');

const phrases = [
  "Tu progresses plus que tu ne le crois.",
  "C'est normal de ne pas tout savoir.",
  "Tu n'as pas besoin de te justifier pour exister.",
  "Ton rythme n'est pas un retard.",
  "Le repos fait partie du travail.",
  "Tu as le droit de changer d'avis.",
  "Demander de l'aide, c'est du courage.",
  "Tu n'es pas obligé d'être productif pour avoir de la valeur.",
  "Parfois, le plus beau cadeau que tu peux te faire, c'est de te laisser le temps.",
  "Tu n'es pas tes erreurs passées.",
  "Dire non, c'est aussi prendre soin de soi.",
  "Tu fais de ton mieux avec ce que tu as.",
  "Ta fatigue est valide.",
  "Tu n'as pas à tout comprendre pour avancer.",
  "Il n'y a pas de bonne façon de vivre sa vie.",
  "Tes émotions ne sont pas des obstacles.",
  "Tu mérites les bonnes choses qui t'arrivent.",
  "Prendre du temps pour toi n'est pas égoïste.",
  "Les petites victoires comptent aussi.",
  "Tu n'as pas besoin de tout réparer seul(e).",
  "Chaque jour est une nouvelle chance de recommencer.",
  "Ton parcours n'a pas à ressembler à celui des autres.",
  "La comparaison est le voleur de la joie.",
  "Tu es suffisant(e) tel(le) que tu es.",
  "Les échecs sont des professeurs déguisés.",
  "Ta sensibilité est une force, pas une faiblesse.",
  "Il est okay de ne pas avoir toutes les réponses.",
  "Tu grandis même quand tu ne le sens pas.",
  "Ton histoire n'est pas finie.",
  "Être vulnérable demande du courage."
];

const seedDatabase = async () => {
  console.log('🌱 Insertion des phrases dans la base de données...\n');

  try {
    // Vider la table si nécessaire (optionnel)
    // await pool.query('DELETE FROM phrases');

    // Insérer les phrases
    for (const content of phrases) {
      await pool.query(
        'INSERT INTO phrases (content, is_active) VALUES ($1, $2) ON CONFLICT DO NOTHING',
        [content, true]
      );
    }

    console.log(`✅ ${phrases.length} phrases insérées avec succès!`);

    // Afficher le nombre total de phrases
    const result = await pool.query('SELECT COUNT(*) FROM phrases WHERE is_active = true');
    console.log(`📊 Total de phrases actives: ${result.rows[0].count}`);

  } catch (error) {
    console.error('❌ Erreur lors de l\'insertion:', error.message);
  } finally {
    await pool.end();
  }
};

seedDatabase();
