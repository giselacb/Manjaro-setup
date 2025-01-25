# Manjaro-setup

Script automatizado para configurar un entorno de desarrollo en Manjaro Linux. Incluye configuraciones optimizadas, herramientas esenciales y personalizaciones para mejorar la productividad.

## 🚀 Características

- **Shell Personalizada**: ZSH con Spaceship prompt
- **Herramientas DevOps**: Docker, Kubernetes, Helm
- **Editores**: VSCode, Nano optimizado
- **Herramientas Modernas**: exa, bat, btop, fzf
- **Configuración Git y GitHub**: Integración completa
- **Alias Útiles**: Para Docker, Kubernetes, Git y más

## 📋 Requisitos Previos

- Manjaro Linux instalado
- Conexión a Internet
- Permisos de sudo

## 🛠️ Instalación

1. Clonar el repositorio:
```bash
git clone https://github.com/TU_USUARIO/manjaro-sre-setup.git
cd manjaro-sre-setup
```

2. Dar permisos de ejecución:
```bash
chmod +x setup-manjaro.sh
```

3. Ejecutar el script:
```bash
./setup-manjaro.sh
```

## 📦 Que Incluye

### Herramientas Básicas
- ZSH con Oh My Zsh
- Spaceship Prompt
- Docker y Docker Compose
- Kubernetes (kubectl) y k9s
- Helm
- GitHub CLI

### Aplicaciones
- Google Chrome
- Visual Studio Code
- Slack

### Configuraciones
- Prompt personalizado de una línea
- Nano con resaltado de sintaxis
- Aliases útiles para SRE/DevOps
- Integración con Docker y Kubernetes

### Temas y Personalización
- Tema Spaceship optimizado
- Fuentes Nerd Font
- Colores pastel para mejor visualización

## 🔧 Personalización

### Prompt
El prompt está configurado para mostrar:
- Usuario y host
- Directorio actual
- Estado de git
- Contexto de Kubernetes
- Estado del último comando

### Aliases Disponibles
Ejecuta `help` o `halias` para ver todos los aliases disponibles:
- Docker
- Kubernetes
- Git
- Helm
- Sistema

## 📝 Archivos de Configuración

- `~/.zshrc`: Configuración de ZSH
- `~/.nanorc`: Configuración de Nano
- `setup-manjaro.sh`: Script principal de instalación

## 🤝 Contribuir

1. Fork del repositorio
2. Crea tu rama de características
3. Commit tus cambios
4. Push a la rama
5. Abre un Pull Request

## 📜 Licencia

Este proyecto está bajo la licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 🙏 Herramientas

- [Oh My Zsh](https://ohmyz.sh/)
- [Spaceship Prompt](https://spaceship-prompt.sh/)
- [La comunidad de Manjaro](https://manjaro.org/)

## 🔍 Ayuda

Para ver todos los aliases disponibles:
```bash
help
```

## 🔄 Actualización

Para actualizar a la última versión:
```bash
git pull
./setup-manjaro.sh
```

## ⚠️ Notas Importantes

- Realiza un backup antes de ejecutar el script
- Algunos cambios requieren reiniciar la sesión
