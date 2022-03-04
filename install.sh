LOG="${HOME}/Library/Logs/dotfiles.log"
GITHUB_USER="weed082"
GITHUB_REPO=".dotfile"
USER_GIT_AUTHOR_NAME="weed082"
USER_GIT_AUTHOR_EMAIL="nbh6579@naver.com"
DIR="/usr/local/opt/${GITHUB_REPO}"
 
_process() {
    echo "$(date) PROCESSING:  $@" >> $LOG
    printf "$(tput setaf 6) %s...$(tput sgr0)\n" "$@"
}

_success() {
  local message=$1
  printf "%s✓ Success:%s\n" "$(tput setaf 2)" "$(tput sgr0) $message"
}

download_dotfiles() {
    _process "→ Creating directory at ${DIR}"
    mkdir -p "${DIR}"

    _process "→ Downloading repository to /tmp directory"
    curl -#fLo /tmp/${GITHUB_REPO}.tar.gz "https://github.com/${GITHUB_USER}/${GITHUB_REPO}/tarball/main"

    _process "→ Extracting files to ${DIR}"
    tar -zxf /tmp/${GITHUB_REPO}.tar.gz --strip-components 1 -C "${DIR}"

    _process "→ Removing tarball from /tmp directory"
    rm -rf /tmp/${GITHUB_REPO}.tar.gz

    [[ $? ]] && _success "${DIR} created, repository downloaded and extracted"

    # Change to the dotfiles directory
    cd "${DIR}"
}

# TODO: currently using stow lib need to change
link_dotfiles() {

}

install_homebrew() {
  _process "→ Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

  _process "→ Running brew doctor"
  brew doctor
  [[ $? ]] \
  && _success "Installed Homebrew"
}

setup_git_authorship() {
  GIT_AUTHOR_NAME=eval "git config user.name"
  GIT_AUTHOR_EMAIL=eval "git config user.email"

  if [[ ! -z "$GIT_AUTHOR_NAME" ]]; then
    _process "→ Setting up Git author"

    read USER_GIT_AUTHOR_NAME
    if [[ ! -z "$USER_GIT_AUTHOR_NAME" ]]; then
      GIT_AUTHOR_NAME="${USER_GIT_AUTHOR_NAME}"
      $(git config user.name "$GIT_AUTHOR_NAME")
    else
      _warning "No Git user name has been set.  Please update manually"
    fi

    read USER_GIT_AUTHOR_EMAIL
    if [[ ! -z "$USER_GIT_AUTHOR_EMAIL" ]]; then
      GIT_AUTHOR_EMAIL="${USER_GIT_AUTHOR_EMAIL}"
      $(git config user.email "$GIT_AUTHOR_EMAIL")
    else
      _warning "No Git user email has been set.  Please update manually"
    fi
  else
    _process "→ Git author already set, moving on..."
  fi
}

install() {
  download_dotfiles
  link_dotfiles
  install_homebrew
  install_neovim
  setup_git_authorship
}

install
