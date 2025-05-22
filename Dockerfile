FROM python:3.11-slim

# 1. Instalar dependencias básicas + Node.js (versión inicial para obtener npm)
RUN apt-get update && apt-get install -y \
    curl \
    git \
    # Instalar Node.js 20.x (para obtener npm)
    && curl -fsSL https://deb.nodesource.com/setup_20.x | bash - \
    && apt-get install -y nodejs \
    # Instalar 'n' para cambiar a Node.js 24.0.1
    && npm install -g n \
    && n 24.0.1 \
    # Limpiar instalación temporal de Node.js 20
    && apt-get purge -y nodejs \
    && apt-get autoremove -y \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 2. Verificar versiones (opcional, útil para debug)
RUN node -v && npm -v

# 3. Configurar el workspace
WORKDIR /workspace
COPY start_services.sh .
RUN chmod +x start_services.sh

EXPOSE 5000 5173
