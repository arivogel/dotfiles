# a file of aliases, personalized for my use of the command line

# some custom aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias lh='ls -la ~/ | more' #addition, list hidden/dot files
alias viber='/home/ari/Viber/Viber.sh'
alias edwin='mit-scheme --edit --large'
alias sshcloud='sshfs avogel@cloud3.csail.mit.edu:/afs/csail.mit.edu/u/a/avogel ~/school/6.172/cloud; subl ~/school/6.172/cloud ;ssh avogel@cloud3.csail.mit.edu'
alias afsconnect='umount -l ~/school/6.172/cloud; sshfs avogel@cloud3.csail.mit.edu:/afs/csail.mit.edu/u/a/avogel ~/school/6.172/cloud'
alias get115='rsync -av /media/ari/20CA-2E5D/6.115/ /home/ari/school/6.115/'
alias give115='mv /media/ari/20CA-2E5D/6.115/ /media/ari/20CA-2E5D/6.115old/; rm -r /media/ari/20CA-2E5D/6.115/;rsync -av /home/ari/school/6.115/ /media/ari/20CA-2E5D/6.115/'
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

alias diaryc="mv -v ~/Refl/entries ~/Refl/entries_backup/entries_$(date +%y-%m-%d_%H:%M:%S); diary -c"

alias tv-left="~/code/tvlt1421_ubuntu/thinkvision-set-left.bash on"

alias tv-right="~/code/tvlt1421_ubuntu/thinkvision-set-right.bash on"
alias tv-off="~/code/tvlt1421_ubuntu/thinkvision-set-right.bash off"

alias betafiles='echo "philisold" | sshfs -o password_stdin oxen@betafiles.mit.edu:/srv/betafiles ~/betafiles' 
