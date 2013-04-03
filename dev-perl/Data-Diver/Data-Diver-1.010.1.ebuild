# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Diver/Data-Diver-1.010.1.ebuild,v 1.1 2013/04/03 08:30:19 pinkbyte Exp $

EAPI=5

MODULE_AUTHOR=TYEMQ
MODULE_VERSION=1.0101
MODULE_A_EXT=tgz

inherit perl-module

DESCRIPTION="Simple, ad-hoc access to elements of deeply nested structures"

SLOT="0"
KEYWORDS="~amd64 ~x86"

SRC_TEST="do parallel"
