# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ZMQ-Constants/ZMQ-Constants-1.10.0.ebuild,v 1.2 2012/11/12 22:13:43 blueness Exp $

EAPI=4

MODULE_AUTHOR=DMAKI
MODULE_VERSION=1.01
inherit perl-module

DESCRIPTION="Constants for libzmq"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

RDEPEND="
	net-libs/zeromq
"
DEPEND="${RDEPEND}"

SRC_TEST=do
