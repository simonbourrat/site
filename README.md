# Simon Bourrat Website

A Jekyll-based website with Gulp for asset optimization.

## Getting Started

### Prerequisites

Ensure you have the following installed:
- [Ruby](https://www.ruby-lang.org/en/downloads/) (version compatible with Gemfile, e.g., 2.4+)
- [Node.js](https://nodejs.org/) (version compatible with Gulp 3.x, e.g., 10 or 12 is recommended for older Gulp versions)
- [Bundler](https://bundler.io/) (`gem install bundler`)

### Installation

1. Clone the repository.
2. Install Ruby dependencies:
   ```bash
   bundle install
   ```
3. Install Node.js dependencies:
   ```bash
   npm install
   ```

### Available Scripts

In the project directory, you can run:

#### `npm run serve`
Runs the Jekyll server locally at `http://localhost:4000`.

#### `npm run build`
Builds the website for production. It generates the site using Jekyll and then runs Gulp to optimize assets (minification, revisioning, etc.) in the `_site/` directory.

#### `npm run preview`
Builds the website and starts a local server to preview the production-ready build at `http://localhost:4000`.

## Comment ajouter une photo à la galerie

La galerie photo (`photographie.html`) se met à jour automatiquement à partir des fichiers images présents dans le dossier `assets/images/gallery/`.

Il n'y a pas de fichier de configuration : c'est le contenu du dossier qui détermine ce qui s'affiche.

### Convention de nommage

Les fichiers doivent être nommés avec un **nombre entier** suivi de `.jpg`. Les photos sont triées par ordre croissant de ce numéro.

Les numéros actuels utilisent des milliers pour organiser les photos par groupes :
- `1000.jpg`, `2000.jpg`, `3000.jpg` ...
- Pour insérer une photo entre deux existantes, utiliser un numéro intermédiaire (ex: entre `5000.jpg` et `6000.jpg`, utiliser `5100.jpg`, `5200.jpg`, etc.)

Pour trouver le bon numéro, regarder les fichiers existants dans `assets/images/gallery/` et choisir un numéro qui place la photo à l'endroit voulu dans le tri.

### Étapes

1. **Préparer l'image originale** : l'image doit être au format JPG.

2. **Créer la miniature** : créer une version réduite de l'image (largeur recommandée : ~800px). Elle doit avoir **exactement le même nom** que l'image originale.

3. **Placer les fichiers** :
   - L'image en taille réelle dans `assets/images/gallery/` (ex: `46000.jpg`)
   - La miniature dans `assets/images/thumb/` (ex: `46000.jpg`)

4. **Publier** : commit et push les deux fichiers. Le site se régénère et la photo apparaît.

### Supprimer une photo

Supprimer le fichier correspondant dans `assets/images/gallery/` **et** dans `assets/images/thumb/`, puis commit et push.