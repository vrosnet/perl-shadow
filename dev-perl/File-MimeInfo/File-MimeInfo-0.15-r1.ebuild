# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-MimeInfo/File-MimeInfo-0.15-r1.ebuild,v 1.16 2011/08/17 16:46:03 chithanh Exp $

EAPI=3

MODULE_AUTHOR=PARDUS
MODULE_SECTION=${PN}
inherit perl-module

DESCRIPTION="Determine file type"

SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~amd64-linux ~x86-linux ~sparc-solaris"
IUSE="test"

RDEPEND=">=dev-perl/File-BaseDir-0.03
	>=dev-perl/File-DesktopEntry-0.04
	x11-misc/shared-mime-info"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"
