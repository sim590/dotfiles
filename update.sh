#--------------------------------------------------------
# File: update.sh    Author(s): Simon DÉSAULNIERS
# Date: 2013-10-10
#--------------------------------------------------------
# Met le répertoire de fichiers cachés à jour.
#--------------------------------------------------------

DIR=/home/simon/dotfiles


update() {
	for file in .*;
	do
		if [[ $file != "." && $file != ".." ]] && ( [ -f ~/$file ] || [ -d ~/$file ] ); then
			if [[ $1 == "in" ]];
			then
				cp -fr ~/$file $DIR
				
			elif [[ $1 == "out" ]]; 
			then
				cp -fr $DIR/* ~/
			fi
		fi
	done
}

update $1
