# ⚡ HACKNET - Sudo BruteForce v1.0

![Bash](https://img.shields.io/badge/Language-Bash-blue?style=for-the-badge&logo=gnu-bash)
![Platform](https://img.shields.io/badge/Platform-Linux-lightgrey?style=for-the-badge&logo=linux)
![Security](https://img.shields.io/badge/Security-Red%20Team-red?style=for-the-badge)

**Sudo BruteForce** es una herramienta de post-explotación diseñada para auditorías de seguridad en entornos Linux. Este script automatiza ataques de fuerza bruta local contra el comando `su` (Substitute User), permitiendo validar credenciales de manera eficiente y silenciosa.

---

## 🛠️ Características Principales

- **Banner HACKNET:** Interfaz visual profesional y agresiva.
- **Output Dinámico:** Sistema de limpieza de línea (`\r`) para una terminal organizada durante el ataque.
- **Validación Silenciosa:** Redirección de errores a `/dev/null` para evitar detección visual inmediata.
- **Manejo de Timeouts:** Implementación de `timeout` para prevenir que el script se cuelgue en procesos de autenticación lentos.
- **Interrupción Segura:** Captura de señales SIGINT (`Ctrl+C`) para detener el proceso sin corromper la terminal.

---

## 🚀 Instalación y Uso
```bash
git clone https://github.com/matiashenao/sudoBruteForce.git
cd sudoBruteForce
chmod +x sudoBruteForce.sh
./sudoBruteForce.sh <usuario>$(whoami) <diccionario.txt>
```
