#!/usr/bin/env bash


username=""
gitUsername=""
gitEmail=""
hostname=""
keyboardLayout=""
i18nLocalLanguage=""




# Function to modify a value in the configuration file
# Fonction pour modifier une valeur dans le fichier de configuration
add_value_config(){
    local key="$1"
    local value="$2"

    FILE="./global/variables.nix"

    if [ ! -f "$FILE" ]; then
        echo "Erreur : The $FILE file does not exist"
        exit 1
    fi

    # Change the value in the file
    # Modifier la valeur dans le fichier
    if [[ "$value" == *""* ]]; then
        # If the value contains spaces, do not add additional quotes
        # Si la valeur contient des espaces, ne pas ajouter de guillemets supplémentaires
        sed -i "s|\($key = \).*|\1$value;|" "$FILE"
    else
        # Otherwise, add quotes around the value
        # Sinon, ajouter des guillemets autour de la valeur
        sed -i "s|\($key = \).*|\1\"$value\";|" "$FILE"
    fi
}



title() {
    clear
    echo
    echo -e "\t\t Installation vabyzOS \n"
}

config(){
    echo
    echo -e "--- Configuration ---"
    echo -e "- username: $username"
    echo -e "- gitUsername: $gitUsername"
    echo -e "- gitEmail: $gitEmail"
    echo -e "- hostname: $hostname"
    echo -e "- keyboardLayout: $keyboardLayout"
    echo -e "- i18nLocalLanguage: $i18nLocalLanguage"
}

install(){
    clear
    echo -e "--- Generate config hardware ---"
    sudo nixos-generate-config --show-hardware-config > ./hosts/hardware.nix
    sleep 2
    echo -e "--- Done ---"

    echo -e "--- Init variable ---"
    add_value_config "gitUsername" "\"$gitUsername\""
    add_value_config "gitEmail" "\"$gitEmail\""
    add_value_config "username" "\"$username\""
    add_value_config "hostname" "\"$hostname\""
    add_value_config "keyboardLayout" "\"$keyboardLayout\""
    add_value_config "consoleKeyMap" "\"$keyboardLayout\""
    add_value_config "i18nLocalLanguage" "\"$i18nLocalLanguage\""
    
    config
    echo -e "--- Done ---"
    clear
    echo -e "--- Installation Configuration ---"
    sudo nixos-rebuild switch --flake ~/vabyzOS/#gnome

}

menu_list() {
    echo
    echo -e "\t Menu list"
    echo -e "\te. Edit config"
    echo -e "\tq. Quit"
    echo -e "\t Enter option: "
    read -n 1 option
}

edit_config(){
    clear
    echo
    echo -e "--- Edite config ---"

    echo -e "-- Enter user name computer --"
    read -p "- User name: " value_username
    username=${value_username:-$username}

    echo -e "-- Enter user name Github --"
    read -p "- Git user: " value_git_user
    gitUsername=${value_git_user:-$gitUsername}

    echo -e "-- Enter email Github --"
    read -p "- Git email: " value_git_email
    gitEmail=${value_git_email:-$gitEmail}

    echo -e "-- Enter name network --"
    read -p "- Host name: " value_host_name
    hostname=${value_host_name:-$hostname}

    echo -e "-- Enter layout keyboard [ fr or en ] --"
    read -p "- Keyboard: " value_key_lang
    keyboardLayout=${value_key_lang:-$keyboardLayout}

    echo -e "-- Enter language system [ fr_FR-UTF8, fr_CA.UTF-8, en_US.UTF-8 ] --"
    read -p "- Language: " value_lang_system
    i18nLocalLanguage=${value_lang_system:-$i18nLocalLanguage}

    config

    while [ 1 ]
    do
        echo -e "### Install config (y/n)"
        read -n 1 option

        case $option in
        0)
            break ;;
        y)
            install ;;
        n)
            exit 1 ;;
        *)
            echo "Choose y or n"
        esac
        echo -en "Hit any key to continue ..."
        read -n 1 line
    done
}

check_nixos() {
    if [ -n "$(grep -i nixos < /etc/os-release)" ]; then
        echo "Check: Nixos ✅"
    else
        echo "vabyzOS is compatible only for nixos ❌"
        exit 1
    fi
}

title
check_nixos
config
menu_list

case $option in 
    0)
        break;;
    e)
        edit_config;;
    q)
        exit 1;;
esac