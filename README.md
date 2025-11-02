# 🖨️ Detectar y escanear automáticamente con `scanimage` en Linux

**Publicado por:** *kike priet*  
**Fecha:** 2 de noviembre de 2025  

---

En esta entrada te muestro cómo crear un **script en Bash** que detecta automáticamente cualquier escáner conectado a tu sistema Linux y realiza un escaneo en formato **JPEG**, sin tener que escribir manualmente el identificador del dispositivo.

Usaremos el comando `scanimage`, incluido en el paquete **SANE** (*Scanner Access Now Easy*).  
Este comando permite listar y controlar escáneres conectados mediante **USB** o **red**.

---

## 📜 El script completo

Guarda este código como `auto_scan_simple.sh`, luego dale permisos y ejecútalo:

```bash
chmod +x auto_scan_simple.sh
./auto_scan_simple.sh
