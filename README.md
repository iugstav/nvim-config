# My Neovim config!

My configs until 17/01/2025.

This `README` will guide you through the folders of my neovim configuration for personal use.

## `after/ftplugin/`

Contains all the language-specific tweaks like tabs spacing and all other vim-like modifications that should apply to this single language.

## `lua/iugstav/`

This folder is the heart of the configuration. It has the plugin and theme support, keybindings and general nvim configs.

- `init.lua` groups the configuration and contains some general modifications involving buffers and languages;
- `lazy_init.lua` has the plugin manager initialization;
- `remap.lua` has, exclusively, the keybindings and motions that i use everyday;
- `set.lua` contains nvim configuration;

## `lua/iugstav/lazy/`

Contains all the plugins that i use with [lazy](https://github.com/folke/lazy.nvim), from initialization to configuration.

## `lua/iugstav/colors/`
Contains my custom themes or specific customization details of existing themes.