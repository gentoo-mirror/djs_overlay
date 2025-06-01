# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

inherit cmake python-single-r1 xdg djs-functions

DESCRIPTION="A fast and flexible keyboard launcher"
HOMEPAGE="https://albertlauncher.github.io/"

# Plugin sha hashes to not download the latest version
APPLICATIONS_PLUGIN="000c191c63136942f4fab477e9cf563629051978"  #Latest
BLUETOOTH_PLUGIN="60a13a3c0ffb7526557a3d426354456d84614e66"		#v0.27
CAFFEINE_PLUGIN="33c9297821998b08fa644fa9ef5a8462617152d2"		#Latest
CALC_QUALC_PLUGIN="7496da51216a383305e91c2e6bb0110b7447a2d6"	#Latest
CHROMIUM_PLUGIN="ffbd5cfbf0b8db2d4a144252007ac12aa0b9da69"		#Latest, cmake
CLIPBOARD_PLUGIN="463cae8f7d8f2c3013d200a828a234337e74de23"		#Latest
CONTACTS_PLUGIN="75c02209e5f8e5e9c53a8e31dcc967ae94ba334a"		#Latest
DATETIME_PLUGIN="7a04b6fdc28b03e2cc758650f936843d7b6d5618"		#Latest
DEBUG_PLUGIN="23b219118d101770bbb36536d0c14feac11b2e36"         #Latest
DICTIONARY_PLUGIN="51771d681a7c08ffe97e1e9e73eada17c240e4ce"    #Latest
DOCS_PLUGIN="34b1a3d5cfc08e5b3bc2348221a5f597413ccadf"			#Latest
FILES_PLUGIN="d48f72dc90c4bc23fdd267a590baddaf21b65617"         #Latest
HASH_PLUGIN="42ed91e51813eb15a0f86a920e6ef07e627de0bb"          #Latest
MEDIAREMOTE_PLUGIN="1fdd95a8dd2237457e5c3aad5f2004d8ad285c6e"   #Latest
MENUBAR_PLUGIN="f843076aca79c6bae21cf115901d36b472561bf2"		#Latest
PATH_PLUGIN="0673d44205ed4429c1b78b0bb11ed7328cbaa514"			#Latest
PYTHON_PLUGIN="7a9ff3d6d311b9b7151a05f2423eca9e3cdc541f"		#Latest
SNIPPETS_PLUGIN="9bb1afbefea31adb36e8f6f1209e54b6f676dfd5"		#Latest
SSH_PLUGIN="90284fc28727cf2333572a28d66868c06edba777"			#Latest
SYSTEM_PLUGIN="b58be088087f0a1e8ee073eacd48b7e0b0312f90"		#Latest
TIMER_PLUGIN="4c5e81979d983f7f6652792655e13bc4df5a5fc9"			#Latest
TIMEZONES_PLUGIN="221ae6d077bd0a872aed97e5c3dcab05bc807d56"     #Latest
URLHANDLER_PLUGIN="b7642f8f6e2cb8f345ae4b63dd870eec28c15038"	#Latest
VPN_PLUGIN="452276962459caa5c21fb38240870778ab3abc4b"			#Latest
WEBSEARCH_PLUGIN="24f05dc42aad73249c1fd00b7af8f5972f4866d9"		#Latest
WIDGETS_PLUGIN="5c86c07c672bd129e6c1898ae7595a2b85cea191"       #Latest
WIDGETS_QSS_PLUGIN="880da52513c8c863fd763be47a3cee05fa2d5641"	#Latest

LANGUAGES_COMMIT="3006e87427d34b5b80e5ae4425b3aeab4d686490"
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
	"mediaremote"
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
	https://github.com/albertlauncher/albert-plugin-mediaremote/archive/${MEDIAREMOTE_PLUGIN}.zip -> ${P}-plugin-mediaremote.zip
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
	https://github.com/albertlauncher/i18n/archive/${LANGUAGES_COMMIT}.zip -> ${P}-languages.zip
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

