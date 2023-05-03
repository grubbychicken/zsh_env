#!/bin/bash

# function to install oh-my-zsh
installOMZ(){
    echo "Installing oh-my-zsh..."
    if [ -d ~/.oh-my-zsh ]; then
        echo "️😅 It looks like ️oh-my-zsh is already installed!"
    else
        echo "💬 You'll need to 'exit' after OH-MY-ZSH is installed to get back to this menu" && sleep 3
 	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        echo "✅ All done!"
    fi
       read -p "Press any key to Continue...."
}

# function to install homebrew
installHomebrew(){
    echo "Installing homebrew 🍺"
    which -s brew
    if [[ $? != 0 ]] ; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
        echo "✅ All done!"
    else
        echo "😅 It looks like brew is already installed! Updating it now..."
        brew update
        echo "✅ All done!"
    fi   
    read -p "Press any key to Continue...."
}

# function to accept xcode EULA
acceptEULA(){
    echo "Accepting xcode EULA.  Please enter your password..."
    which -s xcodebuild
    if [[ $? != 0 ]] ; then
        sudo xcodebuild -license accept
        echo "✅ All done!"
    else
        echo "😅 It doesn't look like xcode is installed.  Download it from the app store."
    fi   
    read -p "Press any key to Continue...."
}

# function to install coreutils
installCoreutils(){
    echo "Installing coreutils..."
    which -s gcomm
    if [[ $? != 0 ]] ; then
        brew install coreutils
        echo "✅ All done!"
    else
        echo "👍 It looks like coreutils is already installed.  Updating it now..."
        brew upgrade coreutils
    fi
    read -p "Press any key to Continue...."
}

# function to install iTerm2
installIterm(){
    echo "Installing iTerm2..."
    ls /Applications | grep -i iterm.app
    if [[ $? != 0 ]] ; then
        which -s brew
        if [[ $? != 1 ]] ; then
            brew install --cask iterm2
            echo "✅ All done! Continue the rest of the setup in iTerm2."
	    open /Applications/iTerm.app
            launchIterm &
        else
	    echo "Please install Homebrew🍺 first!"
        fi
    else
        echo "😅 It looks like iTerm2 is already installed."
        launchIterm &
    fi
    read -p "Press any key to Continue...."
    echo "See you over in iTerm2 😁 "
    exit 1
}

# function to launch iTerm2 and run this script
launchIterm (){
    osascript <<EOF
    tell application "iTerm2"
         create window with default profile
         tell current session of current window
              delay 1
              write text "cd $PWD"
              write text "./install.sh"
          end tell
    end tell
EOF
}


# function to install ZSH plugins and passion theme
customiseZSH(){
    echo "Customising ZSH - Let's get this party started!"
    brew install exa
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    git clone https://github.com/MohamedElashri/exa-zsh ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/exa-zsh
    git clone https://github.com/b4b4r07/enhancd.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/enhancd
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install
    if [ -f ~/.zshrc ]; then
        mv ~/.zshrc ~/.zshrc.old
    fi
    if [ ! -f .zshrc ]; then
        echo "Can't find the new .zshrc file to load.  Make sure it's in the same directory as this script." 
    else
        cp .zshrc ~/.zshrc
    fi
    if [ ! -f passion.zsh-theme ]; then
        echo "Can't find the new zsh-theme file to load.  Make sure it's in the same directory as this script."
    else
        cp passion.zsh-theme ~/.oh-my-zsh/themes/
    fi    
    echo "✅ All done!"
    echo "💬 Don't forget to import and update the colour profile in iTerm"
    read -p "Press any key to Continue...."
}

# function to show menu
show_menu()
{
       clear
       echo "+*+*+*+*+*+*+*+*+*+*+*+ MENU +*+*+*+*+*+*+*+*+*+*+*+*+"
       echo "0. Install homebrew🍺"
       echo "1. Install iTerm2"
       echo "2. Install oh-my-zsh"
       echo "3. Install coreutils"
       echo "4. Customise ZSH"
       echo "5. Accept Xcode EULA (Probably not needed)"
       echo "6. Exit"
       echo "+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+*+"
}

# function to take input
take_input()
{
       #take the input and store it in choice variable
       local choice
       read -p "Select an option: " choice
        
       #using switch case statement check the choice and call function.
       case $choice in
               0) installHomebrew ;;
               1) installIterm ;;
               2) installOMZ ;;
               3) installCoreutils ;;
               4) customiseZSH ;;
               5) acceptEULA ;;
               6) echo "💬 Either close and re-open iTerm or run 'source ~/.zshrc'" && sleep 3 && exit 0;;
               #x) launchIterm ;;
               *) echo "Please chose a valid option!!"
                       read -p "Press any key to Continue...."

               esac
       }

# for loop to call the show_menu and take_input function.
while true
do
       show_menu
       take_input
done

