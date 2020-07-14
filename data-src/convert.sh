#!/bin/bash
#
# This file is part of harbour-parkingchaos.
# Copyright (C) 2020  Mirian Margiani
#
# harbour-parkingchaos is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# harbour-parkingchaos is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with harbour-parkingchaos.  If not, see <http://www.gnu.org/licenses/>.
#

# OUTPUT:
# [
#    {
#       "minimumMoves" : 5,
#       "tiles" : [
#          {
#             "isPlayer" : false,
#             "orientation" : 1,
#             "posX" : 0,
#             "posY" : 0,
#             "size" : 2
#          },
# ...

db="levels-pmc.db"
out="../data/levels.json"

if [[ ! -f "$db" ]]; then
    echo "$db not found"
    exit 1
fi

tmp="$(mktemp levels-XXXXX.tmp)"
sqlite3 "$db" .dump > "$tmp"

mapfile -t lines < <(sed -E '/^INSERT INTO levels VALUES\(/!d;s/^INSERT INTO levels VALUES\(//g;s/\).$//g;' "$tmp" | \
    sed -E "s/,[a-zA-Z]+[0-9]?[ ']/ /g;s/'/ /g;" |\
    sed -E "s/^[0-9]+,[ ]?//g;" |\
    sed -E 's/^(.*) ,([0-9]+)$/\2 \1/g' |\
    sort -k1n)

rm "$tmp"
echo "[" > "$tmp"

for i in "${lines[@]}"; do
    [[ -z "$i" ]] && continue

    moves="$(echo "$i" | cut -d' ' -f1)"
    mapfile -t tiles < <(echo "$i" | cut -d' ' -f2- | sed 's/ /\n/g')

    printf '{ "minimumMoves": %i, "tiles": [' "$moves" >> "$tmp"

    for t in "${tiles[@]}"; do
        [[ -z "$t" ]] && continue
        mapfile -t fields -d , < <(echo "$t" | sed 's/,/\n/g')
        # 5,0,0,0,3

        if [[ "${fields[3]}" == "1" ]]; then
            player="true"
        else
            player="false"
        fi

        printf '{ "posX": %i, "posY": %i, "orientation": %i, "size": %i, "isPlayer": %s },' "${fields[0]}" "${fields[1]}" "${fields[2]}" "${fields[4]}" "$player" >> "$tmp"
    done

    unset tiles
    printf "]}," >> "$tmp"
done

echo "]" >> "$tmp"

cat "$tmp" | tr -d '\n' | sed 's/},]/}]/g;s/},/},\n/g' | json_pp | sponge "$tmp"
cp "$tmp" "levels.pretty.json" --backup=t
cat "$tmp" | tr -d '\n[:blank:]' | sponge "$tmp"
cp "$tmp" "levels.json" --backup=t
mv "$tmp" "$out" --backup=none
