# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Similarity Analyser"
HOMEPAGE="http://www.redhillconsulting.com.au/products/simian/"
SRC_URI="http://www.redhillconsulting.com.au/products/simian/${PF}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=""
RDEPEND="virtual/jre"

src_install() {
	insinto /usr/share/doc/${PF}
	doins *.html *.gif *.jpg *.png *.dtd *.xsl
	doins LICENSE.txt

	insinto /usr/share/simian
	rm bin/*.exe
	doins -r bin/*

	echo "#!/bin/bash" >> simian
	echo "java -jar /usr/share/simian/${PF}.jar \$*" >> simian
	chmod +x simian
	exeinto /usr/bin
	doexe simian
}
