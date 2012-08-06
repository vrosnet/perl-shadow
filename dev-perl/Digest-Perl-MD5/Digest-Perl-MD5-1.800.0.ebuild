# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Digest-Perl-MD5/Digest-Perl-MD5-1.800.0.ebuild,v 1.7 2012/08/06 13:20:23 aballier Exp $

EAPI=4

MODULE_AUTHOR=DELTA
MODULE_VERSION=1.8
inherit perl-module

DESCRIPTION="Pure perl implementation of MD5"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="amd64 ~arm ~hppa ~ia64 ~sparc x86 ~amd64-fbsd ~ppc-macos ~x64-macos ~x86-macos ~x64-solaris ~x86-solaris"
IUSE=""

SRC_TEST="do"
