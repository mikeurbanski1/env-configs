# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/mikeurbanski/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
HIST_STAMPS="yyyy-mm-dd"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(brew git docker docker-compose docker-machine kubectl python aws)

source $ZSH/oh-my-zsh.sh

# echo "done with plugins"

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

ZRC=~/.zshrc

export GPG_TTY=$(tty)
export HOME=/Users/mikeurbanski


### PROMPT SETUP

# GIT PROMPT
# http://www.jukie.net/~bart/blog/20071219221358
#PROMPT=%(?:%{%}➜ :%{%}➜ ) %{$fg[cyan]%}%c%{$reset_color%} $(git_prompt_info)
typeset -ga preexec_functions
typeset -ga precmd_functions
typeset -ga chpwd_functions

setopt prompt_subst

parse_git_branch() {
	git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'
}

# This was a failed attempt to try to only update the git prompt after it might've changed, but it's fundamentally broken,
# because commands to change git prompts or things like that will invalidate what was previously set.
# if [[ ${preexec_functions[(ie)zsh_preexec_update_git_vars]} -gt ${#preexec_functions} ]]; then
# 	preexec_functions+='zsh_preexec_update_git_vars'
# fi

# zsh_preexec_update_git_vars() {

# 	# local found_git=false
#  #    case "$(history $HISTCMD | cut -d ' ' -f 8-)" in 
#  #        git*)
# 	# 	;&
#  #        co*)
# 	# 	;&
# 	# 	commit*)
# 	# 	;&
# 	# 	add*)
# 	# 	;&
# 	# 	fp*)
# 	# 	;&
# 	# 	newbranch*)
# 	# 	;&
# 	# 	status*)
# 	# 	;&
# 	# 	gitpush*)
# 	# 	# echo "git command"
# 	# 	zsh_chpwd_update_git_vars
# 	# 	found_git=true
# 	# 	echo "found git in first try"
# 	# 	;;
#  #    esac

#  #    if [[ "$found_git" != "true" ]]; then
#  #    	case "$(history $(expr $HISTCMD - 1) | head -n 1 | cut -d ' ' -f 8-)" in 
# 	#         git*)
# 	# 		;&
# 	#         co*)
# 	# 		;&
# 	# 		commit*)
# 	# 		;&
# 	# 		add*)
# 	# 		;&
# 	# 		fp*)
# 	# 		;&
# 	# 		newbranch*)
# 	# 		;&
# 	# 		status*)
# 	# 		;&
# 	# 		gitpush*)
# 	# 		# echo "git command"
# 	# 		zsh_chpwd_update_git_vars
# 	# 		found_git=true
# 	# 		;;
# 	#     esac
# 	# fi
# }

# chpwd_functions+='zsh_chpwd_update_git_vars'
# zsh_chpwd_update_git_vars() {
#     export __CURRENT_GIT_BRANCH="$(parse_git_branch)"

#     if [[ -z "$__CURRENT_GIT_BRANCH" ]]; then return; fi

#     export __GIT_STAGED_COUNT=$(git diff --staged --name-status | wc -l | trim)
#     export __GIT_UNSTAGED_COUNT=$(git diff --name-status | wc -l | trim)
#     export __GIT_UNTRACKED_COUNT=$(git status --porcelain | grep '^??' | wc -l | trim)
# }

get_git_prompt_info() {

	local __CURRENT_GIT_BRANCH="$(parse_git_branch)"

	if [[ -z "$__CURRENT_GIT_BRANCH" ]]; then
		> ~/.prompt_info <<< "__GIT_PROMPT_LENGTH=0"
		echo ""
		return
	fi

	# local __GIT_STAGED_COUNT=$(git diff --staged --name-status | wc -l | trim)
 #    local __GIT_UNSTAGED_COUNT=$(git diff --name-status | wc -l | trim)
 #    local __GIT_UNTRACKED_COUNT=$(git status --porcelain | grep '^??' | wc -l | trim)

 	local staged_count=0
 	local unstaged_count=0
 	local unmerged_count=0
 	local untracked_count=0
 	local total_count=0

 	local promptLength=$(expr 3 + ${#__CURRENT_GIT_BRANCH}) # 3 for (|)

 	local prompt_str="%{$fg_bold[white]%}(%{$fg_bold[magenta]%}$__CURRENT_GIT_BRANCH%{$fg_bold[white]%}|"

 	git status --porcelain | cut -c1-2 | {IFS=''; while read -r L; do

	 		if [[ "$L[2]" == "M" ]]; then
	 			unstaged_count=$(expr $unstaged_count + 1)
	 			total_count=$(expr $total_count + 1)
	 		elif [[ "$L[1]" == "U" ]]; then
	 			unmerged_count=$(expr $unmerged_count + 1)
	 			total_count=$(expr $total_count + 1)
	 		elif [[ "$L[1]" == "M" || "$L[1]" == "A" ]]; then
	 			staged_count=$(expr $staged_count + 1)
	 			total_count=$(expr $total_count + 1)
	 		elif [[ "$L" == "??" ]]; then
	 			untracked_count=$(expr $untracked_count + 1)
	 			total_count=$(expr $total_count + 1)
	 		else
	 			echo "Unexpected git status combination: $L" 1>&2;
	 		fi

	 	done
	}

	if [[ $total_count == 0 ]]; then
		prompt_str+="%{$fg_bold[green]%}✔"
		promptLength=$(expr $promptLength + 1)
	else
		if [[ $staged_count != 0 ]]; then
			prompt_str+="%{%F{161}%}"'●'$staged_count
			promptLength=$(expr $promptLength + 1 + ${#staged_count})
		fi

		if [[ $unmerged_count != 0 ]]; then
			prompt_str+="%{%F{214}%}"'✖'$unmerged_count
			promptLength=$(expr $promptLength + 1 + ${#unmerged_count})
		fi

		if [[ $unstaged_count != 0 ]]; then
			prompt_str+="%{%F{039}%}"'✚'$unstaged_count
			promptLength=$(expr $promptLength + 1 + ${#unstaged_count})
		fi

		if [[ $untracked_count != 0 ]]; then
			prompt_str+="%{$reset_color%}+$untracked_count"
			promptLength=$(expr $promptLength + 1 + ${#untracked_count})
		fi
	fi

	# echo "__GIT_PROMPT_LENGTH=$promptLength" 1>&2;
	> ~/.prompt_info <<< "export __GIT_PROMPT_LENGTH=$promptLength"
	# export __GIT_PROMPT_LENGTH=$promptLength
    
    echo "$prompt_str%{$fg_bold[white]%})"
}

get_aws_prompt_info() {

	if [[ -n "$AWS_CUSTOMER" ]]; then
		local acctName=CUST
	elif [[ -n "$AWS_PROFILE" ]]; then
		local acctName=$AWS_PROFILE
	else
		local acctName=dev
	fi

	if [[ $acctName == CUST ]]; then
		local clr=196
	elif [[ $acctName == prod ]]; then
		local clr=202
	else
		local clr=220
	fi

	local promptLength=$(expr 6 + ${#acctName})
	# echo "__AWS_PROMPT_LENGTH=$promptLength" 1>&2;
	>> ~/.prompt_info <<< "export __AWS_PROMPT_LENGTH=$promptLength"

	# export __AWS_PROMPT_LENGTH=$promptLength

	echo "%{%F{220}%}(aws:%{%F{$clr}%}$acctName%{%F{220}%})"
}

get_truncated_wd() {
	local maxlen=$1
	local curdir=${2:-$(print -P %~)}
	# echo "$2"
	# echo "Curdir: $curdir"
	# echo "Max len: $maxlen"

	if [[ "$curdir" == "/" ]]; then
		echo "/"
		return
	elif [[ "$curdir" == '~' || "$curdir" == "$HOME" ]]; then
		echo '~'
		return
	fi

	local curlen=0
	local dirstr=''

	while true; do
		local base=`basename $curdir`

		# If we make it this far, then we know we have room for one more character.
		if [[ "$base" == "/" ]]; then
			# Actually nothing to do here, since we already added the leading slash last iteration
			break
		elif [[ "$base" == '~' || "$base" == "$HOME" ]]; then
			dirstr='~'"$dirstr"
			curlen=`expr 1 + $curlen`
			break
		fi
		local newlen=`expr 1 + $curlen + ${#base}`
		# echo "newlen: $newlen"

		# using >= accounts for the extra 1 character that we would add
		if [[ $newlen -ge $maxlen ]]; then

			# We do need to check if we happen to now be at root
			if [[ $newlen == $maxlen && `dirname $curdir` == '/' ]]; then
				# echo "we just barely made it!"
			else
				# echo "new dir str is too long"
				dirstr="…$dirstr"

				# If we can fit it, add a leading / or ~
				if [[ ${#dirstr} -lt $maxlen ]]; then
					if [[ "$curdir" == '~'* || "$curdir" == "$HOME"* ]]; then
						# if STILL smaller, then add / after ~
						if [[ ${#dirstr} -lt `expr $maxlen - 1` ]]; then
							dirstr='~/'"$dirstr"
						else
							dirstr='~'"$dirstr"
						fi
					elif [[ "$curdir" == '/'* ]]; then
						dirstr='/'"$dirstr"
					fi
				fi
				break
			fi
		fi

		dirstr="/$base$dirstr"
		# echo "New dirstr: $dirstr"
		curdir=`dirname $curdir`
		# echo "New curdir: $curdir"
		curlen=$newlen
	done

	# echo "dir: $dirstr"
	# echo "len: ${#dirstr}"
	echo "$dirstr"
}

get_wd_prompt() {
	# 2 for the Check/X plus space, 1 for the space before git/aws
	local promptLength=$(expr 3 + $__AWS_PROMPT_LENGTH + $__GIT_PROMPT_LENGTH)
	# echo "$promptLength" 1>&2;

	local maxlen=`expr $COLUMNS - $promptLength`
	# local curdir=`print -P %~`
	# local wdlen=0
	# while true; do
	# 	local base=`basename $curdir`
	# 	local newlen=`expr $wdlen + ${#base}`

	# done

	# echo $(expr $__AWS_PROMPT_LENGTH + $__GIT_PROMPT_LENGTH)
	get_truncated_wd $maxlen
}

create_custom_prompt() {
	__GIT_PROPT_STR=$(get_git_prompt_info)
	__AWS_PROMPT_STR=$(get_aws_prompt_info)
	eval $(cat ~/.prompt_info)

	echo "%(?:%{$fg_bold[green]%}✓ :%{$fg_bold[red]%}✖ )%{$fg[cyan]%}$(get_wd_prompt) %{$reset_color%}$__GIT_PROPT_STR$__AWS_PROMPT_STR\n%{$fg_bold[white]%}>> %{$reset_color%}"
}

PROMPT='$(create_custom_prompt)'

# PROMPT='%(?:%{$fg_bold[green]%}✓ :%{$fg_bold[red]%}✖ )%{$fg[cyan]%}%~% $(get_wd_prompt) {$reset_color%} $__GIT_PROPT_STR$__AWS_PROMPT_STR
# %{$fg_bold[white]%}>> %{$reset_color%}'

# rm ~/.prompt_info

export PYTHONSTARTUP=/Users/mikeurbanski/misc/python_test/startup.py

#################################### Work Stuff ###########################

PLATFORM=$HOME/platform/platform
PROWLER=$HOME/platform/prowler
CHECKOV=$HOME/platform/checkov
DEVTOOLS=$PLATFORM/devTools

set-user-org() {
	if [[ -z "$1" ]]; then
		echo "No org specified"
		return
	fi
	echo "Setting mike@bridgecrew.io to $1"
	# redacted command
}

list-accounts() {
	if [[ -z "$1" ]]; then
		echo "No org specified"
		return
	fi
	# redacted command
}

assume-customer-role() {
	if [[ -z "$1" ]]; then
		echo "No account specified"
		return
	fi
	# redacted command
	aws sts get-caller-identity
	export AWS_CUSTOMER=$1
}

alias dev="aws-profile dev"

#################################### Aliases ####################################

########## Misc. terminal ##########
alias SRC="source $ZRC"
alias small="open ~/Documents/Terminal\ settings/Basic\ -\ Small.terminal"
alias sublime="open -a Sublime\ Text"
alias chrome="open -a Google\ Chrome"
alias fullpath="realpath"
alias ll="ls -lah"
alias lr="ls -lAtrh"
alias lt="ls -lAth"

########## Python ##########
alias activate="venv_activate"
alias venv="virtualenv venv && venv_activate"

########## git ##########
alias status="git status"
alias newbranch="git checkout -b"
alias co="git checkout"
alias fp="git fetch && git pull"

########## curl ##########
alias cpost="curl -X POST"
alias cpostjson="curl -X POST -H \"Content-Type: application/json\" -d"
alias cdelete="curl -X DELETE"

alias trim="awk '{"'$1=$1}'";1'"

########## AWS ##########
alias tf="terraform"
alias REDACTED="aws-profile REDACTED"

########## Kubernetes ##########
alias kubectl-prod="kubectl --context='REDACTED'"
alias kubectl-stage="kubectl --context='REDACTED'"
alias kget="kubectl get"
alias kdelete="kubectl delete"
alias kapply="kubectl apply -f"
alias kgetservice="kubectl get service"
alias kgetpod="kubectl get pod"
alias kgeting="kubectl get ingress"
alias kgetpods="kubectl get pod"
alias kgetdepl="kubectl get deployment"
alias kgetall="kubectl get all"
alias kexec="kubectl exec"
alias klogs="kubectl logs"
alias ktail="klogs -f --tail=1"
alias kedit="kubectl edit"
alias kdesc="kubectl describe"
alias k="kubectl"
alias kcfg="kubectl config"
alias kctx="kubectl config use-context"
alias kconfx="export KUBECONFIG=/Users/mikeurbanski/.kube/x-config"
alias kpai="kconfx" # when I am REALLY lazy
alias kconflocal="export KUBECONFIG=/Users/mikeurbanski/.kube/config"
KUBE_BASH=(--stdin --tty -- /bin/bash) # use with kexec to get interactive shell
KUBE_SH=(--stdin --tty -- /bin/sh)

# This allows `tree` to use colors
eval $(gdircolors)

#################################### Functions ####################################

########## Misc. terminal ##########

changenew() { # Change to the newest directory
	cd $(ls -1 -tr | tail -1)
}

newestdir() { # Print the name of the newest directory
	ls -1 -tr -d */ | tail -1
}

mc() { # Make a directory and change to it
	mkdir -p $1
	cd $1
}

setsecretvar() {
	read -rs "$1?Enter $1: "
}

function awkcut() {

	while [[ -n "$1" ]]; do
		if [[ "$1" == "-f" ]]; then
			shift
			__FIELD="$1"
		fi

		if [[ "$1" == "-d" ]]; then
			shift
			__DELIM="$1"
		fi

		shift
	done

	awk -F "$__DELIM" '{print $'"$__FIELD"'}'
}

function sortinplace() {
	sort $1 >> .__tmp
	cat .__tmp > $1
	rm .__tmp
}

function encode() {
	echo -n "$1" | base64
}

function decode() {
	echo -n "$1" | base64 -D
}

########## Python ##########

pyscript() {
	local CMD=$(echo $1 | sed -e 's/\//./g' | sed -e 's/.py//')
	shift
	python -m $CMD $*
}

########## Git ##########

commit() {
	if [[ "$1" == "-m" ]]; then
		shift
	fi
	
	git commit -S -m "$1"
}

add() {
	if [[ -n "$1" ]]; then
		git add $*
	else
		git add .
	fi
}

gitpush() {
	git push origin $(git branch | grep '*' | cut -b 3-)
}

########## AWS ##########

unset-aws() {
	unset AWS_ACCESS_KEY_ID
	unset AWS_SECRET_ACCESS_KEY
	unset AWS_SESSION_TOKEN
	unset AWS_DEFAULT_PROFILE
	unset AWS_PROFILE
	unset AWS_CUSTOMER

	if [[ "$1" != "silent" ]]; then
		aws sts get-caller-identity
	fi
}

aws-profile() {
	unset-aws silent

	export AWS_PROFILE=$1
	export AWS_DEFAULT_PROFILE=$1

	if [[ "$2" != "silent" ]]; then
		aws sts get-caller-identity
	fi
}

aws-auth-simple() {
	if [[ -n "$1" ]]; then
		export AWS_PROFILE="$1"
	fi

	if [[ -z "$AWS_PROFILE" ]]; then
		echo "Using default AWS profile."
		export AWS_PROFILE=default
	else
		echo "Using $AWS_PROFILE"
	fi

	read -r "__OTP?Enter OTP: "

	if [[ "$1" == "REDACTED" ]]; then
		__SERIAL="$AWS_MFA_KEY_REDACTED"
	else
		__SERIAL="AWS_MFA_KEY_default"
	fi

	echo $__SERIAL

	__OUTPUT=`aws sts get-session-token --serial-number "$__SERIAL" --token-code $__OTP`

	export AWS_ACCESS_KEY_ID=`echo $__OUTPUT | grep AccessKeyId | cut -f 4 -d '"'`
	export AWS_SECRET_ACCESS_KEY=`echo $__OUTPUT | grep SecretAccessKey | cut -f 4 -d '"'`
	export AWS_SESSION_TOKEN=`echo $__OUTPUT | grep SessionToken | cut -f 4 -d '"'`

	echo $__OUTPUT
	
}

set_aws() {
	read -r "AWS_ACCESS_KEY_ID?Enter access key: "
	read -r -s "AWS_SECRET_ACCESS_KEY?Enter secret: "
	read -r "AWS_SESSION_TOKEN?Enter session token: "

	export AWS_ACCESS_KEY_ID
	export AWS_SECRET_ACCESS_KEY
	export AWS_SESSION_TOKEN

	aws sts get-caller-identity
}
alias set-aws="set_aws"

parse_aws() {
	while read LINE; do
		if [[ "$LINE" == *AccessKeyId* ]]; then
			echo $LINE
			export AWS_ACCESS_KEY_ID=`echo $LINE | cut -f 4 -d '"'`
		elif [[ "$LINE" == *SecretAccessKey* ]]; then
			echo $LINE
			export AWS_SECRET_ACCESS_KEY=`echo $LINE | cut -f 4 -d '"'`
		elif [[ "$LINE" == *SessionToken* ]]; then
			echo $LINE
			export AWS_SESSION_TOKEN=`echo $LINE | cut -f 4 -d '"'`
		fi
	done
}
alias parse-aws="parse_aws"

function help() {
	if [[ -z "$1" ]]; then
		echo "replace"
		echo "conditionals"
	elif [[ "$1" == "replace" ]]; then
		echo "Replace first: !!:s/old/new/ or ^old^new^"
		echo "Replace all: !!:gs/old/new/"
		echo "Can stack: !!:gs/old1/new1/:s/old2/new2/"
	elif [[ "$1" == "conditionals" ]]; then
		echo "-a file		true if file exists."
		echo "-b file		true if file exists and is a block special file."
		echo "-c file		true if file exists and is a character special file."
		echo "-d file		true if file exists and is a directory."
		echo "-e file		true if file exists."
		echo "-f file		true if file exists and is a regular file."
		echo "-g file		true if file exists and has its setgid bit set."
		echo "-h file		true if file exists and is a symbolic link."
		echo "-k file		true if file exists and has its sticky bit set."
		echo "-n string	true if length of string is non-zero."
		echo "-o option 	true if option named option is on."
		echo "-p file		true if file exists and is a FIFO special file (named pipe)."
		echo "-r file		true if file exists and is readable by current process."
		echo "-s file		true if file exists and has size greater than zero."
		echo "-t fd		true if file descriptor number fd is open and associated with a terminal device"
		echo "-u file		true if file exists and has its setuid bit set."
		echo "-v varname	true if shell variable varname is set."
		echo "-w file		true if file exists and is writable by current process."
		echo "-x file		true if file exists and is executable by current process. If file exists and is a directory, then the current process has permission to search in the directory."
		echo "-z string	true if length of string is zero."
		echo "-L file		true if file exists and is a symbolic link."
		echo "-O file		true if file exists and is owned by the effective user ID of this process."
		echo "-G file		true if file exists and its group matches the effective group ID of this process."
		echo "-S file		true if file exists and is a socket."
		echo "-N file		true if file exists and its access time is not newer than its modification time."
		echo "file1 -nt file2		true if file1 exists and is newer than file2."
		echo "file1 -ot file2		true if file1 exists and is older than file2."
		echo "file1 -ef file2		true if file1 and file2 exist and refer to the same file."
		echo "string = pattern"
		echo "string == pattern	true if string matches pattern."
		echo "string != pattern	true if string does not match pattern."
		echo "string =~ regexp	true if string matches the regular expression regexp."
		echo "string1 < string2	true if string1 comes before string2 based on ASCII value of their characters."
		echo "string1 > string2	true if string1 comes after string2 based on ASCII value of their characters."
		echo "exp1 -eq exp2		true if exp1 is numerically equal to exp2."
		echo "exp1 -ne exp2		true if exp1 is numerically not equal to exp2."
		echo "exp1 -lt exp2		true if exp1 is numerically less than exp2."
		echo "exp1 -gt exp2		true if exp1 is numerically greater than exp2."
		echo "exp1 -le exp2		true if exp1 is numerically less than or equal to exp2."
		echo "exp1 -ge exp2		true if exp1 is numerically greater than or equal to exp2."
		echo "( exp )			true if exp is true."
		echo "! exp			true if exp is false."
		echo "exp1 && exp2	true if exp1 and exp2 are both true."
		echo "exp1 || exp2	true if either exp1 or exp2 is true."
		echo "http://zsh.sourceforge.net/Doc/Release/Conditional-Expressions.html"
	fi
}
# echo "here"
autoload -U compinit && compinit
# echo "here2"
eval $(thefuck --alias)
# echo "here3"
source $(brew --prefix nvm)/nvm.sh 2> /dev/null
# echo "here4"
nvm use --delete-prefix v14.5.0 --silent
