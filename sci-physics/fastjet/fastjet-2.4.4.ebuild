# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3
inherit eutils

DESCRIPTION="Fast implementation of several longitudinal invariant sequential
recombination jet algorithms"
HOMEPAGE="http://www.lpthe.jussieu.fr/~salam/fastjet/"
SRC_URI="http://www.lpthe.jussieu.fr/~salam/fastjet/repo/${PF}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="+allplugins +allcxxplugins cgal"

DEPEND="cgal? ( sci-mathematics/cgal )"
RDEPEND="${DEPEND}"

src_configure() {
	./configure \
		--prefix="${EPREFIX}"/usr \
		$(use_enable allplugins) \
		$(use_enable allcxxplugins) \
		$(use_enable cgal) \
		${EXTRA_ECONF} \
		|| die "configure failed"
}

pkg_setup() {
	if use allplugins || use allcxxplugins; then
		elog
		elog "Will build all plugins since you have one of allplugins or allcxxplugins set."
		elog "To only build selected plugins use the env variable EXTRA_ECONF"
		elog "with the plugin name e.g.:"
		elog "EXTRA_ECONF=--enable-siscone"
		elog "The following plugins are available:"
		elog "  - siscone"
		elog "  - cdfcones"
		elog "  - pxcone"
		elog "  - d0runiicone"
		elog "  - nesteddefs"
		elog "  - trackjet"
		elog "  - atlascone"
		elog "  - cmsiterativecone"
		elog "  - eecambridge"
		elog "  - jade"
		elog
	fi
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
