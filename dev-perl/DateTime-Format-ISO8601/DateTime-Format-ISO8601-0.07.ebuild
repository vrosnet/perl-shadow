# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateTime-Format-ISO8601/DateTime-Format-ISO8601-0.07.ebuild,v 1.2 2011/07/19 19:51:53 maekke Exp $

EAPI=2

MODULE_AUTHOR="JHOBLITT"
inherit perl-module

DESCRIPTION="Parses ISO8601 formats"

SLOT="0"
KEYWORDS="amd64 x86"
IUSE="test"

RDEPEND="dev-perl/DateTime
	dev-perl/DateTime-Format-Builder"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( dev-perl/Test-Pod
		dev-perl/File-Find-Rule
		dev-perl/Test-Distribution )"

SRC_TEST=do
