PROMPT=$'%F{black}%K{red} %n@%m %k%K{yellow} %y %k%K{green} %~ %k%f\n%F{black}%K{red}%(?.. %? )%k%K{yellow}%1(j. %j .)%k%K{green} %(!.#.\$) %k%f '
RPROMPT=''

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg_bold[blue]%}git:(%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%} "
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[blue]%}) %{$fg[yellow]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[blue]%})"

ASYNC_PROC=0
function precmd() {
    PROMPT=$'%F{black}%K{red} %n@%m %k%K{yellow} %y $(if [ -n "$RANGER_LEVEL" ];then echo -n "| ranger ";fi)%k%K{green} %~ %k%f\n%F{black}%K{red}%(?.. %? )%k%K{yellow}%1(j. %j .)%k%K{green} %(!.#.\$) %k%f '
    function async() {
	
        # save to temp file
        git_prompt_info > "${TMPDIR:-/tmp}/zsh_rprompt_$$"

        # signal parent
        kill -s USR1 $$
    }

    # do not clear RPROMPT, let it persist

    # kill child if necessary
    if [[ "${ASYNC_PROC}" != 0 ]]; then
        kill -s HUP $ASYNC_PROC >/dev/null 2>&1 || :
    fi

    # start background computation
    async &!
    ASYNC_PROC=$!
}

function TRAPUSR1() {
    # read from temp file
    RPROMPT="$(cat ${TMPDIR:-/tmp}/zsh_rprompt_$$)"

    # reset proc number
    ASYNC_PROC=0

    # redisplay
    zle && zle reset-prompt

    # cleanup temp file
    rm -- "${TMPDIR:-/tmp}/zsh_rprompt_$$"
}
