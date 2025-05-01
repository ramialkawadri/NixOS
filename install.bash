#!/bin/bash
git clone https://github.com/ramialkawadri/Neovim-config.git  ~/.config/nvim
cd ~/.config/nvim || exit
bash ./lazygit/install_config.bash
bash ./vsnip/install_snippets.bash
cd - || exit
mkdir -p ~/Projects/
