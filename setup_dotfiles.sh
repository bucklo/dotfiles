#!/bin/bash

# Set the dotfiles directory
DOTFILES_DIR="$HOME/dotfiles"

stow_installed() {
  if command -v stow >/dev/null 2>&1; then
    return 0
  else
    return 1
  fi
}

install_stow() {
  OS=$(uname -s)

  case $OS in
    Linux)
      if [ -f /etc/os-release ]; then
        . /etc/os-release
	case $ID in
	  ubuntu|debian|pop)
            echo "Detected Ubuntu/Debian"
	    sudo apt-get update && sudo apt-get install -y stow
	    ;;
	  fedora|centos|rhel)
	    echo "Detected Fedora/RHEL/CentOS"
	    sudo dnf install -y stow
	    ;;
	  *)
	    echo "Unsupported Linux distribution"
	    exit 1
	    ;;
	esac
      else
	echo "Unable to detect Linux distribution"
	exit 1
      fi
      ;;
    Darwin)
      echo "Detected macOS"
      brew install stow
      ;;
    *)
      echo "Unsupported operating system"
      exit 1
      ;;
  esac
}

if stow_installed; then
  echo "GNU Stow is already installed"
else
  echo "GNU Stow is not installed"
  install_stow
fi

# Stow configurations
echo "Creating symlinks for configurations using Stow..."
cd $DOTFILES_DIR

for folder in $(find $DOTFILES_DIR -maxdepth 1 -type d  -exec basename {} \; | grep -v .git | grep -v dotfiles); do
  echo "Setting up $folder"
  stow $folder
done

echo "Dotfiles installation complete!"

