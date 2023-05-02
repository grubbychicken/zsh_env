#!/bin/sh

while true; do
    read -p "-> Have you accepted the xcode EULA [y/n]? " yn
    case $yn in
        [Yy]* ) echo "Awesome 🤙"; break;;
        [Nn]* ) echo "Before you run this script, please accept the xcode EULA with:"; echo "    \033[1msudo xcodebuild -license\033[0m"; exit;;
        * ) echo "Please answer y or n";;
    esac
done

while true; do
    read -p "-> Have you installed Homebrew🍺 [y/n]? " yn
    case $yn in
        [Yy]* ) echo "Perfect 👌"; break;;
        [Nn]* ) echo "Before you run this script, please install Homebrew🍺 with:"; echo '    \033[1m/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"\033[0m'; exit;;
        * ) echo "Please answer y or n";;
    esac
done

echo "🎯 Installing zsh plugins..."
brew install exa
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/MohamedElashri/exa-zsh ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/exa-zsh
git clone https://github.com/b4b4r07/enhancd.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/enhancd
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
echo "✅ plugins installed"
echo "🎯 Installing zsh theme -> passion..."
cp .zshrc ~/.zshrc
cp passion.zsh-theme ~/.oh-my-zsh/themes/
echo "✅ theme installed"
