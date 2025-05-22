#!/bin/bash

# Ruta de trabajo dentro del contenedor
cd /workspace

# Clonar los proyectos si no existen
if [ ! -d "MinimaxApi" ]; then
    echo "Clonando MinimaxApi..."
    git clone https://github.com/BayronJDv/MinimaxApi.git
fi

if [ ! -d "yoshis_zones" ]; then
    echo "Clonando yoshis_zones..."
    git clone https://github.com/SARTDv/yoshis_zones.git
fi

# Backend: instalar dependencias y ejecutar
cd MinimaxApi
echo "Instalando dependencias de Python..."
pip install --no-cache-dir -r requirements.txt

echo "Ejecutando API..."
python run_server.py &

# Frontend: instalar dependencias y ejecutar
cd ../yoshis_zones
echo "Instalando dependencias de Node.js..."
npm install

echo "Ejecutando cliente con Vite..."
npm run dev -- --host 0.0.0.0 --port 5173 &

# Esperar a que ambos procesos terminen
wait

