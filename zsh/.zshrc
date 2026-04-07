# Use same aliases as bash
[[ -f ~/.bash_aliases ]] && source ~/.bash_aliases
# Reload should refresh zsh config, not bash
alias reload="source ~/.zshrc"

venv() {
    if [ ! -d "venv" ]; then
        python -m venv venv
    fi
    source venv/bin/activate
    if [ -f "requirements.txt" ]; then
        pip install -r requirements.txt
    fi
}

revenv() {
    if [[ -n "$VIRTUAL_ENV" ]]; then
        deactivate
    fi
    if [ -d "venv" ]; then
        rm -rf venv
    fi
    venv force
}

# Nvm setup
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  
