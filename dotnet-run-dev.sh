#!/bin/bash

# Define variáveis com o caminho dos executáveis.
BACKEND_PATH="src/backend/BizHub.API"
FRONTEND_PATH="src/frontend/BizHub.UI"

# Função que verifica e encerra processos abertos.
stop_process_if_running() {
    local process_name=$1
    if pgrep -f "$process_name" > /dev/null; then
        echo "⏳ Parando $process_name..."
        pkill -SIGINT -f "$process_name"
        pkill -SIGTERM -f "$process_name"
        echo "🔴  $process_name parado."
        echo
    else
        echo "🟡  $process_name não está em execução."
        echo
    fi
}

# Função principal com o fluxo de execução.
main() {
    echo "⏳ Verificando processos em execução..."
    stop_process_if_running "dotnet run --project $BACKEND_PATH"
    stop_process_if_running "dotnet run --project $FRONTEND_PATH"

    echo "🟢  Iniciando backend..."
    dotnet run --project "$BACKEND_PATH" &

    echo "🟢  Iniciando frontend..."
    dotnet run --project "$FRONTEND_PATH" &
    echo

    wait
}

# Chama a função principal
main
