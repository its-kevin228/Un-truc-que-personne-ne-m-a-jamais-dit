# Un truc que personne ne m'a jamais dit

Une application mobile simple, fun et émotionnelle qui affiche des phrases courtes, honnêtes et inspirantes.

![Flutter](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Node.js](https://img.shields.io/badge/Node.js-339933?style=for-the-badge&logo=nodedotjs&logoColor=white)
![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)

## 📱 Fonctionnalités

- ✨ Affichage d'une phrase inspirante au lancement
- 🔄 Bouton pour afficher une nouvelle phrase
- 📋 Copier la phrase dans le presse-papier
- 📤 Partager la phrase
- 🌙 Design mode sombre minimaliste
- 💫 Animations fluides

## 🏗️ Architecture

```
Application Flutter
        |
        v
API REST (Node.js + Express)
        |
        v
Base de données PostgreSQL (Neon)
```

## 📁 Structure du projet

```
Un-truc-que-personne-ne-m-a-jamais-dit/
├── app/                    # Application mobile Flutter
│   ├── lib/
│   │   ├── main.dart
│   │   ├── models/
│   │   ├── screens/
│   │   └── services/
│   └── pubspec.yaml
│
└── backend/               # API Node.js/Express
    ├── src/
    │   ├── config/
    │   ├── controllers/
    │   ├── routes/
    │   └── scripts/
    └── package.json
```

## 🚀 Installation

### Backend (API)

```bash
cd backend
npm install
cp .env.example .env
# Configurer DATABASE_URL avec vos identifiants Neon

# Initialiser la base de données
npm run db:init
npm run db:seed

# Lancer le serveur
npm run dev
```

### Frontend (Flutter)

```bash
cd app
flutter pub get
flutter run
```

## 🗄️ Base de données

### Table `phrases`
| Champ | Type | Description |
|-------|------|-------------|
| id | SERIAL | Identifiant unique |
| content | TEXT | Contenu de la phrase |
| is_active | BOOLEAN | Phrase active ou non |
| created_at | TIMESTAMP | Date d'ajout |

### Table `app_stats`
| Champ | Type | Description |
|-------|------|-------------|
| id | INT | Identifiant (valeur fixe = 1) |
| total_views | INT | Nombre total d'affichages |
| last_view_at | TIMESTAMP | Dernière utilisation |

## 📡 API

### GET /api/phrase/random

Retourne une phrase active aléatoire et incrémente le compteur.

```json
{
  "id": 5,
  "content": "Tu progresses plus que tu ne le crois."
}
```

## 📝 License

MIT
