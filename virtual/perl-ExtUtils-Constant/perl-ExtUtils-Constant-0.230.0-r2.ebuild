# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-ExtUtils-Constant/perl-ExtUtils-Constant-0.230.0-r2.ebuild,v 1.3 2012/11/12 22:01:47 blueness Exp $

DESCRIPTION="Virtual for ${PN#perl-}"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE=""

RDEPEND="|| ( =dev-lang/perl-5.16* =dev-lang/perl-5.14* ~perl-core/${PN#perl-}-${PV} )"
