# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

BRAVE_PN="${PN/-bin/}"

CHROMIUM_LANGS="
	af am ar az bg bn ca cs da de el en-GB en-US es es-419 et fa fi fil fr gu he hi
	hr hu id it ja ka km kn ko lt lv ml mk mn mr ms my nb nl pl pt-BR pt-PT ro ru si sk sl sq sr sr-Latn sv
	sw ta te th tr uk ur uz vi zh-CN zh-TW
"

inherit chromium-2 xdg-utils desktop

DESCRIPTION="Brave Web Browser"
HOMEPAGE="https://brave.com"
SRC_URI="https://github.com/brave/brave-browser/releases/download/v${PV}/brave-browser-${PV}-linux-amd64.zip -> ${P}.zip"

S=${WORKDIR}
LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~amd64"
IUSE="keyring"

# New runtime dependencies based on ldd /usr/bin/brave-bin
RDEPEND="
	>=app-accessibility/at-spi2-core-2.46.0
	app-arch/bzip2
	app-arch/zstd
	app-crypt/p11-kit
	dev-libs/expat
	dev-libs/fribidi
	dev-libs/glib
	dev-libs/gmp
	dev-libs/libffi
	dev-libs/libpcre2
	dev-libs/libtasn1
	dev-libs/libunistring
	dev-libs/nettle
	dev-libs/nspr
	dev-libs/nss
	media-gfx/graphite2
	media-libs/alsa-lib
	media-libs/fontconfig
	media-libs/freetype
	media-libs/harfbuzz
	media-libs/libpng
	media-libs/mesa
	net-dns/avahi
	net-dns/libidn2
	net-libs/gnutls
	net-print/cups
	sys-apps/dbus
	sys-apps/util-linux
	sys-devel/gcc
	sys-libs/libcap
	sys-libs/zlib
	x11-libs/cairo
	x11-libs/libdrm
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libxcb
	x11-libs/libXcomposite
	x11-libs/libXdamage
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXi
	x11-libs/libxkbcommon
	x11-libs/libXrandr
	x11-libs/libXrender
	x11-libs/pango
	x11-libs/pixman
"

# gconf is deprecated.
# DEPEND="gnome-base/gconf:2"
#RDEPEND="
#	${DEPEND}
#	dev-libs/libpthread-stubs
#	x11-libs/libxcb
#	x11-libs/libXcomposite
#	x11-libs/libXcursor
#	x11-libs/libXdamage
#	x11-libs/libXext
#	x11-libs/libXfixes
#	x11-libs/libXi
#	x11-libs/libXrender
#	x11-libs/libXtst
#	x11-libs/libxshmfence
#	x11-libs/libXxf86vm
#	x11-libs/libXScrnSaver
#	x11-libs/libXrandr
#	x11-libs/libXau
#	x11-libs/libXdmcp
#	x11-libs/libXinerama
#	x11-libs/libxkbcommon
#	dev-libs/glib
#	dev-libs/nss
#	dev-libs/nspr
#	net-print/cups
#	sys-apps/dbus
#	dev-libs/expat
#	media-libs/alsa-lib
#	x11-libs/pango
#	x11-libs/cairo
#	dev-libs/gobject-introspection
#	>=app-accessibility/at-spi2-core-2.46.0
#	x11-libs/gtk+
#	x11-libs/gdk-pixbuf
#	dev-libs/libffi
#	dev-libs/libpcre
#	net-libs/gnutls
#	sys-libs/zlib
#	dev-libs/fribidi
#	media-libs/harfbuzz
#	media-libs/fontconfig
#	media-libs/freetype
#	x11-libs/pixman
#	>=media-libs/libpng-1.6.34
#	media-libs/libepoxy
#	dev-libs/libbsd
#	dev-libs/libunistring
#	dev-libs/libtasn1
#	dev-libs/nettle
#	dev-libs/gmp
#	net-dns/libidn2
#	media-gfx/graphite2
#	app-arch/bzip2
#"

BDEPEND="app-arch/unzip"

QA_PREBUILT="*"

src_prepare() {
	pushd "${S}/locales" > /dev/null || die
		chromium_remove_language_paks
	popd > /dev/null || die

	default
}

src_install() (
	shopt -s extglob

	local BRAVE_HOME=/opt/${BRAVE_PN}

	dodir ${BRAVE_HOME%/*}

	insinto ${BRAVE_HOME}
	doins -r *

	# Brave has a bug in 1.27.105 where it needs crashpad_handler chmodded
	# Delete crashpad_handler when https://github.com/brave/brave-browser/issues/16985 is resolved.
	exeinto ${BRAVE_HOME}
	doexe brave chrome_crashpad_handler

	dodir /opt/bin
	dosym ${BRAVE_HOME}/${BRAVE_PN} /opt/bin/${PN} || die

	# Install Icons for Brave.
	newicon "${FILESDIR}/braveAbout.png" "${PN}.png" || die
	newicon -s 128 "${FILESDIR}/braveAbout.png" "${PN}.png" || die

	# install-xattr doesnt approve using domenu or doins from FILESDIR
	make_desktop_entry 'brave-bin %u' Brave brave-bin 'Network;WebBrowser'
	#cp "${FILESDIR}"/${PN}.desktop "${S}"
	#domenu "${S}"/${PN}.desktop
)

pkg_postinst() {
	xdg_desktop_database_update
	xdg_mimeinfo_database_update
	xdg_icon_cache_update
	elog "If upgrading from 1.50.x release or earlier, note that Brave has changed the format of the"
	elog "password file, and ALL YOUR OLD PASSWORDS WILL NOT WORK."
	elog "YOUR BRAVE REWARDS WILL NOT WORK EITHER."
	elog "The solution is to temporarily downgrade back to 1.50.x (legacy ebuild provided),"
	elog "so you can export passwords from Brave's Password Manager."
	elog "once you're back in a newer build, import passwords from inside Brave's Password Manager,"
	elog "and select the file you saved."
}
