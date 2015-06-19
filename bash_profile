# unmount betafiles if it was already mounted
fusermount -uq ~/betafiles
# mount betafiles.mit.edu to ~/betafiles on startup
echo "philisold" | sshfs -o password_stdin oxen@betafiles.mit.edu:/srv/betafiles ~/betafiles


[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
