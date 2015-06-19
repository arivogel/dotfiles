#!/bin/bash
#################
#   make.sh
#   A script to create symlinks from the home directory
#   to all dotfiles in the ~/dotfiles directory.
#
#   source: github.com/michaeljsmalley/dotfiles/blob/master/makesymlinks.sh
#################

# Variables to be used in the script
dotdir=~/dotfiles
olddir=~/dotfiles_old   # backup any old dotfiles to this directory



# first backup existing dotfiles
echo -n "Creating $olddir for backup of existing dotfiles"
mkdir -p $olddir
echo "done"

cd $dotdir

for file in *; do
	if [ "$file" != "installdots.sh" ]; then
		echo "Backing up $file to $olddir"
		mv ~/.$file $olddir 2>/dev/null
		echo "Creating symlink for $file at ~/.$file"
		ln -s $dotdir/$file ~/.$file
		if [ "$file" != "vimrc" ]; then
			source ~/.$file
			echo "Sourcing $file"
		fi
	fi
done


