# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/cppcheck/cppcheck-1.43.ebuild,v 1.1 2010/05/18 10:13:31 patrick Exp $

EAPI=2
inherit eutils toolchain-funcs qt4-r2

DESCRIPTION="static analyzer of C/C++ code"
HOMEPAGE="http://apps.sourceforge.net/trac/cppcheck/"
SRC_URI="mirror://sourceforge/cppcheck/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt4 html"

DEPEND="qt4? ( x11-libs/qt-gui:4 )
		html? ( dev-python/pygments )"

src_prepare() {
	sed -i \
		-e '/^CXXFLAGS/d' \
		-e '/^CXX=/d' \
		Makefile \
		|| die
	tc-export CXX
}

src_configure() {
	if use qt4; then
		pushd gui
		eqmake4 gui.pro
		popd
	fi
}

src_compile() {
	emake || die "make failed"
	if use qt4; then
		pushd gui
		emake || die "make gui failed"
		popd
	fi
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc readme.txt
	if use qt4; then
		newbin gui/gui cppcheck-gui
		dodoc readme_gui.txt gui/projectfile.txt gui/gui.cppcheck
	fi
	if use html; then
		dobin htmlreport/cppcheck-htmlreport
	fi
}