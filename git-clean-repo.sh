#!/bin/bash

deleta_branches () {
	IFS=' '
	count=0
	branches_str=$(git branch --column)
	current_branch=$(git branch --show-current)
	
	read -a branches_arr <<< "$branches_str"
	
	echo "Sua branch atual é: $current_branch"
	echo "Deletando branches..."
	
	for bn in "${branches_arr[@]}" 
	do 
		if [ "$bn" != "master" ] && [ "$bn" != "$current_branch" ] && [ "$bn" != "*" ]
		then 
			echo "Deletando: $bn"
			git branch -D "$bn" 
			
			count=$((count+1))
		fi
	done
	
	if [ $count -gt 0 ]
	then
		echo "Total de $count branch(es) deletada(s)!"
	else
		echo "Nenhuma branch pra deletar."
	fi
}

if [ -d ".git" ]
then
	echo "Todas as branchs (com exceção da master e da selecionada) serão apagadas? (y/n)"
	read -p ">" yn

	case $yn in 
		[Yy]*)
			deleta_branches;;
		*)
			echo "Remoção de branches cancelada!";;
	esac
else
	echo "Git não configurado na pasta ativa no terminal!"
fi
