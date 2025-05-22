#!/bin/bash

# Preparar entorno local y contenedor con clones persistentes

# Clonar MinimaxApi si no está clonado correctamente
if [ ! -d "MinimaxApi/.git" ]; then
    echo "⚠️  Clonando MinimaxApi..."
    rm -rf MinimaxApi
    git clone https://github.com/BayronJDv/MinimaxApi.git
else
    echo "✅ MinimaxApi ya está clonado."
fi

# Clonar yoshis_zones si no está clonado correctamente
if [ ! -d "yoshis_zones/.git" ]; then
    echo "⚠️  Clonando yoshis_zones..."
    rm -rf yoshis_zones
    git clone https://github.com/SARTDv/yoshis_zones.git
else
    echo "✅ yoshis_zones ya está clonado."
fi

# Crear archivo de entorno si no existe
if [ ! -f ".env" ]; then
    echo "⚠️  Archivo .env no encontrado. Creando uno por defecto..."
    cat <<EOF > .env
# Configuración por defecto
DEBUG=True
EOF
fi

# Construir e iniciar los servicios con Docker Compose
if [ "$(docker compose ps -q)" ]; then
    STATE=$(docker compose ps --services --filter "status=paused")
    if [ "$STATE" ]; then
        echo "🔵 Reanudando servicios pausados..."
        docker compose unpause
    else
        echo "🚀 Reiniciando servicios existentes..."
        docker compose restart
    fi
else
    echo "🚀 Iniciando servicios por primera vez..."
    docker compose up --build -d
fi


