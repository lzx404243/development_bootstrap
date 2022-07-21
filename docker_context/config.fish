if status is-interactive
  # Commands to run in interactive sessions can go here
  fish_add_path {$HOME}/bin
  fish_add_path {$HOME}/local/bin
  fish_add_path /opt/bin
  fish_add_path /opt/llvm-13.0.0/bin
  fish_add_path /opt/edge/libcurl/7.84/bin

  # vi commandline configurations.
  fish_vi_key_bindings
  set fish_cursor_default block
  set fish_cursor_insert line
  set fish_cursor_replace_one underscore

  set -x EDITOR nvim
  set -x MANPAGER 'nvim +Man!'
  set -x MANWIDTH 999

  source {$HOME}/.aliases
  bass source /opt/rh/gcc-toolset-11/enable
end

# Enable command history search via fzf.
function reverse_history_search
  history | fzf --no-sort | read -l command
  if test $command
    commandline -rb $command
  end
end

function fish_user_key_bindings
  bind -M default / reverse_history_search
end

function fish_prompt --description 'Write out the prompt'
    set -l last_status $status
    set -l normal (set_color normal)
    set -l status_color (set_color brgreen)
    set -l cwd_color (set_color $fish_color_cwd)
    set -l vcs_color (set_color brpurple)
    set -l prompt_status ""
    set -g __fish_git_prompt_show_informative_status 1

    # Since we display the prompt on a new line allow the directory names to be longer.
    set -q fish_prompt_pwd_dir_length
    or set -lx fish_prompt_pwd_dir_length 0

    # Color the prompt differently when we're root
    set -l suffix '❯'
    if functions -q fish_is_root_user; and fish_is_root_user
        if set -q fish_color_cwd_root
            set cwd_color (set_color $fish_color_cwd_root)
        end
        set suffix '#'
    end

    # Color the prompt in red on error
    if test $last_status -ne 0
        set status_color (set_color $fish_color_error)
        set prompt_status $status_color "[" $last_status "]" $normal
    end

    echo -s (prompt_login) ' ' $cwd_color (prompt_pwd) $vcs_color (fish_git_prompt) $normal ' ' $prompt_status
    echo -n -s $status_color $suffix ' ' $normal
end
