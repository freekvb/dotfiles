# Setup fzf
# ---------
if [[ ! "$PATH" == */home/fvb/.fzf/bin* ]]; then
  PATH="${PATH:+${PATH}:}/home/fvb/.fzf/bin"
fi

eval "$(fzf --bash)"
