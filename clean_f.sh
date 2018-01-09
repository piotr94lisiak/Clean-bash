#!/usr/bin/bash

function helping ()
{
	echo "
	 _____________________________________________________________
	|                                                             |
	|   Program 'clean.bash' służy do porządkowania  katalogów.   |
	|   Wywołanie programu spowoduje  sprawdzenie czy w obecnym   |
	|   katalogu znajdują  się podkatalogi  wymienione w  pliku   |
	|   'clean.sh'. Jeśli podkatalogi nie istnieją to program     |
	|   je utworzy. Kolejnym krokiem jest segregowanie plików z   |
	|   odpowiednimi rozszerzeniami do odpowiednich  katalogów.   |
	|   W każdym katlogu tworzone są  pliki 'log.txt'. Pliki te   |
	|   zawierają informacje na temat daty dodania do katalogów   |
	|   poszczególnych plików. Wszystkie funkcje zapisane są  w   |
	|   pliku clean_f.sh.                                         |  
	|                                                             |
	|                           UWAGA:                            |
	|                                                             |
	|    Program zamienia nazwy plików  gdy  występują  w nich    |
	|    spacje. Znak spacji zamieniany jest na  podkreślenie.    | 
	|    Dodatkowo program nadpisuje pliki o tej samej nazwie.    |
	|_____________________________________________________________|
	"
}

#Segregowanie odpowiednich plików do odpowiednich katalogów.
# $1 - Ścieżka do plików w folderze głównym
# $2 - Nazwa katalogu do którego ma być przeniesiony plik

function move ()
{
if [[ $2 == "Muzyka" ]]
then
	ext=(".mp3" ".mid" ".wav")
elif [[ $2 == "Wideo" ]]
then
	ext=(".avi" ".mp4" ".wmv" ".flv")
elif [[ $2 == "Obrazy" ]]
then
	ext=(".jpg" ".jpeg" ".png" ".gif")
elif [[ $2 == "Dokumenty" ]]
then
	ext=(".doc" ".txt" ".pdf" ".odt")
fi

file_path_length=${#1}

for (( i=0 ; $i < ${#ext[@]} ; i++))
do
	file_path=$1"/*"${ext[i]}
	for files in $file_path
	do
		if [ -e $files ]
		then
			echo -e "     Przenoszenie pliku: ${files:$file_path_length+1} do katalogu $2"
			mv $files $1/$2
			data=`date`
			echo -e "$data: ${files:$file_path_length+1}\r" >> $1/$2/log.txt
		else
			echo "     Nie znaleziono pliku o rozszerzeniu: ${ext[i]}"
		fi
	done
done
}

#Zamiana wszystkich spacji na podkreślenia.
#Brak argumentów

function space 
{
find . -name "* *" | while read; do
  mv "$REPLY" "${REPLY// /_}"
done
}

#Sprawdzenie istnienia określonego katalogu i tworzenie go w przypadku jego braku.
# $1 - Ścieżka do plików w folderze głównym
# $2 - Nazwa tworzonego katalogu

function folder () 
{
if [ -d $1/$2 ]
then
	echo -e "\nKatalog $2 istnieje"
else
	echo -e "\nTworzenie katalogu $2"
	mkdir $2
fi
}

#Sprawdzenie istnienia pliku log.txt w określonym katalogu i tworzenie go w przypadku jego braku.
# $1 - Ścieżka do plików w folderze głównym
# $2 - Nazwa tworzonego katalogu

function log ()
{
if [ -e $1/$2/log.txt ]
then
	if [ -s $1/$2/log.txt ]
	then 
		echo "Plik log.txt istnieje"
		echo ""
	else
		echo "Plik log.txt jest pusty. Nadpisuje..."
		rm $1/$2/log.txt
		log "$1" "$2"
	fi
else
	echo "Tworzenie pliku log.txt w katalogu $2"
	touch log.txt
	data=`date`
	echo -e "Utworzenie pliku log.txt: $data\r" >> $1/$2/log.txt
	echo -e "\r" >> $1/$2/log.txt
	echo ""
fi
}
