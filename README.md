# Lazy Terminal

A bash script that leverages Claude's API to generate and execute terminal commands based on natural language descriptions. Simply describe what you want to do, and the script will generate the appropriate command for your system.

## Features

- Generates terminal commands using Claude's API
- Supports context from your current OS and command history
- Includes file content in prompts for context-aware command generation
- Confirms command execution for safety
- Verbose mode for debugging
- Command history integration

## Prerequisites

- Anthropic API key
- `jq` command-line JSON processor
- Bash shell environment

## Installation

### Quick Install
```bash
git clone git@github.com:samuelpordeus/lazy_terminal.git
cd llm
chmod +x install.sh
./install.sh
```

### Manual Installation
If you prefer to install manually:

1. Clone this repository
2. Copy the script to your bin directory:
```bash
sudo cp llm /usr/local/bin/
sudo chmod 755 /usr/local/bin/llm
```
3. Set up your Anthropic API key:
```bash
export ANTHROPIC_API_KEY='your-api-key'
```
4. Make sure `jq` is installed:
```bash
# On macOS using Homebrew
brew install jq

# On Ubuntu/Debian
sudo apt-get install jq

# On CentOS/RHEL
sudo yum install jq
```

### Verification
After installation, verify everything works:
```bash
llm --help
```

## Usage

```bash
llm [-v|--verbose] [-f|--file <filepath>] [--os <ostype>] [-h <number>] <your request>
```

### Options

- `-v, --verbose`: Show the prompt being sent to Claude
- `-f, --file`: Specify a file to include in the context
- `--os`: Specify the OS type (default: OSX)
- `-h, --history`: Number of recent commands to include (default: 0)
- `--help`: Show the help message

### Examples

```bash
# Generate a command to find all PNG files
llm find all PNG files in the current directory

# Generate a command with system context and verbose output
llm -v --os Ubuntu find all processes using more than 1GB of memory

# Generate a command using a file as context
llm -f config.json update the JSON file to change the port to 3000

# Generate a command with recent command history context
llm -h 5 undo my last git commit
```

## Safety Features

- Commands are displayed before execution
- User confirmation is required before executing any command
- Command history filtering to prevent recursive calls

## Environment Variables

- `ANTHROPIC_API_KEY`: Your Anthropic API key (required)
- `HISTFILE`: Shell history file location (optional, defaults to standard locations)
