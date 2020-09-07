#
# ~/.bashrc
#

PS1='[\u \W]\$ '

# Wal colorscheme for new terminals
(cat ~/.cache/wal/sequences &)

# Fish as default shell
if [[ $(ps --no-header --pid=$PPID --format=cmd) != "fish" ]]
then
	exec fish
fi
