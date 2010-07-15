# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit cmake-utils

RESTRICT="mirror"

MY_PN=AlgoScore

DESCRIPTION="Algorithmic Composition Environment"
HOMEPAGE="http://www.bitminds.net/kymatica/index.php/Software/AlgoScore"
SRC_URI="http://download.gna.org/algoscore/${MY_PN}-${PV}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}/${MY_PN}/src"
