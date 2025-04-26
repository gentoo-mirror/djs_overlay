# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

LUA_COMPAT=(luajit)
# TODO: other targets (buildsystem is crazy and needs patches)

inherit cmake lua-single git-r3

DESCRIPTION="Heroes of Might and Magic III game engine rewrite"
HOMEPAGE="http://forum.vcmi.eu/index.php"
INSTALL_PATH="/opt/vcmi"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
# TODO: other arches
IUSE="+editor debug erm +launcher lua +nullkiller-ai +translations"

# Get package version, get default values, if not underscore keep them
PACKAGE_VERSION=${PV}
PACKAGE_NAME=${P}
if [[ ${PACKAGE_VERSION} == *_p* ]]; then
	PACKAGE_VERSION="${PV%%_*}"
	PACKAGE_NAME="${PN}-${PACKAGE_VERSION}"
fi

PATCHES=(
	# Patches to current git state
	#"${FILESDIR}/${P}-AI.patch"
	#"${FILESDIR}/${P}-CI.patch"
	#"${FILESDIR}/${P}-basic_files.patch"
	#"${FILESDIR}/${P}-client.patch"
	#"${FILESDIR}/${P}-global.patch"
	#"${FILESDIR}/${P}-include.patch"
	#"${FILESDIR}/${P}-launcher.patch"
	#"${FILESDIR}/${P}-lib.patch"
	#"${FILESDIR}/${P}-lobby.patch"
	#"${FILESDIR}/${P}-mapeditor.patch"
	#"${FILESDIR}/${P}-Mods.patch"
	#"${FILESDIR}/${P}-scripting.patch"
	#"${FILESDIR}/${P}-scripts.patch"
	#"${FILESDIR}/${P}-server.patch"
	#"${FILESDIR}/${P}-serverapp.patch"
	#"${FILESDIR}/${P}-test.patch"
	#"${FILESDIR}/${P}-vcmiqt.patch"

	# Boost 1.87
	#"${FILESDIR}/${P}-boost-1.87.patch"
)

FUZZYLITE_VERSION="6.0"
GOOGLETEST_VERSION="1.15.2"

if [[ ${PACKAGE_VERSION} == *9999* ]]; then
	EGIT_REPO_URI="https://github.com/vcmi/vcmi.git"
	EGIT_BRANCH="develop"
else
	SRC_URI="
		https://github.com/vcmi/vcmi/archive/refs/tags/${PACKAGE_VERSION}.tar.gz -> ${P}.tar.gz
		https://github.com/fuzzylite/fuzzylite/archive/refs/tags/v${FUZZYLITE_VERSION}.tar.gz -> fuzzylite.tar.gz
		https://github.com/google/googletest/archive/refs/tags/v${GOOGLETEST_VERSION}.tar.gz -> googletest.tar.gz
		"
	EGIT_REPO_URI="https://github.com/vcmi/innoextract.git"
fi
REQUIRED_USE="
	erm? ( lua )
	lua? ( ${LUA_REQUIRED_USE} )
"

RDEPEND="
	nullkiller-ai? ( dev-cpp/tbb )
	dev-lang/luajit
	dev-libs/fuzzylite
	>=dev-libs/boost-1.70:=
	launcher? (
		dev-qt/qtcore:=
		dev-qt/qtgui:=
		dev-qt/qtnetwork:=
		dev-qt/qtwidgets:=
		translations? ( dev-qt/linguist-tools )
	)
	editor? (
		dev-qt/qtcore:=
		dev-qt/qtgui:=
		dev-qt/qtnetwork:=
		dev-qt/qtwidgets
		translations? ( dev-qt/linguist-tools )
	)
	sys-libs/zlib:=[minizip]
	media-video/ffmpeg:=
	media-libs/libsdl2:=[X]
	media-libs/sdl2-image:=
	media-libs/sdl2-mixer:=
	media-libs/sdl2-ttf:=
"

DEPEND="${RDEPEND}"

if [[ ${PACKAGE_VERSION} != *9999* ]]; then
src_unpack() {
	# Unpack ALL Packages
	unpack ${A}

	# Move if not equal
	if [[ "${P}" != "${PACKAGE_NAME}" ]]; then
		mv "${WORKDIR}/${PACKAGE_NAME}" "${WORKDIR}/${P}"
	fi

	# Clone innoextract
	git clone "https://github.com/vcmi/innoextract.git" "${WORKDIR}/innoextract"

	# Delete target directories
	rmdir "${WORKDIR}/${P}/AI/FuzzyLite" || die "FuzzyLite dir not deleted"
	rmdir "${WORKDIR}/${P}/launcher/lib/innoextract" || die "innoextract dir not deleted"
	rmdir "${WORKDIR}/${P}/test/googletest" || die "Googletest dir not deleted"

	# Make symlinks, mostly mv is used, but I will try to go using ln -s, dosym doesnt work here
	ln -s "${WORKDIR}/fuzzylite-${FUZZYLITE_VERSION}" "${WORKDIR}/${P}/AI/FuzzyLite" || die "FuzzyLite symlink not created"
	ln -s "${WORKDIR}/googletest-${GOOGLETEST_VERSION}" "${WORKDIR}/${P}/test/googletest" || die "Googletest symlink not created"
	ln -s "${WORKDIR}/innoextract" "${WORKDIR}/${P}/launcher/lib/innoextract" || die "innoextract symlink not created"

	# Unpack icons
	#tar -xzvf "${FILESDIR}/${P}-launcher-icons.tar.gz" -C "${WORKDIR}/${P}/launcher/icons/" || die "Failed to extract launcher/icons"
	#tar -xzvf "${FILESDIR}/${P}-mapeditor-icons.tar.gz" -C "${WORKDIR}/${P}/mapeditor/icons/" || die "Failed to extract mapeditor/icons"
}
fi

#src_prepare() {
#	cmake_src_prepare

	# Clientapp folder doesnt exits so I need to apply patch and then unpack
	#eapply "${FILESDIR}/${P}-clientapp.patch" || die "Failed to apply clientapp.patch"
	#tar -xzvf "${FILESDIR}/${P}-clientapp-icons.tar.gz" -C "${WORKDIR}/${P}/clientapp/icons/" || die "Failed to extract clientapp/icons"
#}

src_configure() {
	local mycmakeargs=(
		-DENABLE_ERM=$(usex erm)
		-DENABLE_LUA=$(usex lua)
		-DENABLE_LAUNCHER=$(usex launcher)
		-DENABLE_EDITOR=$(usex editor)
		-DENABLE_TRANSLATIONS=$(usex translations)
		-DENABLE_PCH=$(usex !debug)
		-DENABLE_NULLKILLER_AI=$(usex nullkiller-ai)
		-DENABLE_MONOLITHIC_INSTALL=OFF
		-DFORCE_BUNDLED_FL=OFF
		-DFORCE_BUNDLED_MINIZIP=OFF
		-DENABLE_GITVERSION=OFF
		-DBoost_NO_BOOST_CMAKE=ON
	)
#	export CCACHE_SLOPPINESS="time_macros"
	cmake_src_configure
}

pkg_postinst() {
	# Save actual commit version
	if [[ ${PACKAGE_VERSION} == *9999* ]]; then
		local vdb_commit_file="/var/db/pkg/games-strategy/${P}/.installed_commit"
		local current_commit=$(git rev-parse HEAD)
		echo "${current_commit}" > "${vdb_commit_file}"
	fi

	elog "For the game to work properly, please copy your"
	elog 'Heroes Of Might and Magic ("The Wake Of Gods" or'
	elog '"Shadow of Death" or "Complete edition")'
	elog "game directory into /usr/share/${PN}."
	elog "or use 'vcmibuilder' utility on your:"
	elog "   a) One or two CD's or CD images"
	elog "   b) gog.com installer"
	elog "   c) Directory with installed game"
	elog "(although installing it in such way is 'bad practices')."
	elog "For more information, please visit:"
	elog "http://wiki.vcmi.eu/index.php?title=Installation_on_Linux"
	elog ""
	elog "Also, you may want to install VCMI Extras and Wake of Gods"
	elog "mods from the launcher after you'll start the game"
}
