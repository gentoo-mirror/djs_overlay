# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info linux-mod
if [[ -z ${PV%%*9999} ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/antoineco/${PN}.git"
else
	MY_PV="452d163"
	[[ -n ${PV%%*_p*} ]] && MY_PV="${PV}"
	SRC_URI="
		mirror://githubcl/antoineco/${PN}/tar.gz/${MY_PV} -> ${P}.tar.gz
	"
	RESTRICT="primaryuri"
	KEYWORDS="~amd64"
	S="${WORKDIR}/${PN}-${MY_PV}"
fi

DESCRIPTION="Broadcom Linux hybrid wireless driver"
HOMEPAGE="https://www.broadcom.com/support/802.11"

LICENSE="Broadcom"

DEPEND="virtual/linux-sources"
RDEPEND=""

MODULE_NAMES="wl(net/wireless)"
MODULESD_WL_ALIASES=("wlan0 wl")

pkg_setup() {
#	CONFIG_CHECK="~!B43 ~!BCMA ~!SSB"
#	CONFIG_CHECK2="LIB80211 ~!MAC80211 ~LIB80211_CRYPT_TKIP"
#	ERROR_B43="B43: If you insist on building this, you must blacklist it!"
#	ERROR_BCMA="BCMA: If you insist on building this, you must blacklist it!"
#	ERROR_SSB="SSB: If you insist on building this, you must blacklist it!"
#	ERROR_LIB80211="LIB80211: Please enable it. If you can't find it: enabling the driver for \"Intel PRO/Wireless 2100\" or \"Intel PRO/Wireless 2200BG\" (IPW2100 or IPW2200) should suffice."
#	ERROR_MAC80211="MAC80211: If you insist on building this, you must blacklist it!"
#	ERROR_PREEMPT_RCU="PREEMPT_RCU: Please do not set the Preemption Model to \"Preemptible Kernel\"; choose something else."
#	ERROR_LIB80211_CRYPT_TKIP="LIB80211_CRYPT_TKIP: You will need this for WPA."
#	if kernel_is ge 3 8 8; then
#		CONFIG_CHECK="${CONFIG_CHECK} ${CONFIG_CHECK2} CFG80211 ~!PREEMPT_RCU ~!PREEMPT"
#	elif kernel_is ge 2 6 32; then
#		CONFIG_CHECK="${CONFIG_CHECK} ${CONFIG_CHECK2} CFG80211"
#	elif kernel_is ge 2 6 31; then
#		CONFIG_CHECK="${CONFIG_CHECK} ${CONFIG_CHECK2} WIRELESS_EXT ~!MAC80211"
#	elif kernel_is ge 2 6 29; then
#		CONFIG_CHECK="${CONFIG_CHECK} ${CONFIG_CHECK2} WIRELESS_EXT COMPAT_NET_DEV_OPS"
#	else
#		CONFIG_CHECK="${CONFIG_CHECK} IEEE80211 IEEE80211_CRYPT_TKIP"
#	fi

	linux-mod_pkg_setup

	BUILD_PARAMS="CC=\"$(tc-getBUILD_CC)\" KERN_DIR=${KV_DIR} KERN_VER=${KV_FULL} O=${KV_OUT_DIR} V=1 KBUILD_VERBOSE=1"
	BUILD_PARAMS+=" -C ${KV_DIR} M=${S}"
	BUILD_TARGETS="wl.ko"
}

src_prepare() {
	# Initialize kernel info
	get_version || die "Failed to get kernel version"

	local PATCHES=(
		"${FILESDIR}/${PN}-6.30.223.141-makefile.patch"
		"${FILESDIR}/${PN}-6.30.223.141-gcc.patch"
		"${FILESDIR}/${PN}-6.30.223.271-r4-linux-4.7.patch"
	)

	if linux_chkconfig_present PAX_CONSTIFY_PLUGIN; then
		PATCHES+=( "${FILESDIR}"/${PN}-6.30.223.271-pax-no-const.patch )
	fi

	# This is relevant for kernel 6.12 and on
	if kernel_is ge 6 12; then
		eapply "${FILESDIR}/${PN}-6.30.223.271-kernel-6.12.patch"
	fi

	# This is relevant for kernel 6.12 and on
	if kernel_is ge 6 13; then
		eapply "${FILESDIR}/${PN}-6.30.223.271-kernel-6.13.patch"
	fi

	# This is relevant for kernel 6.14 and on
	if kernel_is ge 6 14; then
		eapply "${FILESDIR}/${PN}-6.30.223.271-kernel-6.14.patch"
	fi

	default
}
