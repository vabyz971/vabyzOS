#!/usr/bin/env bash



# CONFIGURATION VARIABLES
username=""
gitUsername=""
gitEmail=""
hostname=""
gpu=""
keyboardLayout=""
i18nLocalLanguage=""

# VARIABLES COLOR
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color


# TEXT DESIGN FUNCTION

function print_bordered_message {
    local message=$1
    local color=$2
    local length=${#message}
    local border=""
    for (( i=0; i<length+4; i++ )); do
        border="$border#"
    done
    clear
    echo -e "${color}$border${NC}"
    echo -e "${color}# $message #${NC}"
    echo -e "${color}$border${NC}"
    echo
}

function print_error {
    local message=$1
    echo -e "${RED}Error: $message${NC}"
}

function print_success {
    local message=$1
    echo -e "${GREEN}Success: $message${NC}"
}

function print_info {
    local message=$1
    echo -e "${BLUE}Info: $message${NC}"
}

function print_warning {
    local message=$1
    echo -e "${YELLOW}Warning: $message${NC}"
}


# FUNCTIONS

function detected_os {
    print_info "Detected distribution"
    if [ -n "$(grep -i nixos < /etc/os-release)" ]; then
        PRETTY_NAME=$(grep 'PRETTY_NAME' /etc/os-release | cut -d '"' -f 2)
        print_success "$PRETTY_NAME"
    else
        print_error "Sorry, my configuration is compatible only with NixOS"
        exit
    fi
}

# Function to modify a value in the configuration file
function add_value_config {
    local key="$1"
    local value="$2"

    FILE="./global/variables.nix"

    if [ ! -f "$FILE" ]; then
        echo "Erreur : The $FILE file does not exist"
        exit 1
    fi

    # Change the value in the file
    if [[ "$value" == *""* ]]; then
        # If the value contains spaces, do not add additional quotes
        sed -i "s|\($key = \).*|\1$value;|" "$FILE"
    else
        # Otherwise, add quotes around the value
        sed -i "s|\($key = \).*|\1\"$value\";|" "$FILE"
    fi
}

function show_config(){
    clear
    print_bordered_message "--- Configuration ---"
    echo -e "- username: ${GREEN}$username${NC}"
    echo -e "- gitUsername: ${GREEN}$gitUsername${NC}"
    echo -e "- gitEmail: ${GREEN}$gitEmail${NC}"
    echo -e "- hostname: ${GREEN}$hostname${NC}"
    echo -e "- gpu driver: ${GREEN}$gpu${NC}"
    echo -e "- keyboardLayout: ${GREEN}$keyboardLayout${NC}"
    echo -e "- i18nLocalLanguage: ${GREEN}$i18nLocalLanguage${NC}"
}

function config_install {
    echo
    print_info "Configuration Installation"

    echo -e "Is the username correct ? ${BLUE}$USER${NC}"
    read -p "y/n: " reponse
    if [ "$reponse" = "y" ]; then
        username=${USER:-$username}
        echo -e "User: "$username
    else
        echo -e "Enter the username"
        read -p "User: " new_user
        username=${new_user:-$username}
    fi

    echo
    echo -e "-------------------------"

    echo -e "Do you want to use ${BLUE}$USER${NC} as: gitUsername"
    read -p "y/n: " reponse
    if [ "$reponse" = "y" ]; then
        gitUsername=${USER:-$gitUsername}
        echo -e "gitUsername: "$gitUsername
    else
        read -p "Enter gitUsername: " new_user_git
        gitUsername=${new_user_git:-$gitUsername}
    fi

    echo
    echo -e "-------------------------"

    echo -e "Do you want to use  ${BLUE}$gitUsername@gmail.com${NC} as: gitEmail"
    read -p "y/n: " reponse
    if [ "$reponse" = "y" ]; then
        GMAIL=($gitUsername@gmail.com)
        gitEmail=${GMAIL:-$gitEmail}
        echo -e "gitUsername: "$gitEmail
    else
        read -p "Enter gitEmail: " new_user_gitEmail
        gitEmail=${new_user_gitEmail:-$gitEmail}
    fi

    echo
    echo -e "-------------------------"

    echo -e "Do you want to use ${BLUE}$USER${NC} as: hostname"
    read -p "y/n: " reponse
    if [ "$reponse" = "y" ]; then
        hostname=${USER:-$hostname}
        echo -e "hostname: "$hostname
    else
        read -p "Enter hostname: " new_hostname
        hostname=${new_hostname:-$hostname}
    fi


    echo
    echo -e "-------------------------"

    echo -e "Which ${BLUE}GPU${NC} are you using ?"
    echo -e "- 1: NVIDIA"
    echo -e "- 2: AMD"
    echo -e "- 3: INTEL"
    echo -e "- 4: VM"
    read -p "Choose: " gpu_card
    case $gpu_card in
        1)
            value="nvidia"
            gpu=${value:-$gpu};;
        2)
            value="amd"
            gpu=${value:-$gpu};;
        3)
            value="intel"
            gpu=${value:-$gpu};;
        4)
            value="vm"
            gpu=${value:-$gpu};;
    esac

    echo
    echo -e "-------------------------"
    echo -e "Keyboard [fr, en]"
    read -p "[fr, en]: " keyboard
    keyboardLayout=${keyboard:-$keyboardLayout}

    echo
    echo -e "-------------------------"
    echo -e "Choose your language"
    print_warning "Detected language: $LANG"
    read -p "Do you want to change the language (y/n): " reponse
    if [ "$reponse" = "n" ]; then
        i18nLocalLanguage=${LANG:-$i18nLocalLanguage}
    else
        echo -e "Enter language system [ fr_FR-UTF8, fr_CA.UTF-8, en_US.UTF-8 ]"
        read -p "Language: " value_lang_system
        i18nLocalLanguage=${value_lang_system:-$i18nLocalLanguage}
    fi

    show_config

    echo
    echo -e "-------------------------"
    echo
    read -p "Do you want to install the configuration or modify a parameter (y/n/q): " option
    case $option in
        y)
            install;;
        n)
            config_install;;
        q)
            clear
            exit 1;;
    esac
}


install(){
    clear
    print_bordered_message "Installation"
    print_info "--- Generate hardware config ---"
    sudo nixos-generate-config --show-hardware-config > ./hosts/hardware.nix
    print_success "--- Done ---"

    echo -e "--- Initialize variables ---"
    print_info "Load variables"
    add_value_config "gitUsername" "\"$gitUsername\""
    add_value_config "gitEmail" "\"$gitEmail\""
    add_value_config "username" "\"$username\""
    add_value_config "hostname" "\"$hostname\""
    add_value_config "keyboardLayout" "\"$keyboardLayout\""
    add_value_config "consoleKeyMap" "\"$keyboardLayout\""
    add_value_config "i18nLocalLanguage" "\"$i18nLocalLanguage\""
    print_success "--- Done ---"

    clear
    print_info "Install config"
    sudo nixos-rebuild switch --flake ~/vabyzOS/#gnome
}


print_bordered_message "VABYZOS CONFIGURATION NIXOS"
detected_os
config_install