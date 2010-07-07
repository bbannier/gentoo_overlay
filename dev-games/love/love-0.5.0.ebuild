# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit games versionator

MY_PV=$(replace_version_separator 2 '-')

DESCRIPTION="Free 2D Game Engine"
HOMEPAGE="http://love2d.org"
SRC_URI="http://downloads.sourceforge.net/${PN}/${PN}-${MY_PV}.tar.bz2"

LICENSE=""
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-lang/lua
	dev-games/physfs
	media-libs/devil"
RDEPEND=""

S="${WORKDIR}/${PN}-${MY_PV}"

src_install() {
	einstall    || die "install failed"
}

