# Create a new virtual environment
venv() {
    local force="$1"

    if [[ -d "venv" ]] && [[ "$force" != "force" ]]; then
        source venv/bin/activate
        echo "Activated venv"
    else
        python3 -m venv venv
        source venv/bin/activate
        echo "Created and activated venv"

        pip install -U pip

        if [ -f "pyproject.toml" ]; then
            pip install -e .
        elif [ -f "requirements.txt" ]; then
            pip install -r requirements.txt
        else
            echo "No pyproject.toml or requirements.txt found"
        fi
    fi
}

# Remove and create a new virtual environment
revenv() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        deactivate
        echo "Deactivated current venv"
    fi

    if [ -d "venv" ]; then
        rm -rf venv
        echo "Removed existing venv"
    fi

    venv force
}

fastfetch
