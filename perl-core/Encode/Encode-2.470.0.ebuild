# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Encode/Encode-2.470.0.ebuild,v 1.8 2013/02/19 09:37:52 ago Exp $

EAPI=4

MODULE_AUTHOR=DANKOGAI
MODULE_VERSION=2.47
inherit perl-module

DESCRIPTION="character encodings"

SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~m68k ~mips ppc ppc64 ~s390 ~sh ~sparc x86 ~ppc-aix ~amd64-fbsd ~x86-fbsd ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos"
IUSE=""

RDEPEND="!!<dev-lang/perl-5.8.8-r8"

SRC_TEST=do
PATCHES=( "${FILESDIR}"/gentoo_enc2xs.diff )
