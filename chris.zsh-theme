# Based on minimal

prefix_colour=white

[[ $EMACS = t ]] && prefix_colour=black

ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[$prefix_colour]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}●%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

ZSH_THEME_SVN_PROMPT_PREFIX="[svn @r"
ZSH_THEME_SVN_PROMPT_SUFFIX="]"

#Customized git status, oh-my-zsh currently does not allow render dirty status before branch
git_custom_status() {
  local cb=$(current_branch)
  if [ -n "$cb" ]; then
    echo "- $ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$(parse_git_dirty)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

#Just grabs the current rev. Good enough - since the checkout path includes trunk/branch info already ;)
svn_revision() {
  local srev=$(svn info 2>&1 | grep "Revision" | sed -e "s/.* //")
  if [ -n "$srev" ]; then
    echo "- $ZSH_THEME_SVN_PROMPT_PREFIX$srev$ZSH_THEME_SVN_PROMPT_SUFFIX"
  fi
}

prompt_char() {
  git branch >/dev/null 2>/dev/null && echo '±' && return
  echo 'o'
}


PROMPT='
%{$fg[green]%}%n%{$reset_color%}@%{$fg[magenta]%}%m%{$reset_color%}
%{$fg_bold[yellow]%}$(prompt_char)%{$reset_color%} %2~ $(git_custom_status)$(svn_revision) »%b '


