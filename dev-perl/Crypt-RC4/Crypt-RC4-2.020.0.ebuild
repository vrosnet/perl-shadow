# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-RC4/Crypt-RC4-2.020.0.ebuild,v 1.9 2012/08/29 02:31:21 blueness Exp $

EAPI=4

MODULE_AUTHOR=SIFUKURT
MODULE_VERSION=2.02
inherit perl-module

DESCRIPTION="Implements the RC4 encryption algorithm"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~sparc x86 ~amd64-fbsd ~x86-fbsd ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

SRC_TEST="do"
