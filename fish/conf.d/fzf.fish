# https://github.com/junegunn/fzf/blob/master/bin/fzf-preview.sh
# https://github.com/junegunn/fzf/blob/master/ADVANCED.md#switching-between-ripgrep-mode-and-fzf-mode-using-a-single-key-binding

# https://github.com/Textualize/rich
# https://github.com/textualize/rich-cli
# Command-line toolbox for fancy output in the terminal
# brew install rich-cli yq pygments highlight

# 🚀 Which One to Use?
# Feature	highlight 🏆 (C-based)	rich-cli 🎨 (Python-based)
# Performance	✅ Faster	❌ Slower (Python overhead)
# Syntax Highlighting	✅ Yes	✅ Yes
# Tables	❌ No	✅ Yes
# JSON Beautification	❌ No	✅ Yes
# Markdown Rendering	❌ No	✅ Yes
# LaTeX/RTF/HTML Export	✅ Yes	❌ No
# Dependencies	✅ Minimal	❌ Requires Python
# Customization	✅ Many options	✅ Good but less flexible
# Verdict:
# 🏆 For pure syntax highlighting → highlight
# 🎨 For modern rendering & extra features → rich-cli
# Best Practice: Use both! highlight for performance & rich-cli for visual improvements.

# Would you like a fish function to wrap both for dynamic usage? 🚀

# cat README.md | rich - --markdown --force-terminal
# rich README.md -o readme.htm /
# rich README.md --hyperlinks
# "popler"                                      # PDF rendering library (based on the xpdf-3.0 code base)
# "imagemagick"                                 # Tools and libraries to manipulate images in many formats
# "chafa"                                       # Versatile and fast Unicode/ASCII/ANSI graphics renderer
# "viu"                                         # Simple terminal image viewer written in Rust
# "ouch"                                        # Painless compression and decompression for your terminal
# "glow"                                        # Render markdown on the CLI


# rich --rule                           # Display a horizontal rule.
# rich --json FILE                     # Display JSON content.
# rich --markdown FILE                 # Display Markdown content.
# rich --rst FILE                      # Display reStructuredText.
# rich --csv FILE                      # Display CSV as a table.
# rich --ipynb FILE                    # Display Jupyter Notebook.
# rich --syntax FILE                    # Enable syntax highlighting.
# rich --inspect FILE                   # Inspect a Python object.
# rich --head LINES FILE                # Display first LINES of a file (requires --syntax or --csv).
# rich --tail LINES FILE                # Display last LINES of a file (requires --syntax or --csv).
# rich --emoji                          # Enable emoji code rendering.
# rich --left                           # Align text to the left.
# rich --right                          # Align text to the right.
# rich --center                         # Align text to the center.
# rich --text-left                      # Justify text to the left.
# rich --text-right                     # Justify text to the right.
# rich --text-center                    # Justify text to the center.
# rich --text-full                      # Justify text to both edges.
# rich --soft                           # Enable soft wrapping (requires --print).
# rich --expand                         # Expand output to full width (requires --panel).
# rich --width SIZE                     # Set output width to SIZE characters.
# rich --max-width SIZE                 # Set maximum output width to SIZE characters.
# rich --style STYLE                    # Set text style.
# rich --rule-style STYLE               # Set rule style.
# rich --rule-char CHARACTER            # Use CHARACTER for rule lines.
# rich --padding TOP,RIGHT,BOTTOM,LEFT  # Set padding (1, 2, or 4 comma-separated values).
# rich --panel BOX                      # Set panel type (ascii, ascii2, double, heavy, none, rounded, square).
# rich --panel-style STYLE              # Set panel style (requires --panel).
# rich --theme THEME                    # Set syntax theme (see https://pygments.org/styles/).
# rich --line-numbers                   # Enable line numbers in syntax highlighting.
# rich --guides                         # Show indentation guides in syntax highlighting.
# rich --lexer LEXER                    # Use LEXER for syntax highlighting (see https://pygments.org/docs/lexers/).
# rich --hyperlinks                     # Render hyperlinks in Markdown.
# rich --no-wrap                        # Disable word wrapping in syntax-highlighted files.
# rich --title TEXT                     # Set panel title.
# rich --caption TEXT                   # Set panel caption.
# rich --force-terminal                 # Force terminal output even when not in a terminal.
# rich --export-html PATH               # Export output as HTML to PATH.
# rich --export-svg PATH                # Export output as SVG to PATH.
# rich --pager                          # Display output in an interactive pager.

# -B, --batch-recursive=<wc>     # Convert all matching files, searches subdirs (Example: -B '*.cpp')
# -D, --data-dir=<directory>     # Set path to data directory
#     --config-file=<file>       # Set path to a lang or theme file
# -d, --outdir=<directory>       # Name of output directory
# -h, --help[=topic]             # Print this help or a topic description
# -i, --input=<file>             # Name of single input file
# -o, --output=<file>            # Name of single output file
# -P, --progress                 # Print progress bar in batch mode
# -q, --quiet                    # Suppress progress info in batch mode
# -S, --syntax=<type|path>       # Specify type of source code or syntax file path
#     --syntax-by-name=<name>    # Specify type of source code by given name
#     --syntax-supported         # Test if the given syntax can be loaded
# -v, --verbose                  # Print debug info; repeat to show more information
#     --force[=syntax]           # Generate output if input syntax is unknown
#     --list-scripts=<type>      # List installed scripts
#     --list-cat=<categories>    # Filter the scripts by the given categories
#     --max-size=<size>          # Set maximum input file size (examples: 512M, 1G; default: 256M)
#     --plug-in=<script>         # Execute Lua plug-in script
#     --plug-in-param=<value>    # Set plug-in input parameter
#     --print-config             # Print path configuration
#     --print-style              # Print stylesheet only
#     --skip=<list>              # Ignore listed unknown file types
#     --stdout                   # Output to stdout (batch mode, --print-style)
#     --validate-input           # Test if input is text, remove Unicode BOM
#     --service-mode             # Run in service mode, not stopping until signaled
#     --version                  # Print version and copyright information

# # Output formatting options
# -O, --out-format=<format>      # Output file in given format (e.g., html, xhtml, latex, rtf, ansi, etc.)
# -c, --style-outfile=<file>     # Name of style file or print to stdout
# -e, --style-infile=<file>      # Include file in style-outfile (deprecated)
# -f, --fragment                 # Omit document header and footer
# -F, --reformat=<style>         # Reformat and indent output in given style
# -I, --include-style            # Include style definition in output file
# -J, --line-length=<num>        # Line length before wrapping
# -j, --line-number-length=<num> # Line number width including left padding
#     --line-range=<start-end>   # Output only lines from number <start> to <end>
# -k, --font=<font>              # Set font (specific to output format)
# -K, --font-size=<num?>         # Set font size (specific to output format)
# -l, --line-numbers             # Print line numbers in output file
# -m, --line-number-start=<cnt>  # Start line numbering with cnt
# -s, --style=<style|path>       # Set color style (theme) or theme file path
# -t, --replace-tabs=<num>       # Replace tabs by <num> spaces
# -T, --doc-title=<title>        # Document title
# -u, --encoding=<enc>           # Set output encoding
# -V, --wrap-simple              # Wrap lines after 80 characters without indenting
# -W, --wrap                     # Wrap lines after 80 characters
#     --wrap-no-numbers          # Omit line numbers of wrapped lines
# -z, --zeroes                   # Pad line numbers with zeros
#     --isolate                  # Output each syntax token separately
#     --keep-injections          # Output plug-in injections despite -f
#     --kw-case=<case>           # Change case of case-insensitive keywords
#     --no-trailing-nl[=mode]    # Omit trailing newline
#     --no-version-info          # Omit version info comment

# # (X)HTML output options
# -a, --anchors                  # Attach anchor to line numbers
# -y, --anchor-prefix=<str>      # Set anchor name prefix
# -N, --anchor-filename          # Use input file name as anchor prefix
# -C, --print-index              # Print index with hyperlinks to output files
# -n, --ordered-list             # Print lines as ordered list items
#     --class-name=<name>        # Set CSS class name prefix
#     --inline-css               # Output CSS within each tag
#     --enclose-pre              # Enclose fragmented output with pre tag

# # LaTeX output options
# -b, --babel                    # Disable Babel package shorthands
# -r, --replace-quotes           # Replace double quotes by \dq{}
#     --beamer                   # Adapt output for the Beamer package
#     --pretty-symbols           # Improve appearance of brackets and other symbols

# # RTF output options
#     --page-color               # Include page color attributes
# -x, --page-size=<ps>           # Set page size (e.g., a3, a4, letter)
#     --char-styles              # Include character stylesheets

# # SVG output options
#     --height                   # Set image height
#     --width                    # Set image width

# # Terminal escape output options (xterm256 or truecolor)
#     --canvas[=width]           # Set background color padding

# # Language Server options
#     --ls-profile=<server>      # Read LSP configuration from lsp.conf
#     --ls-delay=<ms>            # Set server initialization delay
#     --ls-exec=<bin>            # Set server executable name
#     --ls-option=<option>       # Set server CLI option (can be repeated)
#     --ls-hover                 # Execute hover requests (HTML output only)
#     --ls-semantic              # Retrieve semantic token types (requires LSP 3.16)
#     --ls-syntax=<lang>         # Set syntax understood by the server
#     --ls-syntax-error          # Retrieve syntax error information
#     --ls-workspace=<dir>       # Set workspace directory to initialize the server
#     --ls-legacy                # Do not require a server capabilities response


#  solved my problem as follows:

# Create a function:
# pale() { [[ -n `file "$1" | grep -o text` ]] && glow -p -w 110 -s dark "$1" }
# Rewrite fzf option:
# --preview 'zsh -c $(functions pale); pale {}'

# kitty icat --align left --clear --transfer-mode=memory --stdin=no --unicode-placeholder --place=(math (tput cols))x(math (tput lines) - 5)@0x0 $file

# function install_fzf --description "Install fzf and enable key bindings"
#     if not type -q fzf
#         echo "Installing fzf..."
#         brew install fzf
#     else
#         echo "fzf is already installed."
#     end

#     # Install fzf key bindings and completion
#     if test -f (brew --prefix)/opt/fzf/install
#         echo "Configuring fzf..."
#         yes | (brew --prefix)/opt/fzf/install
#     end
# end
# set -e debug_mode  # Unset the variable
if test "$debug_mode" -eq 1
    echo "Debug mode is enabled"
end

# Ensure fzf is installed before setting up key bindings
if type -q fzf
    # Enable fzf key bindings
    fzf --fish | source

    # Command for searching files and directories
    # set -gx FZF_DEFAULT_COMMAND_AG "ag --hidden --ignore .git --ignore .sass-cache --ignore node_modules -g ''"
    # set -gx FZF_DEFAULT_COMMAND_RG "rg --files --hidden --glob '!{*.git/**,!node_modules,!build/**,!dart_tool/**,!idea}'"
    # set -gx FZF_DEFAULT_COMMAND_FD_FILE "fd --no-ignore --hidden --follow --color=always --strip-cwd-prefix --exclude '.git' --type f"
    # set -gx FZF_DEFAULT_COMMAND_FD_DIR "fd --no-ignore --hidden --follow --color=always --strip-cwd-prefix --exclude '.git' --type d -d 1"

    # FZF Preview Options 
    # set -gx FZF_BIN_PREVIEW "if test (file --mime-type -b {}) = 'application/octet-stream'; echo '{} is a binary file'; end"
    # set -gx FZF_DIR_PREVIEW "eza --tree --level=2 --color=always --group-directories-first --icons=auto --hyperlink -snew {} | head -200"
    # set -gx FZF_PREVIEW_OPTS "--preview 'bat --map-syntax=.ignore:Git --theme=Dracula --style=grid --color=always --decorations=always --line-range :500 {}'"
    set -Ux FZF_PREVIEW_OPTS "--preview 'bat --map-syntax=.ignore:Git --color=always --style=numbers --theme=Dracula {}' --preview-window=right:70%'"

    # General FZF options
    set -Ux FZF_GENERAL_OPTS "
        --ansi 
        --multi
        --cycle
        --height=80%
        --tabstop=4
        --info=inline-right
        --layout=reverse-list
        --border=rounded
        --preview-window "up,60%,border-bottom,+{2}+3/3,~3" \
        --border-label='❱❱ fzf search code/files/dir/bin ❱❱'
        --border-label-pos=-5
        --preview-window=border-rounded
        --padding=1
        --margin=0
        --prompt='➜ '
        --marker='❱❱'
        --pointer='➤ '
        --separator=''
        --scrollbar='' 
    "

    # Color scheme (Example: CyberPunk Neon Dark)
    set -Ux FZF_COLOR_OPTS "
        --color=fg:#5b5d5e,fg+:#2aff00,bg:#000000,bg+:#000000
        --color=hl:#5f87af,hl+:#5fd7ff,info:#afaf87,marker:#001cba
        --color=prompt:#d7005f,spinner:#9dff00,pointer:#48ff00,header:#87afaf
        --color=border:#d000ff,separator:#95ff00,label:#aeaeae,query:#d9d9d9
    "

    # --bind='alt-b:become(bat --paging=always -f {+})'
    # --bind='ctrl-b:execute(bat --paging=always -f {+})' \
    # --bind='ctrl-]:preview(bat --color=always -l bash \"$XDG_DATA_HOME/gkeys/fzf\")'

    # Custom actions and preview settings. 
    set -Ux FZF_PREVIEW_OPTS "
        --bind='?:toggle-preview'
        --bind='alt-[:toggle-preview'
        --bind='alt-]:change-preview-window(70%|45%,down,border-top|45%,up,border-bottom|)+show-preview'
        --bind='alt-w:toggle-preview-wrap'
        --bind='ctrl-b:preview-page-up'
        --bind='ctrl-f:preview-page-down'
        --bind='alt-i:preview-page-up'
        --bind='alt-o:preview-page-down'
        --bind='ctrl-alt-b:preview-up'
        --bind='ctrl-alt-f:preview-down'

        # Execute commands inside fzf 
        --bind='alt-e:execute($EDITOR {} >/dev/tty </dev/tty)' \
        --bind='ctrl-v:execute(code {+})' \
        --bind='ctrl-s:toggle-sort' \
        --bind='alt-p:preview-up,alt-n:preview-down' \
        --bind='ctrl-k:preview-up,ctrl-j:preview-down' \
        --bind='alt-e:become($EDITOR {+})'
        --bind='ctrl-y:execute-silent(xsel --trim -b <<< {+})'

        # History navigation
        --bind='page-up:prev-history,page-down:next-history' \
        --bind='alt-{:prev-history,alt-}:next-history' \
        --bind='alt-shift-up:prev-history,alt-shift-down:next-history' \

    "

    # Keybindings for navigation and selection
    set -Ux FZF_KEYBINDINGS "
        # Exit behavior
        --bind='esc:abort' \
        --bind='ctrl-c:abort' \
        --bind='ctrl-q:abort' \
        --bind='ctrl-g:cancel' \

        # Navigation (better key mappings for movement)
        --bind='ctrl-j:down,ctrl-k:up' \
        --bind='home:beginning-of-line,end:end-of-line' \
        --bind='ctrl-s:beginning-of-line,ctrl-e:end-of-line' \
        --bind='ctrl-u:half-page-up,ctrl-d:half-page-down' \
        --bind='ctrl-alt-u:page-up,ctrl-alt-d:page-down' \
        --bind='alt-up:prev-selected,alt-down:next-selected' \
        --bind='alt-left:first,alt-right:last' \
        
        # Deleting and modifying text
        --bind='alt-x:unix-line-discard' \
        --bind='alt-c:unix-word-rubout' \
        --bind='alt-d:kill-word' \
        --bind='ctrl-h:backward-delete-char' \
        --bind='alt-bs:backward-kill-word' \
        --bind='ctrl-w:backward-kill-word' \

        # Selection controls
        --bind='alt-a:toggle-all' \
        --bind='ctrl-alt-a:toggle-all+accept' \
        --bind='ctrl-P:clear-selection' \

        # Copy to clipboard (Wayland or X11)
        --bind='ctrl-y:execute-silent(printf {} | cut -f 2- | wl-copy --trim-newline)' \

        # Change event triggers
        --bind='change:top' \
        --bind='change:first' \
    "
    # Search mode switching between ripgrep (rg) and fzf
    set -Ux FZF_SEARCH_MODE "
        --bind='ctrl-r:unbind(ctrl-r)+change-prompt(1. ripgrep> )+disable-search+reload(rg --column --line-number --no-heading --color=always --smart-case {q} || true)+rebind(change,ctrl-f)'
        --bind='ctrl-f:unbind(change,ctrl-f)+change-prompt(2. fzf> )+enable-search+rebind(ctrl-r)'
    "

    set -gx FZF_DEFAULT_OPTS "$FZF_GENERAL_OPTS $FZF_COLOR_OPTS $FZF_KEYBINDINGS $FZF_PREVIEW_OPTS $FZF_SEARCH_MODE"

    # # History integration with preview
    # set -Ux FZF_CTRL_R_OPTS "--preview 'echo {}' --preview-window up:3:hidden:wrap --bind '?:toggle-preview'"

    # # Directory search using `fd`
    # set -Ux FZF_ALT_C_COMMAND "fd --type d --hidden --follow --exclude .git"

    # # Enable fuzzy completion
    # set -Ux FZF_COMPLETION_TRIGGER "**"

    # # Ignore case when searching
    # set -Ux FZF_DEFAULT_OPTS "$FZF_DEFAULT_OPTS --ignore-case"

    # Debug mode check (if debug_mode is an environment variable)
    if test "$debug_mode" -eq 1
        echo "✅ FZF configuration applied!"
    end
end

function fzf_preview
    set -l search_mode fzf
    set -l preview_enabled 1
    set -l find_type files

    function toggle_preview
        if test $preview_enabled -eq 1
            set preview_enabled 0
        else
            set preview_enabled 1
        end
    end

    function toggle_search_mode
        switch $search_mode
            case fzf
                set search_mode rg
            case rg
                set search_mode ag
            case ag
                set search_mode fzf
        end
    end

    function toggle_find_type
        switch $find_type
            case files
                set find_type dirs
            case dirs
                set find_type hidden
            case hidden
                set find_type binary
            case binary
                set find_type files
        end
    end

    while true
        # Define the preview command inline (important for fzf)
        set -l preview_cmd '
            function preview_file
                set file "$1"
                set mime (file --mime-type -b -- "$file")

                switch $mime
                    case "text/markdown"
                        glow -p -w 80 -s dark "$file"

                    case "application/json" "text/x-shellscript" "text/x-python" "text/javascript" "text/css" "text/html" "text/xml" "application/x-sql"
                        bat --theme=Dracula --color=always --style=numbers "$file"

                    case "image/*"
                        if test -n "$KITTY_WINDOW_ID"
                            kitty +kitten icat --align left --clear --transfer-mode=memory --stdin=no --unicode-placeholder --place=(math (tput cols))x(math (tput lines) - 5)@0x0 "$file"
                        else if command -v viu > /dev/null
                            viu "$file"
                        else if command -v chafa > /dev/null
                            chafa --size=40x10 --symbols "block+space" "$file"
                        else
                            echo "No image preview available"
                        end

                    case "application/pdf"
                        pdftotext "$file" - | head -n 50

                    case "inode/directory"
                        exa -lah --color=always "$file"

                    case "*"
                        bat --theme=Dracula --color=always --style=numbers "$file"
                end
            end

            preview_file {}  # Call the function
        '

        # Define search command based on mode
        switch $find_type
            case files
                set search_cmd "find . -type f"
            case dirs
                set search_cmd "find . -type d"
            case hidden
                set search_cmd "find . -type f -name '.*'"
            case binary
                set search_cmd "find . -type f -exec file {} + | grep 'binary' | cut -d: -f1"
        end

        switch $search_mode
            case fzf
                set -l selection (eval "$search_cmd" | fzf --preview="fish -c '$preview_cmd'")
            case rg
                set -l selection (rg --files | fzf --preview="fish -c '$preview_cmd'")
            case ag
                set -l selection (ag --files | fzf --preview="fish -c '$preview_cmd'")
        end

        if test -n "$selection"
            echo "Selected: $selection"
        else
            break
        end
    end
end

# set FZF_PREVIEW_COLUMNS (tput cols)
#    set FZF_PREVIEW_LINES (tput lines)
#    set mime (file --mime-type -b $file)

# data=$(kitty icat \
#   --clear \
#   --transfer-mode=memory \
#   --align center \
#   --stdin=no \
#   --unicode-placeholder \
#   --place=${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}@0x0 \
#   {})

# function fzf_file_preview
#     if test (count $argv) -ne 1
#         echo "usage: fzf_file_preview FILENAME[:LINENO][:IGNORED]" >&2
#         return 1
#     end

#     set file (string replace -r '^~/' "$HOME/" -- $argv[1])
#     set center 0

#     # Handle line numbers in file path
#     if string match -rq '^(.+):([0-9]+)\ *$' -- $file
#         set file (string match -r '^(.+):' -- $file)
#         set center (string match -r ':[0-9]+' -- $argv[1] | string replace -r ':' '')
#     end

#     # Detect file type
#     set type (file --brief --dereference --mime -- "$file")

#     # Handle non-readable files
#     if not test -r "$file"
#         echo "File not found or unreadable: $file"
#         return 1
#     end

#     # Handle image files
#     if string match -q "image/*" "$type"
#         set dim (math (tput cols))x(math (tput lines) - 5)

#         if set -q KITTY_WINDOW_ID
#             kitty +kitten icat --clear --transfer-mode=memory --place="$dim@0x0" "$file"
#             return
#         else if command -v viu >/dev/null
#             viu -w (tput cols) -h (math (tput lines) - 5) "$file"
#             return
#         else if command -v chafa >/dev/null
#             chafa --size="$dim" --symbols "block+space" "$file"
#             return
#         end

#         echo "No suitable image previewer found!"
#         return
#     end

#     # Handle archives
#     if string match -q "application/{zip,tar,gzip,bzip2,xz,7z}" "$type"
#         ouch list "$file"
#         return
#     end

#     # Handle programming language formats using bat
#     if string match -q "text/*" "$type"
#         set batname (command -v batcat; or command -v bat)

#         if test -n "$batname"
#             eval "$batname --style=numbers --color=always --pager=never --highlight-line=$center '$file'"
#             return
#         end
#     end

#     # Handle binary files
#     if string match -q "*binary*" "$type"
#         file "$file"
#         return
#     end

#     # Fallback: List file details
#     exa -l --icons "$file"
# end




# function fzf_preview_all
#     fzf --preview '
#         set file {};
#         # set width 320
#         # set height 320
#         set FZF_PREVIEW_COLUMNS (tput cols)
#         set FZF_PREVIEW_LINES (math (tput lines) - 5)
#          set dim (math (tput cols))x(math (tput lines) - 5)

#         set mime (file --brief --dereference --mime -- "$file")
#         # set mime (file --mime-type -b $file)

#         switch $mime
#             # Markdown
#             case "text/*.md"
#                 glow -p -w 110 -s dark $file
#                 #--pager true --mouse true $file

#             # Code Files (Syntax Highlighting)
#             case "text/*"
#                 bat --color=always --style=grid --theme=Dracula $file
#             case "application/javascript" "application/ecmascript" "application/x-javascript"
#                 bat --language=js --color=always $file
#             case "application/json"
#                 yq $file
#                 jq . $file | bat --language=json --color=always
#             case "application/xml" "text/xml"
#                 bat --language=xml --color=always $file
#             case "text/x-yaml" "application/x-yaml"
#                 yq . $file | bat --language=yaml --color=always

#             # Images
#             case "image/png" "image/jpeg" "image/gif" "image/webp" "image/*"
#                   kitty icat --align left --clear --transfer-mode=memory --stdin=no --unicode-placeholder --place=(math (tput cols))x(math (tput lines) - 5)@0x0 $file
#      
#             # Videos
#             case "video/*"
#                 ffplay -nodisp -autoexit $file

#             # PDF
#             case "application/pdf"
#                 pdftotext $file - | bat --color=always --language=txt --style=plain | head -n 50

#             # Archives
#             case "application/zip" "application/x-tar" "application/x-bzip2" "application/x-xz" "application/x-7z-compressed" "application/x-rar"
#                 ouch list $file

#             # Fonts
#             case "font/*"
#                 fc-query --format "%{fullname}\n" $file

#             # Empty files
#             case "inode/empty"
#                 echo "Empty file"

#             # Executables
#             case "application/octet-stream"
#                 echo "$file is a binary file"
#             case "application/x-executable"
#                 ldd $file || file $file

#             # Fallback
#             case "*"
#                 file --mime $file
#         end
#     ' \
#         --bind "alt-p:toggle-preview" \
#         --bind "ctrl-m:execute(nvim {})" \
#         --prompt "🔍 Select File: "

#     commandline -f repaint # Fix cursor positioning
# end

# function search
#     # Define search modes and set default mode
#     set -l search_modes rg ag fd fzf
#     set -g FZF_MODE 1

#     # Function to switch modes
#     function switch_mode
#         set -g FZF_MODE (math "( $FZF_MODE % 4 ) + 1")
#     end

#     # Function to get the search command based on mode
#     function get_search_command
#         switch $FZF_MODE
#             case 1
#                 echo "rg --column --line-number --no-heading --color=always --smart-case"
#             case 2
#                 echo "ag --hidden --ignore .git --ignore node_modules --ignore .cache -g ''"
#             case 3
#                 echo "fd --no-ignore --hidden --follow --color=always --strip-cwd-prefix"
#             case 4
#                 echo fzf
#         end
#     end

#     # Define the actual search command
#     set -l SEARCH_CMD (get_search_command)

#     # Start FZF with dynamic mode switching and correct Fish syntax
#     fzf \
#         --ansi \
#         --multi \
#         --cycle \
#         --height=80% \
#         --tabstop=4 \
#         --info=inline-right \
#         --layout=reverse-list \
#         --border=rounded \
#         --border-label='❱❱ fzf search code/files/dir/bin ❱❱' \
#         --border-label-pos=-5 \
#         --preview-window=border-rounded \
#         --padding=1 \
#         --margin=0 \
#         --prompt='➜ ' \
#         --marker='❱❱' \
#         --pointer='➤ ' \
#         --separator='' \
#         --scrollbar='' \
#         --disabled --query "" \
#         --bind "ctrl-s:execute(switch_mode)+reload(get_search_command)" \
#         --bind "enter:become($EDITOR {1})" \
#         --bind "alt-p:toggle-preview" \
#         --preview "
#     set file_type (file --mime {} | string match -r 'text')
#     if test -n \"\$file_type\"
#         bat --map-syntax=.ignore:Git --theme=cyberpunk-glow --style=grid --color=always --decorations=always --line-range :500 {}
#     else
#         echo \"{} is a binary file\"
#     end
#     " \
#         --prompt "[$search_modes[$FZF_MODE]] >"
# end

# Fuzzy find and open a file with bat preview
function fbat
    fd --type f | fzf --preview "bat --style=numbers --color=always {}"
end

function rg_fzf_search
    set -l temp_file (mktemp -u)
    function cleanup --on-event fish_exit
        rm -f "$temp_file"
    end

    set -l rg_prefix "rg --column --line-number --no-heading --color=always --smart-case "
    set -l initial_query ""

    fzf --ansi --disabled --query "$initial_query" \
        --bind "start:reload:$rg_prefix {q}" \
        --bind "change:reload:sleep 0.1
    $rg_prefix {q} || true" \
        --bind "ctrl-t:transform:[[ ! \$FZF_PROMPT =~ ripgrep ]] &&
        echo \"rebind(change)+change-prompt(1. ripgrep> )+disable-search+transform-query:echo \{q} > $temp_file; cat $temp_file\" ||
          echo \"unbind(change)+change-prompt(2. fzf> )+enable-search+transform-query:echo \{q} > $temp_file; cat $temp_file\"" \
        --color "hl:-1:underline,hl+:-1:underline:reverse" \
        --prompt "1. ripgrep> " \
        --delimiter : \
        --header "ctrl-t: Switch between ripgrep/fzf" \
        --preview "bat --color=always {1} --highlight-line {2}" \
        --preview-window "up,60%,border-bottom,+{2}+3/3,~3" \
        --bind "enter:become(nvim {1} +{2})"
end

# function fzf_ripgrep_mode --description "Switch between Ripgrep launcher mode (CTRL-R) and fzf filtering mode (CTRL-F)"

#     rm -f /tmp/rg-fzf-{r,f}
#     set RG_PREFIX "rg --column --line-number --no-heading --color=always --smart-case"
#     set INITIAL_QUERY "$argv"

#     fzf --ansi --disabled --query "$INITIAL_QUERY" \
#         --bind "start:reload($RG_PREFIX {q})+unbind(ctrl-r)" \
#         --bind "change:reload:sleep 0.1
#        $RG_PREFIX {q} || true" \
#         --bind "ctrl-f:unbind(change,ctrl-f)+change-prompt(2. fzf> )+enable-search+rebind(ctrl-r)+transform-query(echo {q} > /tmp/rg-fzf-r; cat /tmp/rg-fzf-f)" \
#         --bind "ctrl-r:unbind(ctrl-r)+change-prompt(1. ripgrep> )+disable-search+reload($RG_PREFIX {q} || true)+rebind(change,ctrl-f)+transform-query(echo {q} > /tmp/rg-fzf-f; cat /tmp/rg-fzf-r)" \
#         --color "hl:-1:underline,hl+:-1:underline:reverse" \
#         --prompt '1. ripgrep> ' \
#         --delimiter : \
#         --header '╱ CTRL-R (ripgrep mode) ╱ CTRL-F (fzf mode) ╱' \
#         --preview 'bat --color=always {1} --highlight-line {2}' \
#         --preview-window 'right,border-left,<30(up,30%,border-bottom)' \
#         --bind 'enter:become(vim {1} +{2})'
# end

# # Function to toggle between different search modes in FZF
# function fzf_mode --description "Toggle between different search commands for FZF"
#     set -l mode (echo -e "ag\nfd\nrg" | fzf --prompt="Select search mode: " --height=10%)

#     switch $mode
#         case ag
#             set -gx FZF_DEFAULT_COMMAND "ag --hidden --ignore .git --ignore .sass-cache --ignore node_modules -g ''"
#             set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
#             echo "🔍 Switched to AG (The Silver Searcher)"

#         case fd
#             set -gx FZF_DEFAULT_COMMAND "fd --no-ignore --hidden --follow --color=always --strip-cwd-prefix --exclude '.git' --type f | lscolors"
#             set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
#             echo "🔍 Switched to FD (Fast File Search)"

#         case rg
#             set -gx FZF_DEFAULT_COMMAND "rg --files --hidden --glob '!{.git/**,node_modules,build/**,dart_tool/**,.idea}'"
#             set -gx FZF_CTRL_T_COMMAND $FZF_DEFAULT_COMMAND
#             echo "🔍 Switched to RG (Ripgrep)"

#         case "*"
#             echo "❌ No selection made, keeping current mode."
#     end
# end

function fzf_fd_switch
    set -l temp_file (mktemp -u)
    function cleanup --on-event fish_exit
        rm -f "$temp_file"
    end

    set -l fd_file_cmd "fd --no-ignore --hidden --follow --color=always --strip-cwd-prefix --exclude '.git' --type f"
    set -l fd_dir_cmd "fd --no-ignore --hidden --follow --color=always --strip-cwd-prefix --exclude '.git' --type d"
    set -l initial_query ""

    fzf --ansi --disabled --query "$initial_query" \
        --bind "start:reload:$fd_file_cmd" \
        --bind "change:reload:sleep 0.1; $fd_file_cmd || true" \
        --bind "ctrl-t:transform:[[ ! \$FZF_PROMPT =~ dir ]] &&
          echo \"rebind(change)+change-prompt(📁 Directories> )+reload:$fd_dir_cmd+transform-query:echo \{q} > $temp_file; cat $temp_file\" ||
          echo \"unbind(change)+change-prompt(📄 Files> )+reload:$fd_file_cmd+transform-query:echo \{q} > $temp_file; cat $temp_file\"" \
        --color "hl:-1:underline,hl+:-1:underline:reverse" \
        --prompt "📄 Files> " \
        --header "CTRL-T: Toggle between file & directory search" \
        --preview "bat --color=always --style=grid {+} 2>/dev/null || exa --tree --color=always {+} 2>/dev/null" \
        --preview-window "up,60%,border-bottom" \
        --bind "enter:become(nvim {+})"
end

# Fuzzy find and open a file
function ff
    set file (fd --type f | fzf)
    # Feed the output of fd into fzf
    # fd --type f --strip-cwd-prefix | fzf
    if test -n "$file"
        nvim "$file"
    end
end

# Fuzzy find and change directory
function fcd
    set dir (fd --type d | fzf)
    if test -n "$dir"
        cd "$dir"
    end
end
