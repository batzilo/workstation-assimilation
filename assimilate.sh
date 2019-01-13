#!/bin/bash
#
# This idempotent script assimilates a workstation:
# * updates apt repositories
# * installs the necessary software
# * installs dotfiles
# * clones itself
#

# fail early and loudly
set -e

while :
do
	case "$1" in
		"-v" | "--verbose")
			# be verbose
			VERBOSE=1
			;;
		"-vv" | "--very-verbose")
			# be very verbose
			VERBOSE=1
			set -x
			;;
		*)
			;;
	esac
	shift || break
done

# Set the user default value to batzilo if not set by env var
: "${TARGET_USER:=batzilo}"

RELEASE=stretch

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;35m'
NC='\033[0m' # No Color

log_debug() {
	[ -z "${VERBOSE}" ] || echo -e "${BLUE}$1${NC}"
}

log_info() {
	echo -e "${GREEN}$1${NC}"
}

log_error() {
	echo -e "${RED}$1${NC}"
}

success() {
	log_info "Command '$1' produced desired output '$2'"
}

fail() {
	log_error "Command '$1' did not produce desired output '$2'"
	exit 1
}

ensure_res() {
	[ $(eval "$1") == "$2" ] && success "$1" "$2" || fail "$1" "$2"

}

beginswith() {
	case "$2" in
		"$1"*) true;;
		*) false;;
	esac;
}

ensure_apt_repo() {
	APT_SOURCES_LIST_FILE=/etc/apt/sources.list
	unset REPO
	while :
	do
		if [ "$1" == "" ];
		then
			break
		fi
		REPO_TERM=$1
		log_debug "Using repo term '$REPO_TERM'"
		if [ "$REPO_TERM" == "--" ];
		then
			log_debug "Found term $REPO_TERM, breaking..."
			shift
			break
		fi
		if [ -z "${REPO}" ];
		then
			REPO=$(echo "${REPO_TERM}")
		else
			REPO=$(echo "${REPO} ${REPO_TERM}")
		fi
		log_debug "Repo now is: $REPO"
		shift
	done
	log_debug "Using repository '$REPO'"
	unset APT_SOURCES_LIST_FILE_CONTENTS
	APT_SOURCES_LIST_FILE_CONTENTS=$(cat "$APT_SOURCES_LIST_FILE")
	while :
	do
		if [ "$1" == "" ];
		then
			break
		fi
		GREP_TERM=$1
		log_debug "Using grep term '$GREP_TERM'"
		if beginswith "!" $GREP_TERM;
		then
			GREP_TERM=$(echo "$GREP_TERM" | cut -c2-)
			log_debug "Grepping for not $GREP_TERM"
			# Do not let grep return error code 1 if no match
			APT_SOURCES_LIST_FILE_CONTENTS=$(echo "$APT_SOURCES_LIST_FILE_CONTENTS" | grep -v "$GREP_TERM" || test $? = 1)
		else
			log_debug "Grepping for $GREP_TERM"
			# Do not let grep return error code 1 if no match
			APT_SOURCES_LIST_FILE_CONTENTS=$(echo "$APT_SOURCES_LIST_FILE_CONTENTS" | grep "$GREP_TERM" || test $? = 1)
		fi
		shift
	done
	log_debug "After grepping, contents are:"
	log_debug "$APT_SOURCES_LIST_FILE_CONTENTS"
	if [ -z "$APT_SOURCES_LIST_FILE_CONTENTS" ]
	then
		log_info "Adding repo $REPO to $APT_SOURCES_LIST_FILE"
		echo -e "\n$REPO" | cat - >> $APT_SOURCES_LIST_FILE
	else
		log_info "Repo $REPO is already in $APT_SOURCES_LIST_FILE"
	fi
}

instpkg() {
	apt-get install -y $@
}

if [ ! -d /home/$TARGET_USER ]
then
	log_error "There is no user $TARGET_USER"
	exit 1
fi

# add the "non-free" component to /etc/apt/sources.list
ensure_apt_repo "deb http://httpredir.debian.org/debian/ $RELEASE main contrib non-free" -- "/debian[/ ]" $RELEASE !updates main contrib non-free

# add debian.net/debian component to /etc/apt/sources.list
ensure_apt_repo "deb http://http.debian.net/debian $RELEASE main contrib" -- "debian\.net/debian[/ ]" $RELEASE

# add repository.spotify.com component to /etc/apt/sources.list
ensure_apt_repo "deb http://repository.spotify.com stable non-free" -- repository.spotify.com stable non-free
instpkg dirmngr
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys A87FF9DF48BF1C90
# curl 'https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xA87FF9DF48BF1C90' | apt-key add -

log_debug "Updating apt..."
apt-get update
log_info "APT updated"

log_debug "Upgrading system..."
apt-get dist-upgrade -y
log_info "System upgraded"

# basic stuff
instpkg vim git gcc make python wget curl xterm

# install xmonad and mate
instpkg xorg xmonad xmobar suckless-tools mate-desktop-environment
log_info "X.org, xmonad and MATE are installed"
XWRAPPER_FILE=/etc/X11/Xwrapper.config
if [ -f $XWRAPPER_FILE ];
then
	grep "^allowed_users" $XWRAPPER_FILE && sed -i '/^allowed_users/d' $XWRAPPER_FILE
	grep "^needs_root_rights" $XWRAPPER_FILE && sed -i '/^needs_root_rights/d' $XWRAPPER_FILE
	echo "allowed_users=anybody" >> $XWRAPPER_FILE
	echo "needs_root_rights=yes" >> $XWRAPPER_FILE
fi

# web and mail
#
# Vimperator is discontinued after Firefox 57 (or Firefox ESR 52), so switch to Tridactyl
# FIXME: Install Tridactyl from the cli
# FIXME: Add an ad-blocker, for example uBlock Origin
instpkg firefox-esr thunderbird chromium browser-plugin-freshplayer-pepperflash
log_info "firefox, thunderbird and chromium are installed"

log_info "Installing/Updating pepper flash plugin... (This may take a few seconds)"
if [ -z `which update-pepperflashplugin-nonfree` ]; then
	# https://unix.stackexchange.com/questions/391467/how-to-install-flash-on-debian-stretch
	curl -o /tmp/pepper.deb "http://ftp.ee.debian.org/debian/pool/contrib/p/pepperflashplugin-nonfree/pepperflashplugin-nonfree_1.8.3+nmu1_amd64.deb"
	dpkg -i /tmp/pepper.deb
fi
update-pepperflashplugin-nonfree --install
update-pepperflashplugin-nonfree --status && log_info "Pepper flash plugin is installed" || log_error "Failed to install/upgrade flash player"

# install utilities
instpkg screen zip unzip arandr pavucontrol htop \
	nmap net-tools tcpdump tcpflow ngrep wireshark-gtk netcat-openbsd \
	bridge-utils ethtool openvpn network-manager proxychains dnsutils \
	virtualenv virtualenvwrapper python-dev \
	libxml2-dev libxslt1-dev zlib1g-dev openssl gnupg \
	alsa-utils zathura rdesktop recordmydesktop vlc hwinfo feh \
	transmission-gtk flake8 scrot gimp

# For wireshark, you may need to run `dpkg-reconfigure wireshark-common`
# and select 'Yes' to allow non-root users capture packets.
adduser $TARGET_USER wireshark

# ? alsa-base
log_info "various utilities are installed"

# install java and stuff
instpkg default-jre ant maven
log_info "java is installed"

KB_FILE="/etc/default/keyboard"
KB_CONF=$(cat <<EOF
# Debian keyboard configuration, see keyboard(5)

XKBMODEL="pc105"
XKBLAYOUT="us,gr"
XKBVARIANT=""
XKBOPTIONS="grp:alt_shift_toggle"
BACKSPACE="guess"
EOF
)
KB_HASH=$(echo "$KB_CONF" | md5sum | cut -d ' ' -f 1)

if [ $(cat "$KB_FILE" | md5sum | cut -d ' ' -f 1) != "$KB_HASH" ]; then
	cp $KB_FILE ${KB_FILE}_$(date -Iseconds).bak
	echo "$KB_CONF" > $KB_FILE
fi
log_info "keyboard is configured for both US and GR"

instpkg spotify-client
log_info "spotify is installed"

# install dnsmasq ?

# # Install Telegram
#
# $ cd /tmp
# $ wget -O telegram_setup.tar.xz https://telegram.org/dl/desktop/linux
# $ tar xvf telegram_setup.tar.xz
# $ sudo mv Telegram /opt
# $ ln -sf /opt/Telegram/Telegram ~/bin/telegram

# # Install dropbox
#
# $ cd ~ && wget -O - "https://www.dropbox.com/download?plat=lnx.x86_64" | tar xzf
# -
# $ sudo apt-get install libxslt1.1
# $ .dropbox-dist/dropboxd
# # Check browser window, log in to Dropbox
# # Hmm, killed and $? is 137, is this OK ?
# $ mkdir -p ~/bin
# $ wget -O ~/bin/dropbox https://www.dropbox.com/download?dl=packages/dropbox.py
# $ chmod +x ~/bin/dropbox

# Install viber

# Install QEMU

# Install virtualbox

# Install Docker
#
# https://docs.docker.com/install/linux/docker-ce/debian/#set-up-the-repository
#
# curl -L "https://github.com/docker/compose/releases/download/1.23.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
# chmod +x /usr/local/bin/docker-compose


# Configure sudo and add user to sudoers
instpkg sudo
adduser $TARGET_USER sudo

VGA_PCI=$(lspci -nn | grep '\[03' | cut -f 1 -d ' ')
VGA_DEV=$(lspci -v -s "$VGA_PCI")
log_info "The VGA controller is: $VGA_DEV"

# XXX: alan specific section ; debian stretch specific section
if [ "$(hostname -s)" == "alan" -a 'echo "$VGA_DEV" | grep "RS880" | grep "Radeon HD 4290"' ];
then
	apt-get purge nvidia.
	instpkg firmware-linux-nonfree libgl1-mesa-dri xserver-xorg-video-ati
	log_info "VGA drivers for alan are OK"
fi

# create the user's src directory
mkdir -p /home/$TARGET_USER/src
chown -R $TARGET_USER:$TARGET_USER /home/$TARGET_USER/src

# obtain dotfiles
DOTFILES_DIRECTORY=/home/$TARGET_USER/src/dotfiles
if [ ! -d $DOTFILES_DIRECTORY ];
then
	git clone https://github.com/batzilo/dotfiles.git $DOTFILES_DIRECTORY
	chown -R $TARGET_USER:$TARGET_USER $DOTFILES_DIRECTORY
	pushd $DOTFILES_DIRECTORY
	git remote remove origin
	git remote add origin git@github.com:batzilo/dotfiles.git
	git submodule init
	git submodule update
	popd
fi
VERBOSE_INSTALL_DOTFILES=
[ ! -z "${VERBOSE}" ] && VERBOSE_INSTALL_DOTFILES=-v
$DOTFILES_DIRECTORY/install_dotfiles.sh $VERBOSE_INSTALL_DOTFILES
log_info "Dotfiles successfully installed"

# obtain assimilation script
ASSIMILATION_DIRECTORY=/home/$TARGET_USER/src/workstation-assimilation
if [ ! -d $ASSIMILATION_DIRECTORY ];
then
	git clone https://github.com/batzilo/workstation-assimilation.git $ASSIMILATION_DIRECTORY
	chown -R $TARGET_USER:$TARGET_USER $ASSIMILATION_DIRECTORY
	pushd $ASSIMILATION_DIRECTORY
	git remote remove origin
	git remote add origin git@github.com:batzilo/workstation-assimilation.git
	popd
fi
log_info "Assimilation script successfully cloned"

# pretty colors in xterm
instpkg ncurses-term
if [ "$TERM" != "linux" ];
then
	ensure_res "grep 'force_color_prompt=' /home/$TARGET_USER/.bashrc" "force_color_prompt=yes"
	ensure_res "tput colors" 256
	ensure_res "echo $TERM" "xterm-256color"
fi

log_info "Enjoy!"
