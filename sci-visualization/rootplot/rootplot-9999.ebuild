# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit mercurial distutils 

DESCRIPTION="Tools to plot ROOT histograms using matplotlib"
HOMEPAGE="http://packages.python.org/rootplot/"
EHG_REPO_URI="http://bitbucket.org/klukas/${PN}"

LICENSE="PYTHON"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}"/${PN}
