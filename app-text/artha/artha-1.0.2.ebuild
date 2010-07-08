# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit autotools

DESCRIPTION="The Open Thesaurus"
HOMEPAGE="http://artha.sourcefourge.net"
SRC_URI="http://voxel.dl.sourceforge.net/sourceforge/${PN}/${PF}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND=">=dev-libs/glib-2.14
		>=x11-libs/gtk+-2.12
		>=app-dicts/wordnet-3.0
		>=dev-libs/dbus-glib-0.70"
RDEPEND=""

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
}

