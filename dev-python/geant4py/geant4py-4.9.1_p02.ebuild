# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit multilib versionator toolchain-funcs python

DESCRIPTION="Python bindings for Geant4"
HOMEPAGE="http://www-geant4.kek.jp/projects/Geant4Py/"

PV1=$(get_version_component_range 1 ${PV})
PV2=$(get_version_component_range 2 ${PV})
PV3=$(get_version_component_range 3 ${PV})
G4_P=geant$(replace_version_separator 3 .)
G4_P=${G4_P/beta/b0}

SRC_URI="http://geant4.web.cern.ch/geant4/support/source/${G4_P}.tar.gz"

LICENSE="geant4"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=sci-physics/geant-4.8.0
		>=dev-lang/python-2.5.0
		>=dev-libs/boost-1.32
		>=sci-physics/clhep-2.0.3.2
		>=sci-physics/clhep-1.9.1.1"
RDEPEND=">=sci-physics/geant-4.8.0
		>=dev-lang/python-2.5.0"

S="${WORKDIR}/${G4_P}/environments/g4py"

pkg_setup() {
	if [[ ! -e /usr/$(get_libdir)/libboost_python.so ]] ; then
		eerror "The Boost.Python library could not be found."
		eerror "Please re-emerge dev-libs/boost with USE=python."
		die "Boost.Python lib not found"
	fi

	if [[ ! -e /usr/$(get_libdir)/geant4/libG4global.so ]] ; then
		eerror "Geant4 seems to be compiled without global libraries."
		eerror "Please re-emerge sci-physics/geant-4.* with USE=global."
		die "Global geant4 libraries not found"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	# use user's CXXFLAGS and remove hardlinked rpaths
	for sys in config/sys/*.gmk; do
		echo "CXXFLAGS+=${CXXFLAGS}" >> $sys
		sed -i -e s/^rpathflag.*$// $sys
	done
}

src_test() {
	cd "${S}"/tests

	# remove test that behave somehow broken
	do_not_run="test01 test02 test03 test04 test05 test06 test11 \
			gtest01 gtest02/test3.py gtest03 gtest05 gtest06 gtest07"
	for test in $do_not_run; do
		rm -rf $test
		sed -i -e s/$(basename $test)//g GNUmakefile
	done

	# top makefile does not build everything
	for dir in $(find . -name GNUmakefile); do
		pushd $(dirname $dir)
		emake || die "Make $dir failed"
		popd
	done
	emake # and rebuild

	# run tests
	for dir in *test*; do
		pushd $dir
		for test in *py; do
			PYTHONPATH=../../tmp/lib:.:./mylib:$PYTHONPATH LD_LIBRARY_PATH=./mylib:$LD_LIBRARY_PATH python $test || \
				die "$dir failed"
		done
		popd
	done
}

src_compile() {
	python_version
	cd "${S}"
	# ./configure package ... this is not configure and does not want to behave
	# like one, e.g. it doesn't make sense to append options. Change the script
	# instead.
	./configure linux \
		--with-g4-incdir=/usr/include/geant/ \
		--with-g4-libdir=/usr/$(get_libdir)/geant4 \
		--with-clhep-incdir=/usr/include/CLHEP \
		--with-clhep-libdir=/usr/$(get_libdir)/ \
		--prefix=${PWD}/tmp \
		--with-python-incdir=/usr/include/python${PYVER} \
		|| die "Configure failed"
	export CPPVERBOSE=1
	emake || die "Compile failed"
	einstall || die "Install failed"
}

src_install() {
	insinto /usr/$(get_libdir)/python${PYVER}
	doins -r tmp/lib/Geant4

	insinto /usr/share/doc/${PF}
	dodoc AUTHORS 00README History
}
