# Disable the greeting message
function fish_greeting
end

# Set language
setenv LC_ALL en_US.UTF-8

# Set aliases
alias k='kubectl'
alias ks='kubectl -n kube-system'
alias gr='grep -R'
alias dotgit='/usr/bin/git --git-dir=$HOME/Projects/dotfiles/.git --work-tree=$HOME/'

# Setup up SSH agent
# Mostly taken from https://gist.github.com/gerbsen/5fd8aa0fde87ac7a2cae

setenv SSH_ENV $HOME/.ssh/environment

function start_agent
    echo "Initializing new SSH agent ..."
    ssh-agent -c | sed 's/^echo/#echo/' > $SSH_ENV
    echo "succeeded"
    chmod 600 $SSH_ENV 
    . $SSH_ENV > /dev/null
    ssh-add
end

function test_identities 
    ssh-add -l | grep "The agent has no identities" > /dev/null
    if [ $status -eq 0 ]
        ssh-add
        if [ $status -eq 2 ]
            start_agent
        end
    end
end

# We should not run the SSH agent setup while we are running in a Nix shell as
# it could be a pure shell with no SSH binaries
if test -z "$IN_NIX_SHELL"
  if [ -n "$SSH_AGENT_PID" ] 
      ps -ef | grep $SSH_AGENT_PID | grep ssh-agent > /dev/null
      if [ $status -eq 0 ]
          test_identities
      end  
  else
      if [ -f $SSH_ENV ]
          . $SSH_ENV > /dev/null
      end  
      ps -ef | grep $SSH_AGENT_PID | grep -v grep | grep ssh-agent > /dev/null
      if [ $status -eq 0 ]
          test_identities
      else 
          start_agent
      end  
  end
end

# Setup the prompt configuration

function prompt_comp_git_branch
  set -l branch (git branch 2> /dev/null | grep -e '\* ' | sed 's/^..\(.*\)/\1/')
  set -l git_status (git status -s)

  if test -n "$git_status"
    echo "("(set_color red)$branch(set_color normal)")"
  else
    echo "("(set_color green)$branch(set_color normal)")"
  end
end

function prompt_comp_nix_shell
  if test -n "$IN_NIX_SHELL"
    echo (set_color blue)" ❆ "(set_color normal)
  end
end

function prompt_comp_pwd
  # prompt_pwd is a built-in fish function
  echo (set_color green)(prompt_pwd)(set_color normal)
end

function fish_prompt
  set -l git_dir (git rev-parse --git-dir 2> /dev/null)
  if test -n "$git_dir"
    printf '%s %s%s> ' (prompt_comp_pwd) (prompt_comp_git_branch) (prompt_comp_nix_shell)
  else
    printf '%s%s> ' (prompt_comp_pwd) (prompt_comp_nix_shell)
  end
end

# TODO: I should remove this at some point when all local packages are moved to
# Nix
set -x PATH $PATH $HOME/Library/Python/3.7/bin
