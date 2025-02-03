# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-info linux-mod git-r3

DESCRIPTION="Reverse engineered Linux driver for the Broadcom 1570 PCIe webcam"
HOMEPAGE="https://github.com/patjak/bcwc_pcie"

EGIT_REPO_URI="https://github.com/patjak/bcwc_pcie"

LICENSE="GPL-2"
SLOT="0"

RDEPEND="media-video/facetimehd-firmware
	media-libs/libv4l
"

BUILD_TARGETS="all"
MODULE_NAMES="facetimehd()"
#EGIT_BRANCH="master"
#CONFIG_CHECK="VIDEO_V4L2 VIDEOBUF2_CORE VIDEOBUF2_DMA_SG"
#PATCHES="${FILESDIR}/kernel-6.13-update.patch"

src_prepare() {
	sed -i "s#KDIR := /lib/modules/\$(KVERSION)/build#KDIR := ${KERNEL_DIR}#" Makefile || die

	# init kernel info
	get_version || die "Failed to get kernel version"

	# Apply patch only if kernel is 6.13 and newer
	if kernel_is ge 6 13; then
		eapply "${FILESDIR}/kernel-6.13-update.patch"
	fi

	default
}
