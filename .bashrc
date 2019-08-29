source /global/etc/modules.sh

module load gmake/4.2 git/2.16.2 openssl/1.0.2h gcc/6.2.0 mwdt/2017.06 arcnsim/2018.06 # vim/7.4-el7

# This function as its name says removes desired substrings from PATH
function path_remove {
# Delete path by parts so we can never accidentally remove sub paths
	PATH=${PATH//":$1:"/":"} # delete any instances in the middle
	PATH=${PATH/#"$1:"/} # delete any instance at the beginning
	PATH=${PATH/%":$1"/} # delete any instance in the at the end
}

# Remove all /usr/local/bin & sbin with crap from SNPS IT
# A lot of ages old crap is in there which unexpectedly gets in the way
# so just don't use it ever!
path_remove /usr/local/bin
path_remove /usr/local/sbin
# Remove CWD from PATH, required by Buildroot
path_remove .

# license for mdb
export SNPSLMD_LICENSE_FILE="26585@ru20snpslmd1:26585@us01snpslmd3:26585@us01snpslmd4:26585@us01snpslmd"

# Alias
alias p=python
alias r=invoke_rmate_for_each_file
alias t="tmux a"
alias gaf='git commit -a --amend --no-edit; git push -f origin'
# alias tmux="tmux -2"

# python 2
if [[ `hostname` =~ 'ru20arcgnu' ]]; then
 : #module load python/2.7.15
else
 module load python/3.7.0
fi

if [[ $TMUX ]]; then
		source ~/.tmux-git/tmux-git.sh  # &>/dev/null;
		if [[ `hostname` =~ us01 ]]; then
				export PS1='\[\e[38;5;121m\]\$\[\e[0m\] '
		fi
fi

export PATH=${HOME}/.local/bin/:$PATH:/SCRATCH/verification-node/bin/
export LD_LIBRARY_PATH=${HOME}/.local/lib:$LD_LIBRARY_PATH:/SCRATCH/verification-node/lib/

######################
# History management #
######################

# History file
export HISTFILE=~/.bash_history/bash_history_`hostname`

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth:erasedups

# append to the history file, don't overwrite it
# (otherwise we would lose history of other xterms)
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=50000
HISTFILESIZE=50000
# note: big ~/.bash_history costs in startup time
# (stupid readline O(N**2) "append to end of singly-linked list" algorithm)

# Save the history after every command
# (note: PROMPT_COMMAND is overwritten by bashrc.title)
#PROMPT_COMMAND='history -a'
PROMPT_COMMAND="history -n; history -w; history -c; history -r; $PROMPT_COMMAND"

# powerline-daemon -q
# POWERLINE_BASH_CONTINUATION=1
# POWERLINE_BASH_SELECT=1
# . /SCRATCH/falaleev/local/powerline/powerline/bindings/bash/powerline.sh
