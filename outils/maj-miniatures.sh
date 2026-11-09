#!/bin/bash
# Telecharge les miniatures de toutes les pages video (realisation, drone, etalonnage)
# dans assets/images/<page>/  (Vimeo 1280x720 via oEmbed, YouTube maxresdefault)
#
# Usage : bash outils/maj-miniatures.sh
# A relancer apres avoir ajoute une video dans un fichier _data/*.yml
set -u
cd "/mnt/c/Users/ghorg/Documents/Sites/Simon Bourrat" || exit 1

for page in realisation drone etalonnage; do
  src="_data/$page.yml"
  [ -f "$src" ] || continue
  outdir="assets/images/$page"
  mkdir -p "$outdir"
  echo "-> $src"

  grep -E "^[[:space:]]*-[[:space:]]*id:" "$src" \
    | sed -E "s/.*id:[[:space:]]*//" | tr -d "\r" > /tmp/sb-ids.txt

  while read -r id; do
    [ -z "$id" ] && continue
    if [[ "$id" =~ ^[0-9]+$ ]]; then
      # Vimeo : oEmbed donne une miniature 1280x720
      url=$(curl -s --max-time 30 \
        "https://vimeo.com/api/oembed.json?url=https%3A//vimeo.com/$id&width=1280" \
        | python3 -c "import json,sys;
try:
    print(json.load(sys.stdin).get('thumbnail_url',''))
except Exception:
    print('')")
      [ -z "$url" ] && url="https://vumbnail.com/$id.jpg"
      dest="$outdir/vimeo-$id.jpg"
    else
      url="https://img.youtube.com/vi/$id/maxresdefault.jpg"
      dest="$outdir/youtube-$id.jpg"
    fi

    if curl -s -f -L --max-time 60 -o "$dest" "$url"; then
      echo "   OK  $dest  ($(wc -c < "$dest") octets)"
    else
      echo "   ECHEC  $id  ($url)"
      rm -f "$dest"
    fi
  done < /tmp/sb-ids.txt
done

echo "-> termine"
