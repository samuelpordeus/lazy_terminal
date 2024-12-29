#!/bin/bash

# Exit on error
set -e

# Default install location
INSTALL_DIR="/usr/local/bin"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print error and exit
error() {
    echo -e "${RED}Error: $1${NC}" >&2
    exit 1
}

# Check for sudo privileges if needed
check_sudo() {
    if [ ! -w "$INSTALL_DIR" ]; then
        if [ ! -x "$(command -v sudo)" ]; then
            error "Installation requires sudo privileges"
        fi
        echo -e "${YELLOW}Note: Installation requires sudo privileges${NC}"
        return 1
    fi
    return 0
}

# Check dependencies
check_dependencies() {
    if ! command -v jq &> /dev/null; then
        echo -e "${YELLOW}Warning: jq is not installed${NC}"
        echo "Please install jq:"
        echo "  - For macOS: brew install jq"
        echo "  - For Ubuntu/Debian: sudo apt-get install jq"
        echo "  - For CentOS/RHEL: sudo yum install jq"
        error "jq is required for installation"
    fi
}

# Main installation
main() {
    echo "Installing llm command line tool..."

    # Check dependencies
    check_dependencies

    # Determine if we need sudo
    if check_sudo; then
        SUDO=""
    else
        SUDO="sudo"
    fi

    # Copy the script
    $SUDO cp llm "$INSTALL_DIR/llm"
    $SUDO chmod 755 "$INSTALL_DIR/llm"
    $SUDO chown root:wheel "$INSTALL_DIR/llm" 2>/dev/null || true  # Might fail on some Linux systems

    echo -e "${GREEN}Installation complete!${NC}"
    echo
    echo "Please ensure you have set your Anthropic API key:"
    echo "export ANTHROPIC_API_KEY='your-api-key'"
    echo
    echo "You can now use the 'llm' command."
}

main