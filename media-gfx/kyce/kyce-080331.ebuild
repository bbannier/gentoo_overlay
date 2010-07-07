# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

RESTRICT="mirror"

MY_PN="KyCE-II"

DESCRIPTION="Kymatica Compositional Environment"
HOMEPAGE="http://www.kymatica.com"
SRC_URI="http://www.bitminds.net/kymatica/uploads/Software/${MY_PN}-${PV}.tar.bz2"

LICENSE=""
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="x11-libs/gtk+
	x11-libs/cairo
	media-libs/alsa-lib"
RDEPEND=""

S="${WORKDIR}/${MY_PN}"/src

src_install() {
	cd "${WORKDIR}"
	cp "${MY_PN}/src/kyce" "${MY_PN}/src/cntbug" "${MY_PN}"
	rm -rf "${MY_PN}/src" "${MY_PN}/old"

	mkdir -p "${D}/opt/"
	mv ${MY_PN} "${D}/opt/${MY_PN}"
}
