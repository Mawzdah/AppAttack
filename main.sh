#!/bin/bash

# Dynamically determine the directory of the script
if [[ -L "$0" ]]; then
    # If executed via a symlink, resolve to the installation directory
    SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"
else
    # If running directly, use the source directory
    SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
fi

# Source other scripts using absolute paths
source "$SCRIPT_DIR/colours.sh"
source "$SCRIPT_DIR/menus.sh"
source "$SCRIPT_DIR/install_tools.sh"
source "$SCRIPT_DIR/update_tools.sh"
source "$SCRIPT_DIR/run_tools.sh"
source "$SCRIPT_DIR/utilities.sh"
source "$SCRIPT_DIR/step_by_step.sh"
source "$SCRIPT_DIR/automate.sh"

# Main function
main() {
    # Initialize log file by clearing its contents
    echo "" > "$LOG_FILE"
    
    # Check and install dependencies
    check_and_install_dependencies
    
    # Ask if the user wants to output to a file
    read -p "Do you want to output results to a file? (y/n): " output_to_file
    if [[ "$output_to_file" == "y" ]]; then
        read -p "Enter the output directory path: " OUTPUT_DIR
        if [[ ! -d "$OUTPUT_DIR" ]]; then
            mkdir -p "$OUTPUT_DIR"
        fi
    else
        OUTPUT_DIR=""
    fi
    
    while true; do
        display_main_menu
        read -p "Choose an option: " main_choice
        case $main_choice in
            1) handle_penetration_testing_tools "$OUTPUT_DIR" ;;
            2) handle_secure_code_review_tools "$OUTPUT_DIR" ;;
            3) handle_iot_security_tools "$OUTPUT_DIR" ;;
            4) handle_step_by_step_guide ;;
            5) handle_automated_processes_menu ;;
            6) echo -e "${YELLOW}Exiting...${NC}"
                log_message "Script ended"
                exit 0 ;;
            *) echo -e "${RED}Invalid choice, please try again.${NC}"
                log_message "Invalid user input" ;;
        esac
    done
}

# Function to check and install dependencies
check_and_install_dependencies() {
    echo -e "${CYAN}Checking and installing dependencies...${NC}"
    
    # Check if npm is installed; if not, install it
    if ! command -v npm &> /dev/null; then
        install_npm
    fi
    
    # Check if Go is installed; if not, install it
    if ! command -v go &> /dev/null; then
        install_go
    fi

    # Install other tools
    install_osv_scanner
    install_snyk_cli
    install_brakeman
    install_bandit
    install_nmap
    install_ncrack
    install_nikto
    install_legion
    install_owasp_zap
    install_generate_ai_insights_dependencies
    install_john
    install_sqlmap
    install_metasploit
    install_sonarqube
    install_wapiti
    install_tshark
    install_binwalk
    install_hashcat
    install_aircrack
    install_miranda
    install_umap
    install_bettercap
    install_scapy
    install_wifiphisher
    install_reaver
    
    # Check for updates
    check_updates
}

# Execute main function to start the script
main