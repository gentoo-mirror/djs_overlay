# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

inherit cmake python-single-r1 xdg

DESCRIPTION="A fast and flexible keyboard launcher"
HOMEPAGE="https://albertlauncher.github.io/"

I18N_URL="https://github.com/albertlauncher/i18n.git"
PYTHON_PLUGINS_URL="https://github.com/albertlauncher/python.git"

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
	https://github.com/albertlauncher/albert-plugin-applications/zipball/main -> albert-plugin-applications.zip
	https://github.com/albertlauncher/albert-plugin-bluetooth/zipball/main -> albert-plugin-bluetooth.zip
	https://github.com/albertlauncher/albert-plugin-caffeine/zipball/main -> albert-plugin-caffeine.zip
	https://github.com/albertlauncher/albert-plugin-calculator-qalculate/zipball/main -> albert-plugin-calculator-qalculate.zip
	https://github.com/albertlauncher/albert-plugin-chromium/zipball/main -> albert-plugin-chromium.zip
	https://github.com/albertlauncher/albert-plugin-clipboard/zipball/main -> albert-plugin-clipboard.zip
	https://github.com/albertlauncher/albert-plugin-contacts/zipball/main -> albert-plugin-contacts.zip
	https://github.com/albertlauncher/albert-plugin-datetime/zipball/main -> albert-plugin-datetime.zip
	https://github.com/albertlauncher/albert-plugin-debug/zipball/main -> albert-plugin-debug.zip
	https://github.com/albertlauncher/albert-plugin-dictionary/zipball/main -> albert-plugin-dictionary.zip
	https://github.com/albertlauncher/albert-plugin-docs/zipball/main -> albert-plugin-docs.zip
	https://github.com/albertlauncher/albert-plugin-files/zipball/main -> albert-plugin-files.zip
	https://github.com/albertlauncher/albert-plugin-hash/zipball/main -> albert-plugin-hash.zip
	https://github.com/albertlauncher/albert-plugin-menubar/zipball/main -> albert-plugin-menubar.zip
	https://github.com/albertlauncher/albert-plugin-mpris/zipball/main -> albert-plugin-mpris.zip
	https://github.com/albertlauncher/albert-plugin-path/zipball/main -> albert-plugin-path.zip
	https://github.com/albertlauncher/albert-plugin-python/zipball/main -> albert-plugin-python.zip
	https://github.com/albertlauncher/albert-plugin-snippets/zipball/main -> albert-plugin-snippets.zip
	https://github.com/albertlauncher/albert-plugin-ssh/zipball/main -> albert-plugin-ssh.zip
	https://github.com/albertlauncher/albert-plugin-system/zipball/main -> albert-plugin-system.zip
	https://github.com/albertlauncher/albert-plugin-timer/zipball/main -> albert-plugin-timer.zip
	https://github.com/albertlauncher/albert-plugin-timezones/zipball/main -> albert-plugin-timezones.zip
	https://github.com/albertlauncher/albert-plugin-urlhandler/zipball/main -> albert-plugin-urlhandler.zip
	https://github.com/albertlauncher/albert-plugin-vpn/zipball/main -> albert-plugin-vpn.zip
	https://github.com/albertlauncher/albert-plugin-websearch/zipball/main -> albert-plugin-websearch.zip
	https://github.com/albertlauncher/albert-plugin-widgetsboxmodel/zipball/main -> albert-plugin-widgetsboxmodel.zip
	https://github.com/albertlauncher/albert-plugin-widgetsboxmodel-qss/zipball/main -> albert-plugin-widgetsboxmodel-qss.zip
	https://github.com/pybind/pybind11/zipball/master -> albert-plugin-pybind11.zip
	https://github.com/Skycoder42/QHotkey/zipball/master -> albert-lib-QHotkey.zip
	https://github.com/QtCommunity/QNotification/zipball/main -> albert-lib-QNotification.zip
"

LICENSE="all-rights-reserved"	# unclear licensing #766129
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug +python +python-extensions"

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

_make_symlink() {
	local sourceZip="$1"
	local destinationPath="$2"
	local parentSourceDir=$(unzip -l "${sourceZip}" | awk '{print $4}' | grep '/$' | awk -F/ '{print $1}' | sort -u)

	if [[ -d "${destinationPath}" ]]; then
		rm -rf "${destinationPath}"
	fi

	ln -s "${WORKDIR}/${parentSourceDir}" "${destinationPath}"
}


src_prepare() {
	# Default prepare
	cmake_src_prepare

	# Make plugins symlinks
	for plugin in "${PLUGINS[@]}"; do
		_make_symlink "${DISTDIR}/albert-plugin-${plugin}" "${S}/plugins/${plugin}"
	done

	# Pybind11
	_make_symlink "${DISTDIR}/albert-plugin-pybind11" "${S}/plugins/python/pybind11"

	# Make libs symlinks
	for lib in "${LIBS[@]}"; do
		local zipMainDir=$(unzip -l "${DISTDIR}/albert-lib-${lib}" | awk '{print $4}' | grep '/$' | awk -F/ '{print $1}' | sort -u)
		if [[ -d "${S}/lib/${lib}" ]]; then
			rm -rf "${S}/lib/${lib}"
		fi
		ln -s "${WORKDIR}/${zipMainDir}" "${S}/lib/${lib}"
	done
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_DEBUG=$(usex debug)
		-DBUILD_PYTHON=$(usex python)
	)

	cmake_src_configure
}

