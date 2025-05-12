# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Universal Wayland Session Manager"
HOMEPAGE="https://github.com/Vladimir-csp/uwsm"
SRC_URI="https://github.com/Vladimir-csp/uwsm/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"

DEPEND="dev-build/meson
		dev-build/ninja
		sys-devel/gcc
		dev-python/dbus-python
		dev-python/pyxdg
"
RDEPEND="${DEPEND}"

MESON_ARGS=(
	-Duuctl=enabled
	-Dfumon=enabled
	-Duwsm-app=enabled
	-Ddocdir=/usr/share/doc/${PF}
)

src_install() {
	meson_src_install

	# Rename folder documentation
	dodir "/usr/share/doc/${PF}"
	mv "${D}/usr/share/doc/uwsm"/* "${D}/usr/share/doc/${PF}/" || die "Failed to repair documentation, move files."
	rmdir "${D}/usr/share/doc/uwsm" || die "Failed to repair documentation, delete old folder."
}
