#!/usr/bin/env bash
# vim:ts=4:sw=4:expandtab
function temp {
    CORE="${1}"
    OUTPUT=$(sensors -Au)

    IFS=$'\n'
    DATA=$(echo "${OUTPUT}" | egrep -A4 "${CORE}")
    CURRENT=$(echo "${DATA}" | grep -Po "(?<=_input: )([0-9]+)" | head -n1)
    HIGH=$(echo "${DATA}" | grep -Po "(?<=_max: )([0-9]+)" | head -n1)
    #CRIT=$(echo "${DATA}" | grep -Po "(?<=_crit: )([0-9]+)")

    echo "${CURRENT}"

    [[ "${CURRENT}" -gt "${HIGH}" ]] && exit 33
    exit 0
}

echo "  $(temp temp1)"
