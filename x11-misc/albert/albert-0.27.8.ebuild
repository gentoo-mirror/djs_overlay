# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

inherit cmake python-single-r1 xdg djs-functions

DESCRIPTION="A fast and flexible keyboard launcher"
HOMEPAGE="https://albertlauncher.github.io/"

# Plugin sha hashes to not download the latest version
APPLICATIONS_PLUGIN="c231e2c57a342b027a8fd6a3f1fb4743e9fdbd3a"  #Latest
BLUETOOTH_PLUGIN="60a13a3c0ffb7526557a3d426354456d84614e66"		#v0.27
CAFFEINE_PLUGIN="5b79949338d263b544c2bc8405c5485c9447043f"		#v3.0
CALC_QUALC_PLUGIN="b213738f6b8099e4ae08a5ed8764482131bc598a"	#v0.27
CHROMIUM_PLUGIN="2e5615514a65a892ca119c078aaf0b17ff8e2db8"		#Latest, cmake
CLIPBOARD_PLUGIN="74fffd92adaefd8d525f78ed0e72ad71f3ebe9d5"		#v0.27
CONTACTS_PLUGIN="ea66990968e55cee7d40587587e88b235c93cd0a"		#v0.27
DATETIME_PLUGIN="ccc5c768c33c2086002ea06aaaa9139334e0f266"		#v0.27
DEBUG_PLUGIN="739b17eef2e2a1dddbc5d56c8244c6a92e959f9f"         #v0.27
DICTIONARY_PLUGIN="41c35c9a788cb5a19e88355d8747bd6b727f0d58"    #v0.27
DOCS_PLUGIN="2282d3fa6af66d396ef676fc52b891b3608e6235"			#v0.27
FILES_PLUGIN="6e76ef16c0f3736b8073a70922e4b73738cdd84e"         #v0.27
HASH_PLUGIN="068a2173c601ee9c280653a5e034f364acb4b5a8"          #v0.27
MENUBAR_PLUGIN="f9aa4a230dc0ef184d2165a9d137331a0ab09d6f"		#v0.27
MPRIS_PLUGIN="b8e9791745307963ceb52590aa02949739be0e58"			#v0.27
PATH_PLUGIN="1f18c598d9af28c52156eeca2c43557dd653bcf5"			#v0.27
PYTHON_PLUGIN="417aa4059cf2e305ffb3b4cc9fa216778d7a1371"		#Udate plugins, pybind 2.3.16
SNIPPETS_PLUGIN="8fb9c7b171476a97c62c2e621c19e3d2b92d43f7"		#v0.27
SSH_PLUGIN="9ebcefb6ffb21762bed7477dfc6eee1801da5dc6"			#v0.27
SYSTEM_PLUGIN="8611d167f394ad55354f84878b999efdba3d44a8"		#v0.27
TIMER_PLUGIN="2b4ead34ea0e93fe36a1e4852a4578449c4fa517"			#v3.2
TIMEZONES_PLUGIN="41ab3780184a02e4935c4de4aa1ff1435b83ec00"     #v0.27
URLHANDLER_PLUGIN="a5b0835f7fd03781a72a1a4b73e50a926a8d6d07"	#v0.27
VPN_PLUGIN="09c112d8fa2f21ec9d415a911f005ad90eac7849"			#v5.0
WEBSEARCH_PLUGIN="cac15d126c550bd929a935cbc72ff4c6bbcde35b"		#v0.27
WIDGETS_PLUGIN="17e741f93c92793a645374cddc433277b4bfe567"       #Latest
WIDGETS_QSS_PLUGIN="35df324e14258e2f098d9b5c7a04ef001c19854d"	#0.27

PYBIND_VERSION="2.13.6"											#2.13.6

QTHOTKEY="bb630252684d3556b79ac7a521616692f348fcf7"             #Latest (fixed qt6 crash)
QNOTIFICATIONS="5370789111dadf97119ef7a42d64ef9aff3d79d7"       #Latest (initial commit)

# Plugins list
PLUGINS=(
	"applications"
	"bluetooth"
	"caffeine"
	"calculator-qalculate"
	"chromium"
	"clipboard"
	"contacts"
	"datetime"
	"debug"
	"dictionary"
	"docs"
	"files"
	"hash"
	"menubar"
	"mpris"
	"path"
	"python"
	"snippets"
	"ssh"
	"system"
	"timer"
	"timezones"
	"urlhandler"
	"vpn"
	"websearch"
	"widgetsboxmodel"
	"widgetsboxmodel-qss"
)

LIBS=(
	"QHotkey"
	"QNotification"
	)

SRC_URI="
	https://github.com/albertlauncher/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
	https://github.com/albertlauncher/albert-plugin-applications/archive/${APPLICATIONS_PLUGIN}.zip -> ${P}-plugin-applications.zip
	https://github.com/albertlauncher/albert-plugin-bluetooth/archive/${BLUETOOTH_PLUGIN}.zip -> ${P}-plugin-bluetooth.zip
	https://github.com/albertlauncher/albert-plugin-caffeine/archive/${CAFFEINE_PLUGIN}.zip -> ${P}-plugin-caffeine.zip
	https://github.com/albertlauncher/albert-plugin-calculator-qalculate/archive/${CALC_QUALC_PLUGIN}.zip -> ${P}-plugin-calculator-qalculate.zip
	https://github.com/albertlauncher/albert-plugin-chromium/archive/${CHROMIUM_PLUGIN}.zip -> ${P}-plugin-chromium.zip
	https://github.com/albertlauncher/albert-plugin-clipboard/archive/${CLIPBOARD_PLUGIN}.zip -> ${P}-plugin-clipboard.zip
	https://github.com/albertlauncher/albert-plugin-contacts/archive/${CONTACTS_PLUGIN}.zip -> ${P}-plugin-contacts.zip
	https://github.com/albertlauncher/albert-plugin-datetime/archive/${DATETIME_PLUGIN}.zip -> ${P}-plugin-datetime.zip
	https://github.com/albertlauncher/albert-plugin-debug/archive/${DEBUG_PLUGIN}.zip -> ${P}-plugin-debug.zip
	https://github.com/albertlauncher/albert-plugin-dictionary/archive/${DICTIONARY_PLUGIN}.zip -> ${P}-plugin-dictionary.zip
	https://github.com/albertlauncher/albert-plugin-docs/archive/${DOCS_PLUGIN}.zip -> ${P}-plugin-docs.zip
	https://github.com/albertlauncher/albert-plugin-files/archive/${FILES_PLUGIN}.zip -> ${P}-plugin-files.zip
	https://github.com/albertlauncher/albert-plugin-hash/archive/${HASH_PLUGIN}.zip -> ${P}-plugin-hash.zip
	https://github.com/albertlauncher/albert-plugin-menubar/archive/${MENUBAR_PLUGIN}.zip -> ${P}-plugin-menubar.zip
	https://github.com/albertlauncher/albert-plugin-mpris/archive/${MPRIS_PLUGIN}.zip -> ${P}-plugin-mpris.zip
	https://github.com/albertlauncher/albert-plugin-path/archive/${PATH_PLUGIN}.zip -> ${P}-plugin-path.zip
	https://github.com/albertlauncher/albert-plugin-python/archive/${PYTHON_PLUGIN}.zip -> ${P}-plugin-python.zip
	https://github.com/albertlauncher/albert-plugin-snippets/archive/${SNIPPETS_PLUGIN}.zip -> ${P}-plugin-snippets.zip
	https://github.com/albertlauncher/albert-plugin-ssh/archive/${SSH_PLUGIN}.zip -> ${P}-plugin-ssh.zip
	https://github.com/albertlauncher/albert-plugin-system/archive/${SYSTEM_PLUGIN}.zip -> ${P}-plugin-system.zip
	https://github.com/albertlauncher/albert-plugin-timer/archive/${TIMER_PLUGIN}.zip -> ${P}-plugin-timer.zip
	https://github.com/albertlauncher/albert-plugin-timezones/archive/${TIMEZONES_PLUGIN}.zip -> ${P}-plugin-timezones.zip
	https://github.com/albertlauncher/albert-plugin-urlhandler/archive/${URLHANDLER_PLUGIN}.zip -> ${P}-plugin-urlhandler.zip
	https://github.com/albertlauncher/albert-plugin-vpn/archive/${VPN_PLUGIN}.zip -> ${P}-plugin-vpn.zip
	https://github.com/albertlauncher/albert-plugin-websearch/archive/${WEBSEARCH_PLUGIN}.zip -> ${P}-plugin-websearch.zip
	https://github.com/albertlauncher/albert-plugin-widgetsboxmodel/archive/${WIDGETS_PLUGIN}.zip -> ${P}-plugin-widgetsboxmodel.zip
	https://github.com/albertlauncher/albert-plugin-widgetsboxmodel-qss/archive/${WIDGETS_QSS_PLUGIN}.zip -> ${P}-plugin-widgetsboxmodel-qss.zip
	https://github.com/albertlauncher/i18n/zipball/main -> ${P}-languages.zip
	https://github.com/pybind/pybind11/archive/refs/tags/v${PYBIND_VERSION}.zip -> ${P}-plugin-pybind11.zip
	https://github.com/Skycoder42/QHotkey/archive/${QTHOTKEY}.zip -> ${P}-lib-QHotkey.zip
	https://github.com/QtCommunity/QNotification/archive/${QNOTIFICATIONS}.zip -> ${P}-lib-QNotification.zip
"

LICENSE="all-rights-reserved"	# unclear licensing #766129
SLOT="0"
KEYWORDS="~amd64"
IUSE="+python +python-extensions"

REQUIRED_USE="
	python-extensions? ( python )
	python? ( ${PYTHON_REQUIRED_USE} )
"

RESTRICT="mirror bindist"

BDEPEND="
	dev-qt/qttools:6[linguist]
"
DEPEND="${RDEPEND}
	x11-base/xorg-proto"
RDEPEND="
	app-arch/libarchive:=
	dev-libs/libxml2:=
	dev-qt/qt5compat:6[qml]
	dev-qt/qtbase:6[concurrent,dbus,gui,network,sql,sqlite,widgets]
	dev-qt/qtdeclarative:6
	dev-qt/qtscxml:6[qml]
	dev-qt/qtsvg:6
	sci-libs/libqalculate:=
	python? (
		$(python_gen_cond_dep 'dev-python/urllib3[${PYTHON_USEDEP}]')
		${PYTHON_DEPS}
	)
	x11-misc/copyq
"

src_prepare() {
	# Default prepare
	cmake_src_prepare

	# Make plugins symlinks
	makeSymlinks "${DISTDIR}/${P}-plugin-" "${S}/plugins/" "${PLUGINS[@]}"

	# Pybind11
	makeSymlink "${DISTDIR}/${P}-plugin-pybind11" "${S}/plugins/python/pybind11"

	# i18n / languages
	makeSymlink "${DISTDIR}/${P}-languages" "${S}/i18n"

	# Make libs symlinks
	makeSymlinks "${DISTDIR}/${P}-lib-" "${S}/lib/" "${LIBS[@]}"
}

src_configure() {
	cmake_src_configure
}

