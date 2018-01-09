#!/usr/bin/bash
source ~/clean_f.sh

if [[ $1 == "--help" ]]
then
helping
exit
fi

#Zapisanie ścieżki porządkowanego katalogu

path=`pwd`

#Zamiana spacji na podkreślenia

space

#Porządkowanie muzyki

folder "$path" "Muzyka"

log "$path" "Muzyka"

move "$path" "Muzyka"

#Porządkowanie filmów

folder "$path" "Wideo"

log "$path" "Wideo"

move "$path" "Wideo"

#Porządkowanie obrazów

folder "$path" "Obrazy"

log "$path" "Obrazy"

move "$path" "Obrazy"

#Porządkowanie dokumentów

folder "$path" "Dokumenty"

log "$path" "Dokumenty"

move "$path" "Dokumenty"