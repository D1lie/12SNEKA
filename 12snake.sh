#!/bin/bash

# Display banner
function show_banner() {
    echo -e "\033[1;34m"
    cat << "EOF"

 Advanced Web Vulnerability Scanner

 ██╗██████╗ ███████╗███╗   ██╗ █████╗ ██╗  ██╗███████╗
███║╚════██╗██╔════╝████╗  ██║██╔══██╗██║ ██╔╝██╔════╝
╚██║ █████╔╝███████╗██╔██╗ ██║███████║█████╔╝ █████╗  
 ██║██╔═══╝ ╚════██║██║╚██╗██║██╔══██║██╔═██╗ ██╔══╝  
 ██║███████╗███████║██║ ╚████║██║  ██║██║  ██╗███████╗
 ╚═╝╚══════╝╚══════╝╚═╝  ╚═══╝╚═╝  ╚═╝╚═╝  ╚═╝╚══════╝

created by: d1lie
Github: https://github.com/D1lie

EOF
    echo -e "\033[0m"
}

# Check if tool is installed and install if not
function check_and_install_tool() {
    if ! command -v "$1" &> /dev/null; then
        echo -e "\033[1;31m[!] $1 is not installed. Attempting to install...\033[0m"
        sudo apt install -y "$1"
        if [[ $? -ne 0 ]]; then
            echo -e "\033[1;31m[!] Failed to install $1. Please install it manually.\033[0m"
            return 1
        fi
    fi
    return 0
}

# Check all required tools
function check_tools() {
    tools=("whatweb" "wpscan" "amass" "nmap" "gobuster" "dirb" "nikto" "gospider" "katana" "sqlmap" "dalfox" "nuclei")
    for tool in "${tools[@]}"; do
        check_and_install_tool "$tool" || exit 1
    done
}

# Main menu function
function main_menu() {
    while true; do
        clear
        show_banner
        
        echo -e "\033[1;36mSelect a tool to run:\033[0m"
        echo -e "\033[1;33m 1. WhatWeb - Web server scanner"
        echo " 2. WPScan - WordPress vulnerability scanner"
        echo " 3. Amass - DNS enumeration and reconnaissance"
        echo " 4. Nmap - Port scanner"
        echo " 5. Gobuster - Directory/DNS bruteforcer"
        echo " 6. Dirb - Web directory scanner"
        echo " 7. Nikto - Web server scanner"
        echo " 8. GoSpider - Fast web spider"
        echo " 9. Katana - Advanced web crawling"
        echo "10. SQLMap - SQL injection scanner"
        echo "11. Dalfox - XSS scanner"
        echo "12. Nuclei - Fast vulnerability scanner"
        echo "13. Run All Scans"
        echo "14. Exit"
        
        read -p "Enter your choice (1-14): " choice
        
        case $choice in
            1)
                run_whatweb
                ;;
            2)
                run_wpscan
                ;;
            3)
                run_amass
                ;;
            4)
                run_nmap
                ;;
            5)
                run_gobuster
                ;;
            6)
                run_dirb
                ;;
            7)
                run_nikto
                ;;
            8)
                run_gospider
                ;;
            9)
                run_katana
                ;;
            10)
                run_sqlmap
                ;;
            11)
                run_dalfox
                ;;
            12)
                run_nuclei
                ;;
            13)
                run_all_scans
                ;;
            14)
                echo -e "\033[1;32m[+] Exiting...\033[0m"
                exit 0
                ;;
            *)
                echo -e "\033[1;31m[!] Invalid choice. Please try again.\033[0m"
                sleep 1
                ;;
        esac
        
        read -p "Press Enter to continue..."
    done
}

# Tool runner functions with error handling
function run_whatweb() {
    read -p "Enter target URL/IP: " target
    read -p "Enter output filename (or press Enter to skip): " output_file
    echo -e "\033[1;32m[+] Running WhatWeb on $target\033[0m"
    if [[ -n "$output_file" ]]; then
        whatweb -v "$target" | tee "$output_file" || handle_error "WhatWeb"
    else
        whatweb -v "$target" || handle_error "WhatWeb"
    fi
}

function run_wpscan() {
    read -p "Enter WordPress site URL: " target
    read -p "Enter output filename (or press Enter to skip): " output_file
    echo -e "\033[1;32m[+] Running WPScan on $target\033[0m"
    if [[ -n "$output_file" ]]; then
        wpscan --url "$target" --enumerate vp,vt,tt,cb,dbe,u,m --plugins-detection aggressive | tee "$output_file" || handle_error "WPScan"
    else
        wpscan --url "$target" --enumerate vp,vt,tt,cb,dbe,u,m --plugins-detection aggressive || handle_error "WPScan"
    fi
}

function run_amass() {
    read -p "Enter target domain for Amass: " target
    read -p "Enter output filename (or press Enter to skip): " output_file
    echo -e "\033[1;32m[+] Running Amass on $target\033[0m"
    if [[ -n "$output_file" ]]; then
        amass enum -d "$target" | tee "$output_file" || handle_error "Amass"
    else
        amass enum -d "$target" || handle_error "Amass"
    fi
}

function run_nmap() {
    read -p "Enter target IP/host: " target
    read -p "Enter output filename (or press Enter to skip): " output_file
    echo -e "\033[1;32m[+] Running Nmap on $target\033[0m"
    if [[ -n "$output_file" ]]; then
        nmap -sV -sC -A -T4 -p- "$target" | tee "$output_file" || handle_error "Nmap"
    else
        nmap -sV -sC -A -T4 -p- "$target" || handle_error "Nmap"
    fi
}

function run_gobuster() {
    read -p "Enter target URL: " target
    read -p "Use (d)irectory or (v)host mode? (d/v): " mode
    read -p "Enter output filename (or press Enter to skip): " output_file
    
    if [[ "$mode" == "d" ]]; then
        read -p "Path to wordlist (press Enter to use default): " wordlist
        [[ -z "$wordlist" ]] && wordlist="/usr/share/wordlists/dirb/common.txt"
        echo -e "\033[1;32m[+] Running Gobuster (dir) on $target\033[0m"
        if [[ -n "$output_file" ]]; then
            gobuster dir -u "$target" -w "$wordlist" -x php,html,txt,js | tee "$output_file" || handle_error "Gobuster"
        else
            gobuster dir -u "$target" -w "$wordlist" -x php,html,txt,js || handle_error "Gobuster"
        fi
    else
        read -p "Enter domain for VHOST scanning: " domain
        echo -e "\033[1;32m[+] Running Gobuster (vhost) on $target\033[0m"
        if [[ -n "$output_file" ]]; then
            gobuster vhost -u "$target" -w "$wordlist" | tee "$output_file" || handle_error "Gobuster"
        else
            gobuster vhost -u "$target" -w "$wordlist" || handle_error "Gobuster"
        fi
    fi
}

function run_dirb() {
    read -p "Enter target URL: " target
    read -p "Path to wordlist (press Enter to use default): " wordlist
    [[ -z "$wordlist" ]] && wordlist="/usr/share/wordlists/dirb/common.txt"
    read -p "Enter output filename (or press Enter to skip): " output_file
    echo -e "\033[1;32m[+] Running Dirb on $target\033[0m"
    if [[ -n "$output_file" ]]; then
        dirb "$target" "$wordlist" | tee "$output_file" || handle_error "Dirb"
    else
        dirb "$target" "$wordlist" || handle_error "Dirb"
    fi
}

function run_nikto() {
    read -p "Enter target URL/IP: " target
    read -p "Enter output filename (or press Enter to skip): " output_file
    echo -e "\033[1;32m[+] Running Nikto on $target\033[0m"
    if [[ -n "$output_file" ]]; then
        nikto -h "$target" | tee "$output_file" || handle_error "Nikto"
    else
        nikto -h "$target" || handle_error "Nikto"
    fi
}

function run_gospider() {
    read -p "Enter target URL: " target
    read -p "Enter output filename (or press Enter to skip): " output_file
    echo -e "\033[1;32m[+] Running GoSpider on $target\033[0m"
    if [[ -n "$output_file" ]]; then
        gospider -s "$target" -d 2 -t 10 -c 10 --subs --robots --sitemap | tee "$output_file" || handle_error "GoSpider"
    else
        gospider -s "$target" -d 2 -t 10 -c 10 --subs --robots --sitemap || handle_error "GoSpider"
    fi
}

function run_katana() {
    read -p "Enter target URL: " target
    read -p "Enter output filename (or press Enter to skip): " output_file
    echo -e "\033[1;32m[+] Running Katana on $target\033[0m"
    if [[ -n "$output_file" ]]; then
        katana -u "$target" -d 5 -jc -kf -aff -c 10 | tee "$output_file" || handle_error "Katana"
    else
        katana -u "$target" -d 5 -jc -kf -aff -c 10 || handle_error "Katana"
    fi
}

function run_sqlmap() {
    read -p "Enter vulnerable URL with parameter: " target
    read -p "Enter output filename (or press Enter to skip): " output_file
    echo -e "\033[1;32m[+] Running SQLMap on $target\033[0m"
    if [[ -n "$output_file" ]]; then
        sqlmap -u "$target" --batch --level=3 --risk=3 --dbs | tee "$output_file" || handle_error "SQLMap"
    else
        sqlmap -u "$target" --batch --level=3 --risk=3 --dbs || handle_error "SQLMap"
    fi
}

function run_dalfox() {
    read -p "Enter target URL with parameter: " target
    read -p "Enter output filename (or press Enter to skip): " output_file
    echo -e "\033[1;32m[+] Running Dalfox on $target\033[0m"
    if [[ -n "$output_file" ]]; then
        dalfox url "$target" --custom-payload /path/to/xss-payloads.txt | tee "$output_file" || handle_error "Dalfox"
    else
        dalfox url "$target" --custom-payload /path/to/xss-payloads.txt || handle_error "Dalfox"
    fi
}

function run_nuclei() {
    read -p "Enter target URL/IP: " target
    read -p "Enter output filename (or press Enter to skip): " output_file
    echo -e "\033[1;32m[+] Running Nuclei on $target\033[0m"
    if [[ -n "$output_file" ]]; then
        nuclei -u "$target" -t /root/nuclei-templates/ | tee "$output_file" || handle_error "Nuclei"
    else
        nuclei -u "$target" -t /root/nuclei-templates/ || handle_error "Nuclei"
    fi
}

# Run all scans
function run_all_scans() {
    read -p "Enter target URL/IP for all scans: " target
    echo -e "\033[1;32m[+] Running all scans on $target\033[0m"
    
    run_whatweb "$target"
    run_wpscan "$target"
    run_amass "$target"
    run_nmap "$target"
    run_gobuster "$target"
    run_dirb "$target"
    run_nikto "$target"
    run_gospider "$target"
    run_katana "$target"
    run_sqlmap "$target"
    run_dalfox "$target"
    run_nuclei "$target"
}

# Handle errors
function handle_error() {
    local tool_name="$1"
    echo -e "\033[1;31m[!] An error occurred while running $tool_name.\033[0m"
    
    # Attempt to reinstall the tool
    echo -e "\033[1;33m[!] Attempting to reinstall $tool_name...\033[0m"
    if check_and_install_tool "$tool_name"; then
        echo -e "\033[1;32m[+] $tool_name has been reinstalled. Please try running the tool again.\033[0m"
    else
        echo -e "\033[1;31m[!] Failed to reinstall $tool_name. Please check the tool's installation and usage.\033[0m"
    fi
    
    read -p "Press Enter to return to the main menu..."
}

# Check all required tools before running the main menu
check_tools

# Make sure the script is executable
if [[ "$0" == "$BASH_SOURCE" ]]; then
    main_menu
fi