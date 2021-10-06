#!/bin/bash

function contar_caracter() {
	FILE=$(zenity --file-selection --title="Informe o arquivo: ")

        case $? in
                0)
                        echo "$FILE selected."
			saida=$(cat $FILE | grep -o -E '\W|\w' | wc -l)
                        zenity --info --title="Saída" --text="QUANTIDADE DE CARACTERES: $saida"
                        ;;

	esac

MENU
}

function contar_palavras() {
	FILE=$(zenity --file-selection --title="Informe o arquivo: ")

        case $? in
                0)
                        echo "$FILE selected."
			saida=$(cat $FILE | sed -E 's/[^A-Za-z0-9ÀàÁáÂâÃãÉéÊêÍíÓóÔôÕõÚúÇç_-]/ /g' | sed -E 's/[0-9]|//g' | wc -w)
                        zenity --info --title="Saída" --text="QUANTIDADE DE PALAVRAS: $saida"
                        ;;

        esac

MENU
}

function contar_paragrafo() {
	FILE=$(zenity --file-selection --title="Informe o arquivo: ")

        case $? in
                0)
                        echo "$FILE selected."
			saida=$(awk -v RS= '{print ++i}' $FILE | wc -l)
                        zenity --info --title="Saída" --text="QUANTIDADE DE PARAGRAFOS: $saida"
                        ;;

        esac

MENU
}

function contar_letras() {
	FILE=$(zenity --file-selection --title="Informe o arquivo: ")

        case $? in
                0)
                        echo "$FILE selected."
			saida=$(cat $FILE | grep -o -E '[a-zA-Z]' | wc -l)
                        zenity --info --title="Saída" --text="QUANTIDADE DE LETRAS: $saida"
                        ;;

        esac

MENU
}

function contar_num () {
	FILE=$(zenity --file-selection --title="Informe o arquivo: ")

        case $? in
                0)
                        echo "$FILE selected."
			saida=$(cat $FILE | grep -o -E '[0-9]' | wc -l)
                        zenity --info --title="Saída" --text="QUANTIDADE DE NÚMEROS: $saida"
                        ;;

        esac

MENU
}

function palavra_diferente(){
	FILE=$(zenity --file-selection --title="Informe o arquivo: ")

        case $? in
                0)
                        echo "$FILE selected."
			saida=$(cat $FILE | sed 's/[0-9]//g' | egrep -o '\w+' | sort -n -r | uniq -c | wc -l)
                        zenity --info --title="Saída" --text="QUANTIDADE DE PALAVRAS DIFERENTES: $saida"
                        ;;

        esac

MENU
}

function palavra_sub(){
	FILE=$(zenity --file-selection --title="Informe o arquivo: ")

	op1=$(zenity --password --username)

	case $? in
		 0)
			 PALAVRA=$(echo "$op1" | cut -d'|' -f1)
			 PALAVRA2=$(echo "$op1" | cut -d'|' -f2)
			 saida=$(cat $FILE | sed -E "s/$PALAVRA/$PALAVRA2/g")
			 zenity --info --title="Saída" --text="$saida"
		       	 ;;
	esac

MENU
}

MENU()
{
operacao=$(zenity --entry --text "Menu\n
1. LISTAR QTDA DE PALAVRAS: \n
2. LISTAR QTDA DE CARACTERES: \n
3. LISTAR QTDA DE PARÁGRAFOS: \n
4. LISTAR QTDA DE LETRAS: \n
5. LISTAR QTDA DE NÚMEROS: \n
6. LISTAR QTDA DE PALAVRAS DIFERENTES: \n
7. SUBSTITUIR PALAVRAS: \n
8. SAIR" --title "Menu Principal")
case $operacao in
	1)contar_palavras ;;
	2)contar_caracter ;;
	3)contar_paragrafo ;;
	4)contar_letras ;;
	5)contar_num ;;
	6)palavra_diferente ;;
	7)palavra_sub ;;
	8)exit 0 ;;
esac
}
MENU
