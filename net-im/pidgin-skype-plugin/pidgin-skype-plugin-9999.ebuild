# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Skype API PLugin for Pidgin"
HOMEPAGE="http://tinyurl.com/2by8rw"
SRC_URI="http://eion.robbmob.com/libskype_dbus.so \
			http://myjobspace.co.nz/images/pidgin/skype_icons.zip"

#http://myjobspace.co.nz/images/pidgin/libskype_dbus.so

LICENSE="public-domain CCPL-Attribution-ShareAlike-3.0"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="net-im/pidgin net-im/skype app-arch/zip"
RDEPEND=""

src_unpack( ) {
	unpack skype_icons.zip
}

src_install() {
	insinto /usr/lib/purple-2
	doins "${DISTDIR}/libskype_dbus.so"

	insinto /usr/share/pixmaps/pidgin/protocols/
	doins -r ??
}
