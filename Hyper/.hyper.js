module.exports = {
  config: {
	    
    // Run `npm install <plugins>`
    // Plugins: hyperborder", "hyper-opacity", "hyper-tab-icons","hyper-search", "hyperpower", "hypercwd", "hyper-transparent"

    // Alt key behavior (for Tmux and other terminal apps)
    modifierKeys: { altIsMeta: true }, // Treat Alt as Meta key (essential for Tmux)

    // Update channel: 'stable' for polished updates, 'canary' for frequent updates
    updateChannel: 'stable',

    // Font settings (Fira Code Nerd Font only)
    fontSize: 12,
  	uiFontFamily: "FiraCode Nerd Font",	 
     // font family with optional fallbacks
    fontFamily: '"FiraCode Nerd Font", Menlo, "DejaVu Sans Mono", Consolas, "Lucida Console", monospace',
    fontWeight: 'normal',
    fontWeightBold: 'bold',
    lineHeight: 1,
    letterSpacing: 1,

    // Cursor settings
    cursorColor: 'rgba(248, 28, 229, 0.8)', // Neon pink cursor
    cursorAccentColor: '#000', // Text color under block cursor
    cursorShape: 'UNDERLINE', // Options: 'BEAM', 'UNDERLINE', 'BLOCK'
    cursorBlink: true, // Disable cursor blinking

    // Scrollback settings
    scrollback: 10000, // Increase scrollback buffer

    // Color scheme (Cyberpunk neon style)
    foregroundColor: '#fff', // White text
    backgroundColor: 'rgba(0,0,0,0.0)', // Transparent background
    selectionColor: 'rgba(248, 28, 229, 0.3)', // Neon pink selection
    borderColor: '#333', // Border color for window and tabs

    // Custom CSS to hide scrollbar and top bar
    css: `
      /* Ensure transparency in full-screen mode */
      .terms_terms.terms_termsFullScreen {
        background-color: transparent !important;
      }

      /* Hide scrollbar */
      .xterm-viewport::-webkit-scrollbar {
        display: none;
      }

      /* Hide top bar */
      .header_header {
        display: none;
      }

      /* Adjust terminal height to fill the window */
      .terms_terms {
        margin-top: 0;
      }
    `,
    
    // if you're using a Linux setup which show native menus, set to false
    // default: `true` on Linux, `true` on Windows, ignored on macOS
    showHamburgerMenu: true,

    // set to `false` (without backticks and without quotes) if you want to hide the minimize, maximize and close buttons
    // additionally, set to `'left'` if you want them on the left, like in Ubuntu
    // default: `true` (without backticks and without quotes) on Windows and Linux, ignored on macOS
    showWindowControls: true,

    // custom padding (CSS format, i.e.: `top right bottom left`)
    padding: '14px',

    // Color palette (ANSI 16 colors)
    colors: {
      black: '#000000',
      red: '#ff0000',
      green: '#33ff00',
      yellow: '#ffff00',
      blue: '#0066ff',
      magenta: '#cc00ff',
      cyan: '#00ffff',
      white: '#d0d0d0',
      lightBlack: '#808080',
      lightRed: '#ff0000',
      lightGreen: '#33ff00',
      lightYellow: '#ffff00',
      lightBlue: '#0066ff',
      lightMagenta: '#cc00ff',
      lightCyan: '#00ffff',
      lightWhite: '#ffffff',
    },

    // Shell settings (Fish shell)
    shell: '/usr/local/bin/fish', // Path to Fish shell
    shellArgs: ['--login'], // Arguments for the shell

    // Environment variables (optional, uncomment if needed)
    // env: {
    //   SHELL: '/usr/local/bin/fish',
    //   TERM: 'xterm-256color',
    //   COLORTERM: 'truecolor',
    //   EDITOR: 'nvim',
    //   VISUAL: 'nvim',
    //   GIT_EDITOR: 'nvim',
    //   SUDO_EDITOR: 'nvim',
    //   LANG: 'en_US.UTF-8',
    //   LC_ALL: 'en_US.UTF-8',
    //   PYTHONIOENCODING: 'UTF-8',
    // },

    // Bell settings
    bell: 'SOUND', // Options: 'SOUND', false
    // bellSoundURL: '/path/to/sound/file', // Custom bell sound

    // Behavior settings
    copyOnSelect: true, // Copy text to clipboard on selection
    defaultSSHApp: true, // Set Hyper as the default SSH client
    quickEdit: false, // Enable quick edit mode
    macOptionSelectionMode: 'vertical', // Options: 'vertical', 'force'
    windowSize: [840, 600],

    // Performance settings
    webGLRenderer: true, // Use WebGL for rendering (faster, but may not support transparency)
    disableLigatures: false, // Enable font ligatures
    disableAutoUpdates: true, // Enable automatic updates
    screenReaderMode: false, // Enable screen reader support
    preserveCWD: false, // Preserve working directory when creating splits or tabs

    // Web link activation key
    webLinksActivationKey: '', // Options: 'ctrl', 'alt', 'meta', 'shift'
  },

  // Opacity settings (for transparency)
  // opacity: {
//     focus: 0.5, // Fully opaque when focused
//     blur: 0.5, // Semi-transparent when blurred
//   },

  hyperTransparent: {
    backgroundColor: '#000',
    opacity: 0.9,
    vibrancy: '' // ['', 'dark', 'medium-light', 'ultra-dark']
  },
  // Plugins to install from npm
  plugins: [
         "hyperborder",
         "hyper-opacity",
         "hyper-tab-icons",
         "hyper-search",
         "hyperpower",
         "hypercwd",
	  	   "hyper-transparent",
   ],

  // Local plugins (for development)
  localPlugins: [],
   
   // Custom keymaps
   keymaps: {
     // Window management
     'window:new': 'Cmd+N', // Open a new window
     'window:reload': 'Cmd+R', // Reload the current window
     'window:devtools': 'Cmd+Alt+I', // Open DevTools
     'window:toggleFullScreen': 'Cmd+Ctrl+F', // Toggle fullscreen mode

     // Tab management
     'tab:new': 'Cmd+T', // Open a new tab
     'tab:next': 'Ctrl+Tab', // Switch to the next tab
     'tab:prev': 'Ctrl+Shift+Tab', // Switch to the previous tab
     'tab:close': 'Cmd+W', // Close the current tab

     // Pane management (splits)
     'pane:splitVertical': 'Cmd+D', // Split vertically
     'pane:splitHorizontal': 'Cmd+Shift+D', // Split horizontally
     'pane:close': 'Cmd+Shift+W', // Close the current pane

     // Navigation
     'editor:moveBeginningLine': 'Cmd+Left', // Move cursor to the beginning of the line
     'editor:moveEndLine': 'Cmd+Right', // Move cursor to the end of the line
     'editor:moveNextWord': 'Alt+Right', // Move cursor to the next word
     'editor:movePrevWord': 'Alt+Left', // Move cursor to the previous word

     // Text selection
     'editor:selectAll': 'Cmd+A', // Select all text
     'editor:copy': 'Cmd+C', // Copy selected text
     'editor:paste': 'Cmd+V', // Paste text
     'editor:cut': 'Cmd+X', // Cut selected text

     // Search and clear
     'editor:find': 'Cmd+F', // Open search bar
     'editor:clearBuffer': 'Cmd+K', // Clear the terminal buffer

     // Custom commands
     'custom:openSettings': 'Cmd+,', // Open Hyper settings
     'custom:openPluginsFolder': 'Cmd+Shift+P', // Open Hyper plugins folder
   },  
};
