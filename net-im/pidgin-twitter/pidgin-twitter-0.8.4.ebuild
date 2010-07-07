# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Twitter support for pidgin"
HOMEPAGE="http://www.honeyplanet.jp/pidgin-twitter/"
SRC_URI="http://www.honeyplanet.jp/${PF}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="net-im/pidgin"

src_install() {
	insinto /usr/lib/pidgin/
	doins pidgin-twitter.so
}
