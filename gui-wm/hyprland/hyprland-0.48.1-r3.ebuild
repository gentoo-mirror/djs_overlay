# Copyright 2023-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson toolchain-funcs djs-functions

DESCRIPTION="A dynamic tiling Wayland compositor that doesn't sacrifice on its looks"
HOMEPAGE="https://github.com/hyprwm/Hyprland"

EXPERIMENTAL_COMMIT="1ce614dfc0eb8b323e603b76975842c1f2e6a553"

SRC_URI="
	https://github.com/hyprwm/Hyprland/archive/${EXPERIMENTAL_COMMIT}.tar.gz -> ${P}-${EXPERIMENTAL_COMMIT}.tar.gz
	https://github.com/hyprwm/${PN^}/releases/download/v${PV}/source-v${PV}.tar.gz -> ${P}.gh.tar.gz
"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"

IUSE="X legacy-renderer +qtutils systemd experimental"

# hyprpm (hyprland plugin manager) requires the dependencies at runtime
# so that it can clone, compile and install plugins.
HYPRPM_RDEPEND="
	app-alternatives/ninja
	>=dev-build/cmake-3.30
	dev-build/meson
	dev-vcs/git
	virtual/pkgconfig
"
RDEPEND="
	${HYPRPM_RDEPEND}
	dev-cpp/tomlplusplus
	dev-libs/glib:2
	dev-libs/hyprlang
	dev-libs/libinput:=
	dev-libs/hyprgraphics:=
	dev-libs/re2:=
	>=dev-libs/udis86-1.7.2
	>=dev-libs/wayland-1.22.90
	>=gui-libs/aquamarine-0.4.2
	>=gui-libs/hyprcursor-0.1.9
	gui-libs/hyprutils:=
	media-libs/libglvnd
	media-libs/mesa
	sys-apps/util-linux
	x11-libs/cairo
	x11-libs/libdrm
	x11-libs/libxkbcommon
	x11-libs/pango
	x11-libs/pixman
	x11-libs/libXcursor
	qtutils? ( gui-libs/hyprland-qtutils )
	dev-libs/glaze
	X? (
		x11-libs/libxcb:0=
		x11-base/xwayland
		x11-libs/xcb-util-errors
		x11-libs/xcb-util-wm
	)
"
DEPEND="
	${RDEPEND}
	>=dev-libs/hyprland-protocols-0.4
	>=dev-libs/wayland-protocols-1.36
"
BDEPEND="
	|| ( >=sys-devel/gcc-14:* >=llvm-core/clang-18:* )
	app-misc/jq
	dev-build/cmake
	>=dev-util/hyprwayland-scanner-0.3.10
	virtual/pkgconfig
"

src_unpack() {
	default

	# When experimental we need to adjust source a little
	if use experimental; then
		# LInk subprojects
		rm -rf "${WORKDIR}/Hyprland-${EXPERIMENTAL_COMMIT}/subprojects/" || die "Could not delete subprojects directory."
		ln -s "${WORKDIR}/hyprland-source/subprojects" "${WORKDIR}/Hyprland-${EXPERIMENTAL_COMMIT}/subprojects" ||\
			die "Could not create symlink for subproject directory."

		cp "${FILESDIR}/version.h.experimental" "${WORKDIR}/Hyprland-${EXPERIMENTAL_COMMIT}/src/version.h"

		S="${WORKDIR}/Hyprland-${EXPERIMENTAL_COMMIT}"
	else
		# Make symlink to package name
		S="${WORKDIR}/hyprland-source"
	fi
}

src_prepare() {
	default

	# Apply version patches
	# Apply package version PATCHES
	if use experimental; then
		patchPackage "${FILESDIR}" "${PN}" "experimental"
	else
		patchPackage "${FILESDIR}" "${PN}" "${PV}"
	fi
}

src_configure() {
	local emesonargs=(
		$(meson_feature legacy-renderer legacy_renderer)
		$(meson_feature systemd)
		$(meson_feature X xwayland)
	)

	meson_src_configure
}

pkg_setup() {
	[[ ${MERGE_TYPE} == binary ]] && return

	if tc-is-gcc && ver_test $(gcc-version) -lt 14 ; then
		eerror "Hyprland requires >=sys-devel/gcc-14 to build"
		eerror "Please upgrade GCC: emerge -v1 sys-devel/gcc"
		die "GCC version is too old to compile Hyprland!"
	elif tc-is-clang && ver_test $(clang-version) -lt 18 ; then
		eerror "Hyprland requires >=llvm-core/clang-18 to build"
		eerror "Please upgrade Clang: emerge -v1 llvm-core/clang"
		die "Clang version is too old to compile Hyprland!"
	fi
}
