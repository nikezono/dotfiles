# Left: 
# Sorin
function fish_prompt
	test $SSH_TTY
    and printf (set_color red)$USER(set_color brwhite)'@'(set_color yellow)(prompt_hostname)' '
    test "$USER" = 'root'
    and echo (set_color red)"#"

    # Main
    echo -n (set_color red)'❯'(set_color yellow)'❯'(set_color green)'❯ '
end

# Right: 
# https://gist.github.com/britishtea/39ad478fa5180e1432a2
function fish_right_prompt -d "Write out the right prompt"
  set -l exit_code $status
  set -l is_git_repository (git rev-parse --is-inside-work-tree ^/dev/null)

  # Print a yellow fork symbol when in a subshell
  set -l max_shlvl 1
  test $TERM = "screen"; and set -l max_shlvl 3
  if test $SHLVL -gt $max_shlvl
    set_color yellow
    echo -n "⑂ "
    set_color black
  end

  # Print a red dot for failed commands.
  if test $exit_code -ne 0
    set_color red
    echo -n "• "
    set_color black
  end

  # Print the username when the user has been changed.
  if test $USER != $LOGNAME
    set_color gray
    echo -n "$USER@"
  end

  # Print the current directory. Replace $HOME with ~.
  echo -n (set_color cyan)'['(prompt_pwd)']'

  # Print the current git branch name or shortened commit hash in colour.
  #
  # Green means the working directory is clean.
  # Yellow means all changed files have been staged.
  # Red means there are changed files that are not yet staged.
  #
  # Untracked files are ignored.
  if test -n "$is_git_repository"
    echo -n ":"

    set -l branch (git symbolic-ref --short HEAD ^/dev/null; or git show-ref --head -s --abbrev | head -n1 ^/dev/null)

    git diff-files --quiet --ignore-submodules ^/dev/null; or set -l has_unstaged_files
    git diff-index --quiet --ignore-submodules --cached HEAD ^/dev/null; or set -l has_staged_files

    if set -q has_unstaged_files
      set_color red
    else if set -q has_staged_files
      set_color yellow
    else
      set_color green
    end

    echo -n $branch

    set_color black
  end

  set_color normal
end
