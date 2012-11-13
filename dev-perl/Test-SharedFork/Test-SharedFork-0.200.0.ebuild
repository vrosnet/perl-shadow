# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-SharedFork/Test-SharedFork-0.200.0.ebuild,v 1.2 2012/11/12 22:16:21 blueness Exp $

EAPI=4

MODULE_AUTHOR=TOKUHIROM
MODULE_VERSION=0.20
inherit perl-module

DESCRIPTION="fork test"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? (
		dev-perl/Test-Requires
		>=virtual/perl-Test-Simple-0.88
		virtual/perl-Test-Harness
	)
"

SRC_TEST=do
