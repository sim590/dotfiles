#
# ~/.bashrc
#-----------


#-----------
# Variables
#-----------
GREEN=$(tput setaf 2)
NORMAL=$(tput sgr0)


# Caractères spéciaux
# ├────
# 
# └────

nom_term="TRON terminal"


#------------
# Fonctions
#------------
ps1_git_branch() {
	
	if git rev-parse --git-dir 1>/dev/null 2>/dev/null; then
		branch=`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`
		#Style by Salem R. 
		PS1="├───[\[${GREEN}\]${branch}\[${NORMAL}\]]─=[\$ "
	else
		PS1="├────=[\$ "
	fi
}

# Entête du terminal
function header()
{
	echo -e "\n┌─$(uname -o) $(uname -r)───── $(date) ───── $nom_term  ─────$(whoami)──┐\n│ \
└────[`pwd`]\n│\n│ $pedobear"
}

#---------------------------------------------
# Permet de changer de répertoire et indiquer 
# le nouveau répertoire de façon à respecter
# le thème du terminal TRON
#---------------------------------------------
function cdpwd()
{
	# Si on veut retourner au répertoire ~
	if [[ -z "$1" ]]; then
		cd "$HOME"
		ret=$?
	else
		cd "$1"
		ret=$?
	fi

	# Si on a bien réussi à changer de répertoire if (( $ret == 0 )); then
	if (( $ret == 0 )); then
		echo "├──────[$(pwd)]──┐"
	fi
}


# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# VARIABLES 
#---------------
#PS1="├───[`git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`]=[\$ "
# Variable PS1 par défaut
#PS1=[\u@\h \W]

#-------
# Alias
#-------
alias ls='ls --color=auto'
alias ll='ls -l'
alias grep='grep --color=auto'
alias ftp='tnftp'
alias cd='cdpwd'
alias clear='clear && header'
alias top='htop'

header
PROMPT_COMMAND="ps1_git_branch"
#. ~/.vim/bundle/powerline/powerline/bindings/bash/powerline.sh

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

