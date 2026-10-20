#!/bin/bash
# Sauvegarde automatique de l'etat du site Simon Bourrat
# Usage: ./sauvegarder.sh "description du changement"
#
# Ce script:
#   1. Enregistre toutes les modifications en cours
#   2. Cree un point de restauration (commit) avec un message lisible
#   3. Affiche l'historique des sauvegardes

cd "/mnt/c/Users/ghorg/Documents/Sites/Simon Bourrat" || exit 1

MESSAGE="$1"

if [ -z "$MESSAGE" ]; then
  echo "ERREUR: il faut decrire le changement."
  echo "Exemple: ./sauvegarder.sh \"logo plus petit\""
  exit 1
fi

# Rien a sauvegarder ?
if [ -z "$(git status --porcelain)" ]; then
  echo "Aucune modification a sauvegarder. Le site est deja a jour."
  exit 0
fi

echo "=== Fichiers modifies ==="
git status --short
echo ""

git add -A
git commit -m "$MESSAGE" > /dev/null 2>&1

if [ $? -eq 0 ]; then
  echo "=== Sauvegarde OK ==="
  echo "Point de restauration: $(git log --oneline -1)"
  echo ""
  echo "=== Historique des sauvegardes ==="
  git log --oneline -10
else
  echo "ERREUR: la sauvegarde a echoue."
  exit 1
fi
