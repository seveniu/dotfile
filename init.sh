#!/bin/bash
# 获取平台类型，mac还是linux平台
function get_platform_type()
{
    echo $(uname)
}

# 安装mac平台字体
function install_fonts_on_mac()
{
    rm -rf ~/Library/Fonts/Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete.otf
    cp ./fonts/Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete.otf ~/Library/Fonts
}

# 安装linux平台字体
function install_fonts_on_linux()
{
    mkdir ~/.fonts

    rm -rf ~/.fonts/PowerlineSymbols.otf
    cp ./fonts/PowerlineSymbols.otf ~/.fonts

    rm -rf ~/.fonts/Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete.otf
    cp ./fonts/Droid\ Sans\ Mono\ for\ Powerline\ Nerd\ Font\ Complete.otf ~/.fonts

    fc-cache -vf ~/.fonts

    mkdir -p ~/.config/fontconfig/conf.d

    rm -rf ~/.config/fontconfig/conf.d/10-powerline-symbols.conf
    cp ./fonts/10-powerline-symbols.conf ~/.config/fontconfig/conf.d
}

# main函数
function main()
{
    type=`get_platform_type`
    echo "platform type: "${type}

    if [ ${type} == "Darwin" ]; then 
        install_fonts_on_mac
    elif [ ${type} == "Linux" ]; then
        install_fonts_on_linux
    else
        echo "not support platform type: "${type}
    fi
    # install oh my zsh
    sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

    ln -s zshrc ~/.zshrc


    # install vim
    brew install vim 
    rm -rf ~/.vimrc
    rm -rf ~/.vimrc.local
    ln -s ${PWD}vimrc ~/.vimrc

    # install vundle
    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
    # install vim plugin
    vim -c "PluginInstall" -c "q" -c "q"

}
main
