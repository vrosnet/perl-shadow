# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Tree-DAG_Node/Tree-DAG_Node-1.05.ebuild,v 1.13 2011/10/09 16:58:19 armin76 Exp $

inherit perl-module

DESCRIPTION="(super)class for representing nodes in a tree"
HOMEPAGE="http://search.cpan.org/~sburke/"
SRC_URI="mirror://cpan/authors/id/S/SB/SBURKE/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ia64 ppc ~s390 ~sh sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
