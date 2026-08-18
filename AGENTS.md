# Agent: simonbourrat.com

## Projet

Site portfolio personnel de **Simon Bourrat**, opérateur de prise de vue drone et réalisateur vidéo basé en France.
- **URL live :** https://www.simonbourrat.com
- **Déploiement :** Push sur GitHub → Netlify prend le relai (auto-build)
- **Pas d'autres environnements** (pas de staging, pas de dev distant)

## Stack technique

| Couche | Technologie | Version |
|---|---|---|
| Générateur statique | Jekyll | 3.7.2 (en production) |
| Build CSS | SCSS/Sass | via Jekyll |
| Post-build | Gulp | 3.9.1 |
| CSS framework | Bootstrap | 3.x |
| JS | jQuery | - |
| Vidéo | Vimeo (embed + player jQuery) | - |
| Analytics | Google Analytics | UA-111654327-1 |
| Formulaires | Netlify Forms | - |
| Hébergement | Netlify | - |

## Structure du projet

```
site/
├── _config.yml          # Config Jekyll (theme minima, kramdown)
├── Gemfile              # Ruby deps (jekyll 3.7.2, minima ~> 2.0)
├── package.json         # Node deps (gulp, flightplan)
├── gulpfile.js          # Tâches Gulp (compress JS/CSS, fonts, rev)
├── _layouts/
│   ├── base.html        # Layout principal (head, navbar, footer, analytics)
│   └── page.html        # Wrapper (extends base, ajout .main)
├── _includes/
│   ├── navlist.html     # Liens navigation (4 items + actu commented)
│   ├── stylesheets.html # CSS vendor + fonts
│   ├── javascript.html  # JS vendor + app
│   └── favicon.html     # Favicons multi-formats
├── _data/
│   ├── contact.yml      # Email, téléphone, citation
│   ├── drone.yml        # 5 vidéos drone (Vimeo IDs)
│   └── realisation.yml  # 13 vidéos réalisations (Vimeo IDs)
├── _sass/               # 26 partials SCSS
├── assets/
│   ├── main.scss        # Point d'entrée SCSS (imports tous les partials)
│   ├── fonts/           # ET-Line icon font
│   ├── js/
│   │   ├── main.js      # Script principal (~831 lignes)
│   │   └── plugins.js   # jQuery.appear + countTo
│   ├── lib/             # 23 libs (bootstrap, jquery, magnific-popup, isotope...)
│   └── images/
│       ├── gallery/     # 48 photos full-size (noms numériques)
│       ├── thumb/       # 48 thumbnails
│       ├── logo/        # 4 variantes du logo SVG/PNG
│       └── contact_bg.jpg
├── index.html           # Landing page (video Vimeo bg, logo, bouton "Entrer")
├── realisation.html     # 13 vidéos embed (layout alterné gauche/droite)
├── drone.html           # 5 vidéos drone (layout alterné)
├── photographie.html    # Galerie masonry 48 photos + lightbox (Magnific Popup)
├── contact.html         # Formulaire Netlify + infos contact
└── 404.html             # Page d'erreur
```

## Pages

| Page | URL | Description |
|---|---|---|
| Landing | `/` | Video Vimeo en fond (ID: 243136203), logo blanc SVG, bouton "Entrer" → /realisation |
| Réalisations | `/realisation` | 13 vidéos Vimeo embed, données dans `_data/realisation.yml` |
| Drone / OPV | `/drone` | 5 vidéos drone, données dans `_data/drone.yml` |
| Photographie | `/photographie` | Galerie masonry auto-générée depuis `assets/images/gallery/` |
| Contact | `/contact` | Formulaire Netlify (honeypot anti-spam), email + téléphone depuis `_data/contact.yml` |

## URLs de navigation

Les liens utilisent des **clean URLs** sans `.html` :
- `/drone`
- `/realisation`
- `/photographie`
- `/contact`

## Données (_data/)

- **realisation.yml** : 13 entrées `{ id, titre, description }` — IDs Vimeo
- **drone.yml** : 5 entrées `{ id, titre, description }` — IDs Vimeo
- **contact.yml** : `email`, `phone.number`, `phone.display`, `quote`

## Build & Serve local

### Prérequis
- Ruby 3.3+ avec Bundler
- Node.js 22+

### Installation
```bash
# Installer les gems Ruby (besoin de sudo pour ruby-bundler si pas installé)
gem install bundler -v '< 3'
bundle config set --local path ~/gems-cache
bundle install

# Installer les deps Node (besoin de --ignore-scripts --no-bin-links sur WSL/Windows)
npm install --ignore-scripts --no-bin-links
```

### Lancer le serveur
```bash
export PATH="$HOME/.local/share/gem/ruby/3.3.0/bin:$PATH"
export GEM_HOME="$HOME/.local/share/gem/ruby/3.3.0"
bundler exec jekyll serve --host 0.0.0.0 --port 4000
```

### Build pour production
```bash
bundler exec jekyll build --destination /tmp/jekyll-site
# Puis post-traitement Gulp :
gulp
```

## Incompatibilités connues

### Jekyll 3.7.2 + Ruby 3.3
- Les layouts produisent des fichiers HTML **vides** (erreur "no implicit conversion of Hash into Integer")
- **Solution locale** : Upgrader Jekyll à `~> 4.3` dans le Gemfile pour le dev local
- **En production** (Netlify) : Ruby et Jekyll versions anciennes, pas ce problème
- **Ne pas commit le Gemfile avec Jekyll 4** — c'est juste pour le dev local

### WSL + Windows
- Le filesystem `/mnt/c/` ne supporte pas `chmod`/`utime` → `npm install` nécessite `--ignore-scripts --no-bin-links`
- Les gems Ruby ne peuvent pas s'installer dans `/var/lib/gems/` → utiliser un path local (`~/gems-cache`)
- Le port 9222 de Chrome debug n'est pas accessible depuis WSL → utiliser Playwright avec Chromium installé dans WSL (`npx playwright install chromium` + `sudo npx playwright install-deps chromium`)

### Serveur local
- Python SimpleHTTPServer ne gère pas les clean URLs → utiliser un serveur Node.js custom ou `jekyll serve`
- Les embeds Vimeo retournent 401 en headless → normal, ça marche dans un vrai navigateur

## Gulp (post-build)

Le `gulpfile.js` fait 2 choses sur le `_site/` généré :
1. **compress** : Minifie JS (uglify), CSS (clean-css), ajoute cache-busting (rev), traite les CSS inline
2. **fonts** : Copie les polices depuis `assets/lib/` vers `_site/fonts/`

## Design

### Palette (depuis `_sass/_colors.scss`)
- `$io-blue: #262e32` (couleur principale dark)
- `$io-red: #ff4d46`
- `$io-gray-blue: #839eac`
- `$io-clear-blue: #e8f1f5`
- `$io-orange: #ffa467`
- `$main-white: #fffbf1`

### Polices
- **Roboto Condensed** (400, 700) — navbar, titres
- **Volkhov** — accents italiques
- **Open Sans** (300-800) — corps de texte
- **ET-Line** — icônes (enveloppe, téléphone, etc.)

### Navbar
- Fixe en haut, blanche avec opacité
- Logo SVG + "Simon Bourrat" + "Operateur de prise de vue"
- Transition transparent → opaque au scroll
- Masquée sur la landing page (`hidenav: true`)

## Fichiers exclus du build Jekyll

Dans `_config.yml` :
- `node_modules/`
- `psd/`
- `Gemfile`, `Gemfile.lock`
- `gulpfile.js`
- `flightplan.js`

## Notes

- **Section "Actu"** : Commentée dans la nav, pas encore développée
- **flightplan.js** : Référencé dans package.json mais absent du repo (outil de dépôt abandonné ?)
- **Google Analytics** : Universal Analytics (UA-*), pas GA4 — hérité de l'ancien setup
- **manifest.json** : Référence des icônes Android absentes du repo — PWA incomplète
- **README** : Note 2 TODO : "Realisation: mobile flow" et "Drone: intercalated videos"
