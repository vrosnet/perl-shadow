# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/suse-build/suse-build-9999.ebuild,v 1.5 2012/10/02 11:17:27 scarabeus Exp $

EAPI=4

EGIT_REPO_URI="git://github.com/openSUSE/obs-build.git"

if [[ "${PV}" == "9999" ]]; then
	EXTRA_ECLASS="git-2"
else
	OBS_PACKAGE="build"
	OBS_PROJECT="openSUSE:Tools"
	EXTRA_ECLASS="obs-download"
fi

inherit eutils ${EXTRA_ECLASS}
unset EXTRA_ECLASS

DESCRIPTION="Script to build SUSE Linux RPMs"
HOMEPAGE="https://build.opensuse.org/package/show?package=build&project=openSUSE%3ATools"

[[ "${PV}" == "9999" ]] || SRC_URI="${OBS_URI}/${PN/suse/obs}-${PV//.}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""
[[ "${PV}" == "9999" ]] || KEYWORDS="~amd64 ~x86"

RDEPEND="
	virtual/perl-Digest-MD5
	virtual/perl-Getopt-Long
	dev-perl/XML-Parser
	dev-perl/TimeDate
	app-shells/bash
	app-arch/rpm
"

S="${WORKDIR}/${PN/suse/obs}-${PV//.}"

src_compile() { :; }

src_install() {
	emake DESTDIR="${ED}" pkglibdir=/usr/share/suse-build install
	cd "${ED}"/usr
	find bin -type l | while read i; do
		mv "${i}" "${i/bin\//bin/suse-}"
	done
	find share/man/man1 -type f | while read i; do
		mv "${i}" "${i/man1\//man1/suse-}"
	done
	find . -type f -exec sed -i 's|/usr/lib/build|/usr/share/suse-build|' {} +
}
