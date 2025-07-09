# name: 'cyberdream'
# url: 'https://github.com/scottmckendry/cyberdream.nvim'
# preset -g ferred_background: 16181a

# Cyberpunk 2077 https://www.color-hex.com/color-palette/1024181
#00060e	(0,6,14)
#9a9f17	(154,159,23)
#fee801	(254,232,1)
#54c1e6	(84,193,230)
#39c4b6	(57,196,182)
#CP
#00ff9f	(0,255,159)
#00b8ff	(0,184,255)
#001eff	(0,30,255)
#bd00ff	(189,0,255)
#d600ff	(214,0,255)

# CyberPunk Neon Color Scheme for Fish
set -g fish_term256 1
set -g fish_color_search_match --background=blue
set -g fish_color_autosuggestion "#969896"
set -g fish_color_normal FF00FF
set -g fish_color_command "#0782DE"
set -g fish_color_comment 808080
set -g fish_color_operator 00ffff
set -g fish_color_autosuggestion 666666
set -g fish_color_cancel ff0000
set -g fish_color_valid_path 00ff00
set -g fish_color_redirection ff00aa
set -g fish_color_end ff0000
set -g fish_color_error ff0000
set -g fish_color_escape "#fe8019"
set -g fish_color_history_current --bold
set -g fish_color_host "#85AD82"
set -g fish_color_host_remote yellow
set -g fish_color_match 00ff00
set -g fish_color_search_match --background="#60AEFF"
set -g fish_color_operator "#fe8019"
set -g fish_color_param 00ffff
set -g fish_color_quote "#b8bb26"
set -g fish_color_selection ff00ff --background=000000
set -g fish_color_search_match --background=00ff00
set -g fish_color_search_match bryellow background=000000
set -g fish_color_status red
set -g fish_color_user brgreen
set -g fish_color_valid_path --underline

# Completion colors
set -g fish_pager_color_description "#B3A06D" yellow
set -g fish_pager_color_prefix normal --bold underline
set -g fish_pager_color_prefix white --bold --underline
set -g fish_pager_color_progress brwhite --background=cyan
# set -g fish_pager_color_selected_background --background=00FF00
set -g fish_pager_color_prefix 00ffff
set -g fish_pager_color_completion 808080
set -g fish_pager_color_progress 00ff00

# Path highlighting colors
set -g fish_color_valid_path 00ff00 # Bright neon green with underline
set -g fish_color_valid_path_file 00ffff # Cyan for files
set -g fish_color_valid_path_dir ff00ff # Magenta for directories
set -g fish_pager_color_selected_background 000000 # Black background
set -g fish_pager_color_selected_prefix ff00ff # Magenta prefix
set -g fish_pager_color_selected_completion 00ffff # Cyan completion

# PWD color customization
set -g fish_color_cwd ff00ff # Bright magenta
set -g fish_color_cwd_root ff0000 # Neon red for root
set -g fish_color_pwd_bg 000000 # Deep black background
set -g fish_color_pwd_dir_bg 000000 # Directory background
