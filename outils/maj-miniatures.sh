#!/bin/bash
# Telecharge les miniatures des videos de _data/realisation.yml
# dans assets/images/realisation/ (Vimeo 1280x720, YouTube maxres)
set -u
cd "/mnt/c/Users/ghorg/Documents/Sites/Simon Bourrat" || exit 1
outdir="assets/images/realisation"
mkdir -p "$outdir"

echo "-> lecture de _data/realisation.yml"
grep -E "^[[:space:]]*-[[:space:]]*id:" _data/realisation.yml | sed -E "s/.*id:[[:space:]]*//" | tr -d "\r" > /tmp/ids.txt

while read -r id; do
  [ -z "$id" ] && continue
  if [[ "$id" =~ ^[0-9]+$ ]]; then
    # Vimeo
    url=$(curl -s --max-time 30 "https://vimeo.com/api/oembed.json?url=https%3A//vimeo.com/$id&width=1280" \
      | python3 -c "import json,sys;
try:
    print(json.load(sys.stdin).get('thumbnail_url',''))
except Exception:
    print('')")
    if [ -z "$url" ]; then
      url="https://vumbnail.com/$id.jpg"
    fi
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
done < /tmp/ids.txt

echo "-> termine"
