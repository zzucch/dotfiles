source ~/dotfiles/palette.sh

_hex_to_256() {
    local hex="${1#\#}"
    local r=$((16#${hex[1,2]})) g=$((16#${hex[3,4]})) b=$((16#${hex[5,6]}))
    local -a L=(0 95 135 175 215 255)
    local ri=0 gi=0 bi=0
    for i in 1 2 3 4 5; do
        (( (r-L[i+1])*(r-L[i+1]) < (r-L[ri+1])*(r-L[ri+1]) )) && ri=$i
        (( (g-L[i+1])*(g-L[i+1]) < (g-L[gi+1])*(g-L[gi+1]) )) && gi=$i
        (( (b-L[i+1])*(b-L[i+1]) < (b-L[bi+1])*(b-L[bi+1]) )) && bi=$i
    done
    local cube=$(( 16 + 36*ri + 6*gi + bi ))
    local cube_dist=$(( (r-L[ri+1])*(r-L[ri+1]) + (g-L[gi+1])*(g-L[gi+1]) + (b-L[bi+1])*(b-L[bi+1]) ))
    local avg=$(( (r+g+b)/3 ))
    local gsi=$(( (avg-8)/10 )); (( gsi < 0 )) && gsi=0; (( gsi > 23 )) && gsi=23
    local gs_val=$(( 8 + gsi*10 ))
    local gs_dist=$(( (r-gs_val)*(r-gs_val) + (g-gs_val)*(g-gs_val) + (b-gs_val)*(b-gs_val) ))
    (( gs_dist < cube_dist )) && REPLY=$(( 232 + gsi )) || REPLY=$cube
}

_set_prompt() {
    PROMPT="%(?.%F{$_P_MAGENTA}➜.%F{$_P_RED}➜)%f %F{$_P_GOLD}%c%f \$(git_prompt_info)"
    ZSH_THEME_GIT_PROMPT_PREFIX="%F{$_P_CYAN}git:(%F{$_P_RED}"
    ZSH_THEME_GIT_PROMPT_SUFFIX="%f "
    ZSH_THEME_GIT_PROMPT_DIRTY="%F{$_P_CYAN}) %F{$_P_GOLD}✗"
    ZSH_THEME_GIT_PROMPT_CLEAN="%F{$_P_CYAN})"
}

_apply_palette() {
    cat > ~/.config/kitty/palette.conf << EOF
foreground            $PAL_FG
background            $PAL_BG
selection_foreground  $PAL_BG
selection_background  $PAL_GOLD
cursor                $PAL_RED
cursor_text_color     $PAL_BG
url_color             $PAL_CYAN
active_border_color   $PAL_MAGENTA
inactive_border_color $PAL_SELECTION
active_tab_foreground   $PAL_BG
active_tab_background   $PAL_GOLD
inactive_tab_foreground $PAL_FG_DIM
inactive_tab_background $PAL_BG_ALT
mark1_foreground $PAL_BG
mark1_background $PAL_GOLD
color0  $PAL_BLACK
color8  $PAL_BLACK_BRIGHT
color1  $PAL_RED
color9  $PAL_RED_BRIGHT
color2  $PAL_GREEN
color10 $PAL_GREEN_BRIGHT
color3  $PAL_GOLD
color11 $PAL_GOLD_BRIGHT
color4  $PAL_BLUE
color12 $PAL_BLUE_BRIGHT
color5  $PAL_MAGENTA
color13 $PAL_MAGENTA_BRIGHT
color6  $PAL_CYAN
color14 $PAL_CYAN_BRIGHT
color7  $PAL_WHITE
color15 $PAL_FG
EOF

    local ghostty_dir="${XDG_CONFIG_HOME:-$HOME/.config}/ghostty"
    if [[ -d "$ghostty_dir" ]]; then
        local ghostty_palette
        ghostty_palette=$(mktemp "$ghostty_dir/.palette.XXXXXX") || return 1
        cat > "$ghostty_palette" << EOF
foreground = $PAL_FG
background = $PAL_BG
selection-foreground = $PAL_BG
selection-background = $PAL_GOLD
cursor-color = $PAL_RED
cursor-text = $PAL_BG
split-divider-color = $PAL_SELECTION
palette = 0=$PAL_BLACK
palette = 1=$PAL_RED
palette = 2=$PAL_GREEN
palette = 3=$PAL_GOLD
palette = 4=$PAL_BLUE
palette = 5=$PAL_MAGENTA
palette = 6=$PAL_CYAN
palette = 7=$PAL_WHITE
palette = 8=$PAL_BLACK_BRIGHT
palette = 9=$PAL_RED_BRIGHT
palette = 10=$PAL_GREEN_BRIGHT
palette = 11=$PAL_GOLD_BRIGHT
palette = 12=$PAL_BLUE_BRIGHT
palette = 13=$PAL_MAGENTA_BRIGHT
palette = 14=$PAL_CYAN_BRIGHT
palette = 15=$PAL_FG
EOF
        mv -f "$ghostty_palette" "$ghostty_dir/palette.ghostty"
    fi

    _hex_to_256 "$PAL_RED";     _P_RED=$REPLY
    _hex_to_256 "$PAL_GOLD";    _P_GOLD=$REPLY
    _hex_to_256 "$PAL_MAGENTA"; _P_MAGENTA=$REPLY
    _hex_to_256 "$PAL_CYAN";    _P_CYAN=$REPLY
    _hex_to_256 "$PAL_PURPLE";  _P_PURPLE=$REPLY
    _hex_to_256 "$PAL_COMMENT"; _P_COMMENT=$REPLY
    _hex_to_256 "$PAL_GREEN";   _P_GREEN=$REPLY
    _hex_to_256 "$PAL_FG";      _P_FG=$REPLY

    export CLICOLOR=1
    export LSCOLORS="GxFxDxBxGxGxBxDxGxBx"
    export LS_COLORS="rs=0:di=38;5;${_P_CYAN}:ln=38;5;${_P_PURPLE}:pi=38;5;${_P_GOLD}:so=38;5;${_P_MAGENTA}:bd=38;5;${_P_CYAN}:cd=38;5;${_P_CYAN}:or=38;5;${_P_RED}:mi=38;5;${_P_RED}:ex=38;5;${_P_RED}:*.tar=38;5;${_P_GOLD}:*.tgz=38;5;${_P_GOLD}:*.gz=38;5;${_P_GOLD}:*.zip=38;5;${_P_GOLD}:*.7z=38;5;${_P_GOLD}:*.rar=38;5;${_P_GOLD}:*.jpg=38;5;${_P_PURPLE}:*.jpeg=38;5;${_P_PURPLE}:*.png=38;5;${_P_PURPLE}:*.gif=38;5;${_P_PURPLE}:*.svg=38;5;${_P_PURPLE}:*.mp3=38;5;${_P_CYAN}:*.mp4=38;5;${_P_CYAN}:*.mov=38;5;${_P_CYAN}:*.go=38;5;${_P_CYAN}:*.lua=38;5;${_P_MAGENTA}:*.sh=38;5;${_P_GREEN}"

    typeset -gA ZSH_HIGHLIGHT_STYLES
    ZSH_HIGHLIGHT_STYLES[command]="fg=${_P_CYAN},bold"
    ZSH_HIGHLIGHT_STYLES[builtin]="fg=${_P_MAGENTA},bold"
    ZSH_HIGHLIGHT_STYLES[alias]="fg=${_P_GOLD},bold"
    ZSH_HIGHLIGHT_STYLES[function]="fg=${_P_CYAN}"
    ZSH_HIGHLIGHT_STYLES[string]="fg=${_P_GOLD}"
    ZSH_HIGHLIGHT_STYLES[comment]="fg=${_P_COMMENT}"
    ZSH_HIGHLIGHT_STYLES[unknown-token]="fg=${_P_RED},bold"
    ZSH_HIGHLIGHT_STYLES[path]="fg=${_P_FG},underline"
}

theme() {
    local name="$1"
    if [[ -z "$name" ]]; then
        local current=$(cat ~/dotfiles/.theme 2>/dev/null || echo default)
        name=$(ls ~/dotfiles/palettes/*.sh | sed 's|.*/||;s|\.sh$||' \
            | fzf --prompt="theme > " --height=~50% --layout=reverse \
                  --header="current: $current" \
                  --ansi --preview '~/dotfiles/palettes/.preview {}') || return 0
    fi
    [[ ! -f ~/dotfiles/palettes/${name}.sh ]] && echo "no palette: $name" && return 1
    echo "$name" > ~/dotfiles/.theme
    source ~/dotfiles/palette.sh
    _apply_palette
    kitty @ --to unix:/tmp/kitty-theme set-colors --all --configured ~/.config/kitty/palette.conf &>/dev/null
    tmux set -g status-style                "bg=$PAL_BG fg=$PAL_COMMENT" &>/dev/null
    tmux set -g status-left-style           "bg=$PAL_BG fg=$PAL_GOLD bold" &>/dev/null
    tmux set -g window-status-current-style "bg=$PAL_BG fg=$PAL_MAGENTA bold" &>/dev/null
    tmux set -g window-status-style         "bg=$PAL_BG fg=$PAL_COMMENT" &>/dev/null
    tmux set -g pane-border-style           "fg=$PAL_SELECTION" &>/dev/null
    tmux set -g pane-active-border-style    "fg=$PAL_MAGENTA" &>/dev/null
    tmux set -g message-style               "bg=$PAL_BG_ALT fg=$PAL_FG" &>/dev/null
    tmux set -g window-style                "bg=$PAL_BG fg=$PAL_FG" &>/dev/null
    tmux set -g window-active-style         "bg=$PAL_BG fg=$PAL_FG" &>/dev/null
}

_apply_palette
add-zsh-hook precmd _set_prompt
