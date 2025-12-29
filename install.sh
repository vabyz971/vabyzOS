#!/usr/bin/env bash

# ============================================
# INSTALLATION SCRIPT FOR MODULAR NIXOS CONFIG
# Usage: curl -L https://raw.githubusercontent.com/vabyz971/vabyzOS/main/install.sh | bash
# ============================================

# Configuration
REPO_URL="https://github.com/vabyz971/vabyzOS"
CONFIG_DIR="${HOME}/vabyzOS"
DEFAULT_BRANCH="main"

# Couleurs
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

# ==================== FONCTIONS D'AFFICHAGE ====================

print_header() {
    clear
    echo -e "${CYAN}"
    echo "=========================================="
    echo "   VABYZOS - NIXOS CONFIGURATION INSTALLER"
    echo "=========================================="
    echo -e "${NC}"
}

print_success() { echo -e "${GREEN}[✓] $1${NC}"; }
print_error() { echo -e "${RED}[✗] $1${NC}"; }
print_info() { echo -e "${BLUE}[i] $1${NC}"; }
print_warning() { echo -e "${YELLOW}[!] $1${NC}"; }

print_menu() {
    echo -e "${CYAN}"
    echo "=========================================="
    echo "$1"
    echo "=========================================="
    echo -e "${NC}"
}

# ==================== FONCTIONS UTILITAIRES ====================

check_nixos() {
    if [ ! -f /etc/os-release ] || ! grep -qi "nixos" /etc/os-release; then
        print_error "Ce script est compatible uniquement avec NixOS."
        exit 1
    fi
    print_success "Système NixOS détecté"
}

clone_or_update_repo() {
    if [ -d "${CONFIG_DIR}/.git" ]; then
        print_info "Mise à jour du dépôt existant..."
        cd "${CONFIG_DIR}" && git pull origin "${DEFAULT_BRANCH}"
    else
        print_info "Clonage du dépôt..."
        git clone --branch "${DEFAULT_BRANCH}" "${REPO_URL}" "${CONFIG_DIR}"
    fi
    
    if [ $? -ne 0 ]; then
        print_error "Échec du clonage/mise à jour du dépôt"
        exit 1
    fi
    cd "${CONFIG_DIR}"
    print_success "Dépôt prêt dans ${CONFIG_DIR}"
}

# ==================== CONFIGURATION ====================

collect_user_info() {
    print_menu "CONFIGURATION UTILISATEUR"
    
    # Valeurs par défaut
    CURRENT_USER=$(whoami)
    DEFAULT_GIT_EMAIL="${CURRENT_USER}@gmail.com"
    
    # Nom d'utilisateur système
    read -p "Nom d'utilisateur système [${CURRENT_USER}]: " SYS_USERNAME
    SYS_USERNAME=${SYS_USERNAME:-$CURRENT_USER}
    
    # Configuration Git
    read -p "Nom d'utilisateur Git [${SYS_USERNAME}]: " GIT_USERNAME
    GIT_USERNAME=${GIT_USERNAME:-$SYS_USERNAME}
    
    read -p "Email Git [${DEFAULT_GIT_EMAIL}]: " GIT_EMAIL
    GIT_EMAIL=${GIT_EMAIL:-$DEFAULT_GIT_EMAIL}
    
    
    # Clavier
    print_info "Disposition du clavier: fr (azerty), en (qwerty), be (azerty belge)"
    read -p "Disposition [fr]: " KEYBOARD_LAYOUT
    KEYBOARD_LAYOUT=${KEYBOARD_LAYOUT:-"fr"}
    
    # Langue
    print_info "Langue du système (ex: fr_FR.UTF-8, en_US.UTF-8)"
    read -p "Langue [fr_FR.UTF-8]: " LOCALE
    LOCALE=${LOCALE:-"fr_FR.UTF-8"}
}

select_host() {
    print_menu "SÉLECTION DE L'HÔTE"
    echo "1. Desktop (Bureau)"
    echo "2. VM (machine virtuelle)"
    echo
    
    local valid=0
    while [ $valid -eq 0 ]; do
        read -p "Choix [1-5]: " host_choice
        case $host_choice in
            1) HOST_TYPE="desktop"; HOST_NAME="desktop"; valid=1 ;;
            2) HOST_TYPE="vm"; HOST_NAME="vm"; valid=1 ;;
            *) print_error "Choix invalide. Réessayez." ;;
        esac
    done
    
    # Créer le répertoire hôte s'il n'existe pas
    mkdir -p "hosts/${HOST_NAME}"
    print_success "Hôte sélectionné: ${HOST_NAME}"
}

select_flake_profile() {
    print_menu "SÉLECTION DU PROFIL FLAKE"
    echo "Profils disponibles:"
    echo "1. vabyz971 (configuration principale)"
    echo "2. vm (configuration minimale)"
    echo
    
    local valid=0
    while [ $valid -eq 0 ]; do
        read -p "Choix [1-5]: " profile_choice
        case $profile_choice in
            1) FLAKE_PROFILE="vabyz971"; valid=1 ;;
            2) FLAKE_PROFILE="vm"; valid=1 ;;
            *) print_error "Choix invalide. Réessayez." ;;
        esac
    done
    print_success "Profil flake sélectionné: ${FLAKE_PROFILE}"
}

show_summary() {
    print_menu "RÉSUMÉ DE LA CONFIGURATION"
    echo -e "• Utilisateur système: ${GREEN}${SYS_USERNAME}${NC}"
    echo -e "• Utilisateur Git: ${GREEN}${GIT_USERNAME}${NC}"
    echo -e "• Email Git: ${GREEN}${GIT_EMAIL}${NC}"
    echo -e "• Hostname: ${GREEN}${HOSTNAME}${NC}"
    echo -e "• Disposition clavier: ${GREEN}${KEYBOARD_LAYOUT}${NC}"
    echo -e "• Langue système: ${GREEN}${LOCALE}${NC}"
    echo -e "• Profil Flake: ${GREEN}${FLAKE_PROFILE}${NC}"
    echo
}

confirm_installation() {
    read -p "Procéder à l'installation? (o/N): " confirm
    [[ $confirm =~ ^[OoYy]$ ]] || exit 0
}

# ==================== GÉNÉRATION ====================

generate_hardware_config() {
    print_info "Génération de la configuration matérielle..."
    
    HARDWARE_DIR="hosts/${HOST_NAME}"
    HARDWARE_FILE="${HARDWARE_DIR}/hardware.nix"
    
    print_info "Exécution de nixos-generate-config pour ${HOST_NAME}..."
    
    if sudo nixos-generate-config --show-hardware-config > "${HARDWARE_FILE}"; then
        # Renommer le fichier généré
        if [ -f "${HARDWARE_DIR}/hardware.nix" ]; then
            print_success "Configuration matérielle générée: ${HARDWARE_FILE}"
        else
            print_warning "Fichier hardware.nix non trouvé, création d'un template..."
            create_hardware_template "${HARDWARE_FILE}"
        fi
    else
        print_error "Échec de la génération de la configuration matérielle"
        print_warning "Création d'un fichier hardware template..."
        create_hardware_template "${HARDWARE_FILE}"
    fi
}

create_hardware_template() {
    local file="$1"
    cat > "${file}" << 'EOF'
# Configuration matérielle générée pour ${HOST_NAME}
{ config, lib, pkgs, modulesPath, ... }:
{
  imports = [ (modulesPath + "/installer/scan/not-detected.nix") ];
  
  boot.initrd.availableKernelModules = [ ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ ];
  boot.extraModulePackages = [ ];
  
  fileSystems."/" = {
    device = "/dev/disk/by-uuid/CHANGEME";
    fsType = "ext4";
  };
  
  swapDevices = [ ];
  
  # Activer le microcode si nécessaire
  # hardware.cpu.intel.updateMicrocode = true;
  # hardware.cpu.amd.updateMicrocode = true;
}
EOF
    print_info "Template hardware créé. Pensez à mettre à jour les UUID des disques!"
}

update_variables_nix() {
    print_info "Mise à jour des variables globales..."
    
    # Créer le répertoire global s'il n'existe pas
    mkdir -p global
    
    cat > global/variables.nix << EOF
# Fichier généré automatiquement par install.sh
{
  gitUsername = "${GIT_USERNAME}";
  gitEmail = "${GIT_EMAIL}";
  username = "${SYS_USERNAME}";
  keyboardLayout = "${KEYBOARD_LAYOUT}";
  consoleKeyMap = "${KEYBOARD_LAYOUT}";
  i18nLocalLanguage = "${LOCALE}";
  
  # Informations sur l'hôte
  host = {
    name = "${HOST_NAME}";
    type = "${HOST_TYPE}";
    flakeProfile = "${FLAKE_PROFILE}";
  };
}
EOF
    print_success "Variables globales mises à jour"
}

# ==================== INSTALLATION ====================

run_nixos_rebuild() {
    print_menu "INSTALLATION FINALE"
    print_info "Exécution de nixos-rebuild avec le profil ${FLAKE_PROFILE}..."
    echo
    
    print_warning "Cette étape nécessite les privilèges sudo."
    read -p "Continuer avec nixos-rebuild switch? (o/N): " rebuild_confirm
    
    if [[ $rebuild_confirm =~ ^[OoYy]$ ]]; then
        if sudo nixos-rebuild switch --flake ".#${FLAKE_PROFILE}"; then
            print_success "Installation terminée avec succès!"
            print_info "Redémarrez si nécessaire pour appliquer tous les changements."
        else
            print_error "L'installation a échoué. Vérifiez les erreurs ci-dessus."
            exit 1
        fi
    else
        print_info "Installation annulée. Vous pouvez exécuter manuellement:"
        echo -e "  ${CYAN}sudo nixos-rebuild switch --flake .#${FLAKE_PROFILE}${NC}"
    fi
}

# ==================== FONCTION PRINCIPALE ====================

main() {
    print_header
    check_nixos
    clone_or_update_repo
    
    # Collecte des informations
    collect_user_info
    select_host
    select_flake_profile
    show_summary
    confirm_installation
    
    # Génération et installation
    generate_hardware_config
    update_variables_nix
    run_nixos_rebuild
    
    print_menu "INSTALLATION TERMINÉE"
    echo -e "${GREEN}Configuration réussie!${NC}"
    echo
    echo "Récapitulatif:"
    echo -e "• Hôte configuré: ${CYAN}${HOST_NAME}${NC}"
    echo -e "• Profil activé: ${CYAN}${FLAKE_PROFILE}${NC}"
    echo -e "• Configuration matérielle: ${CYAN}hosts/${HOST_NAME}/hardware.nix${NC}"
    echo -e "• Variables globales: ${CYAN}global/variables.nix${NC}"
    echo
    echo "Pour modifier la configuration:"
    echo "  cd ${CONFIG_DIR}"
    echo "  ./install.sh  # Ré-exécuter ce script"
}

# ==================== POINT D'ENTRÉE ====================

# Vérifier si le script est exécuté directement
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
    # Gérer les arguments de ligne de commande
    if [[ "$1" == "--help" || "$1" == "-h" ]]; then
        echo "Usage:"
        echo "  ./install.sh                    # Mode interactif"
        echo "  curl -L ${REPO_URL}/main/install.sh | bash  # Depuis GitHub"
        echo
        echo "Options:"
        echo "  --help, -h      Afficher cette aide"
        exit 0
    fi
    
    # Exécuter la fonction principale
    main
fi