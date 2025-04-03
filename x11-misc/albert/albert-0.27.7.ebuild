# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{11..13} )

inherit cmake python-single-r1 xdg git-r3

DESCRIPTION="A fast and flexible keyboard launcher"
HOMEPAGE="https://albertlauncher.github.io/"

I18N_URL="https://github.com/albertlauncher/i18n.git"
PLUGINS_URL="https://github.com/albertlauncher/plugins.git"
QNOTIFICATION_URL="https://github.com/QtCommunity/QNotification.git"
QHOTKEY_URL="https://github.com/Skycoder42/QHotkey.git"
PYTHON_PLUGINS_URL="https://github.com/albertlauncher/python.git"
PYBIND11_URL="https://github.com/pybind/pybind11.git"

SRC_URI="
	https://github.com/albertlauncher/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
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

src_unpack() {
	# Unpack Albert
	unpack ${A}

	# Unpack I18N
	git-r3_fetch "${I18N_URL}" refs/heads/main || die "Fetch of ${I18N_URL} failed!"
	git-r3_checkout "${I18N_URL}" "${S}/i18n" || die "Checkout of ${I18N_URL} failed!"

	# Unpack plugins
	git-r3_fetch "${PLUGINS_URL}" refs/heads/main || die "Fetch of ${PLUGINS_URL} failed!"
	git-r3_checkout "${PLUGINS_URL}" "${S}/plugins" || die "Checkout of ${PLUGINS_URL} failed!"

	# Unpack QNotification
	git-r3_fetch "${QNOTIFICATION_URL}" refs/heads/main || die "Fetch of ${QNOTIFICATION_URL} failed!"
	git-r3_checkout "${QNOTIFICATION_URL}" "${S}/lib/QNotification" || die "Checkout of ${QNOTIFICATION_URL} failed!"


	# Unpack QHotkey
	git-r3_fetch "${QHOTKEY_URL}"	refs/heads/master || die "Fetch of ${QHOTKEY_URL} failed!"
	git-r3_checkout "${QHOTKEY_URL}" "${S}/lib/QHotkey" || die "Checkout of ${QHOTKEY_URL} failed!"

	if use python; then
		git-r3_fetch "${PYBIND11_URL}" refs/heads/v2.13 || die "Fetch of ${PYBIND11_URL} failed!"
		git-r3_checkout "${PYBIND11_URL}" "${S}/plugins/python/pybind11" || die "Checkout of ${PYBIND11_URL} failed!"
	fi

	if use python-extensions; then
		git-r3_fetch "${PYTHON_PLUGINS_URL}" refs/heads/main || die "Fetch of ${PYTHON_PLUGINS_URL} failed!"
		git-r3_checkout "${PYTHON_PLUGINS_URL}" "${S}/plugins/python/plugins" || die "Checkout of ${PYTHON_PLUGINS_URL} failed!"
	fi
}

src_configure() {
	local mycmakeargs=(
		-DBUILD_DEBUG=$(usex debug)
		-DBUILD_PYTHON=$(usex python)
	)

	cmake_src_configure
}
