#!/bin/bash
#
# This file is part of harbour-parkingchaos.
# SPDX-FileCopyrightText: 2020-2022  Mirian Margiani
# SPDX-License-Identifier: GPL-3.0-or-later
#

db="levels-pmc.db"
out="../data/levels.json"

if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    cat <<EOF
Import levels from ParkMeeCrazy to harbour-parkingchaos.

Usage: convert.sh [-h|-V]

INPUT: '$db'
    The levels database from PMC with one table named 'levels'
    containing all levels.

    Columns: id, initialState, minMoves

    We only use minMoves and initialState. The latter contains the map:
        --| x,y,o,p,s,color ... |--
    - o: orientation; 0=vertical, 1=horizontal
    - p: player=1, other=0
    - s: size, can be 2 or 3
    - color: a color string, not used

OUTPUT: '$out'
    [
        {
            "minimumMoves" : 5,
            "tiles" : [
                {
                    "isPlayer" : false,
                    "orientation" : 1,
                    "posX" : 0,
                    "posY" : 0,
                    "size" : 2
                },
            ...
        ...
    ...
EOF
    exit 0
elif [[ "$1" == "-V" || "$1" == "--version" ]]; then
    cat <<EOF
This file is part of harbour-parkingchaos.
Copyright (C) 2020-2022  Mirian Margiani
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>.
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.
EOF
    exit 0
fi

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
