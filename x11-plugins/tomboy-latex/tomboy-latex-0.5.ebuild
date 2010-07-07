# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit autotools mono eutils

DESCRIPTION="LaTeX math plugin for Tomboy"
HOMEPAGE="http://www.reitwiessner.de/programs/tomboy-latex.html"
SRC_URI="http://www.reitwiessner.de/programs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=app-misc/tomboy-0.7
		>=dev-lang/mono-1.0"
RDEPEND="media-gfx/imagemagick
		virtual/latex-base"

src_install() {
	insinto /usr/lib/tomboy/addins
	doins src/Latex.dll
}

