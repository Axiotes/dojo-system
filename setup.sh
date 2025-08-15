#!/bin/bash
OS="$(uname -s)"
case "${OS}" in
    Linux*)     OS=Linux;;
    Darwin*)    OS=Mac;;
    *)          OS="UNKNOWN:${OS}"
esac

echo "Detected OS: ${OS}"

load_env_file() {
    export $(egrep -v '^#' .env.development | xargs)
}

copy_api_env_file() {
    echo "Copying API .env file..."
    cp ${PWD}/api-dojo-system/.env.example ${PWD}/api-dojo-system/.env.development
    echo "API .env file copied successfully."
}

install_docker() {
    echo "Installing Docker..."
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    echo "Docker installed successfully."
}

install_docker_compose() {
    echo "Installing Docker Compose..."
    if [ "$OS" = "Linux" ]; then
        if grep -q "Ubuntu" /etc/os-release; then
            sudo apt-get update && sudo apt-get install -y docker-compose
        elif grep -q "Arch" /etc/os-release; then
            sudo pacman -Syu docker-compose --noconfirm
        fi
    elif [ "$OS" = "Mac" ]; then
        brew install docker-compose
    fi
    echo "Docker Compose installed successfully."
}

clone_api_project() {
    if [ ! -d "api-dojo-system" ]; then
        echo "Cloning the API project..."
        git clone git@github.com:Axiotes/api-dojo-system.git --branch main
        echo "API project cloned successfully."
    else
        echo "API project directory already exists. Skipping clone..."
    fi
}

clone_app_project() {
    if [ ! -d "app-isongcard" ]; then
        echo "Cloning the App project..."
        git clone git@github.com:Axiotes/app-dojo-system.git --branch main
        echo "App project cloned successfully."
    else
        echo "App project directory already exists. Skipping clone..."
    fi
}

main() {
    if [ "$OS" = "UNKNOWN" ]; then
        echo "Unsupported OS. Exiting..."
        exit 1
    fi

    if ! command -v docker &> /dev/null; then
        install_docker
    else
        echo "Docker is already installed."
    fi

    if ! command -v docker-compose &> /dev/null; then
        install_docker_compose
    else
        echo "Docker Compose is already installed."
    fi

    docker network create isongcard-network
    clone_api_project
    clone_app_project
    load_env_file
    sleep 2
    copy_api_env_file
    echo "Starting Docker services..."
    docker-compose up --build --force-recreate
    echo "Docker services are up and running."
}

main
