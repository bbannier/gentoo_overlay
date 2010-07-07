# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit distutils git

DESCRIPTION="Fat Free Presentations"
HOMEPAGE="http://github.com/natano/presentation"
EGIT_REPO_URI="git://github.com/natano/presentation.git"

LICENSE=""
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-python/wxpython
	dev-python/python-poppler"
RDEPEND="${DEPEND}"

src_install() {
	distutils_src_install
}
