# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit cmake-utils mercurial

DESCRIPTION="THe Experimental RAw Photo Editor"
HOMEPAGE="http://www.rawtherapee.com/"
EHG_REPO_URI="https://rawtherapee.googlecode.com/hg/"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

RDEPEND="dev-cpp/gtkmm:2.4
	media-libs/jpeg
	media-libs/tiff
	media-libs/libpng
	media-libs/libiptcdata
	media-libs/lcms"

RESTRICT="strip"

S=${WORKDIR}/hg

src_unpack() {
	mercurial_src_unpack
	cd ${S}
	sed -ie 's:${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}):\"${CMAKE_CXX_FLAGS} ${OpenMP_CXX_FLAGS}\"):g' CMakeLists.txt
}

src_install() {
	cmake-utils_src_install

	insinto "/usr/share/pixmaps"
	doins "${FILESDIR}/${PN}.png" || die
	insinto "/usr/share/applications"
	doins "${FILESDIR}/${PN}.desktop" || die
}
