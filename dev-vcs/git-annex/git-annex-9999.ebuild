# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

EGIT_REPO_URI="git://git.kitenet.net/git-annex"
EGIT_BRANCH="master"

inherit git

DESCRIPTION="Manage files with git, without checking their contents in"
HOMEPAGE="http://git-annex.branchable.com"
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

DEPEND="dev-vcs/git
	dev-haskell/missingh
	dev-haskell/utf8-string
	dev-haskell/pcre-light
	dev-libs/ossp-uuid
	sys-apps/findutils"

RDEPEND="${DEPEND}"

src_install() {
	emake DESTDIR="${D}" install || die "emake install fails"
	doman git-annex.1
	dodoc CHANGELOG
}
