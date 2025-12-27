# Un truc que personne ne m'a jamais dit - API

API REST pour l'application mobile d'affichage de phrases inspirantes.

## 🚀 Installation

```bash
# Installer les dépendances
npm install

# Configurer les variables d'environnement
cp .env.example .env
# Éditer .env avec vos identifiants Neon
```

## 🗄️ Configuration de la base de données

1. Créer une base de données sur [Neon](https://neon.tech)
2. Copier l'URL de connexion dans `.env`
3. Initialiser les tables :

```bash
npm run db:init
```

4. Insérer les phrases de démo :

```bash
npm run db:seed
```

## 🏃 Lancement

```bash
# Mode développement (avec rechargement automatique)
npm run dev

# Mode production
npm start
```

## 📡 Endpoints

### GET /api/phrase/random

Retourne une phrase aléatoire et incrémente le compteur de vues.

**Réponse :**
```json
{
  "id": 5,
  "content": "Tu progresses plus que tu ne le crois."
}
```

### GET /health

Vérifie le statut de l'API.

**Réponse :**
```json
{
  "status": "OK",
  "timestamp": "2024-12-27T10:00:00.000Z"
}
```

## 🌐 Déploiement

### Render / Railway / Fly.io

1. Connecter votre repo GitHub
2. Définir les variables d'environnement :
   - `DATABASE_URL` : URL de connexion Neon
   - `NODE_ENV` : `production`
   - `PORT` : sera défini automatiquement

3. Commande de build : `npm install`
4. Commande de démarrage : `npm start`

## 📁 Structure

```
backend/
├── src/
│   ├── config/
│   │   └── database.js      # Configuration PostgreSQL
│   ├── controllers/
│   │   └── phraseController.js
│   ├── routes/
│   │   └── phraseRoutes.js
│   ├── scripts/
│   │   ├── init-db.js       # Initialisation des tables
│   │   └── seed-db.js       # Insertion des phrases
│   └── index.js             # Point d'entrée
├── .env.example
├── .gitignore
├── package.json
└── README.md
```
