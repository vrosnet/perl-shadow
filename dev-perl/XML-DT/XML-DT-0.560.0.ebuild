# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/XML-DT/XML-DT-0.560.0.ebuild,v 1.3 2012/02/24 16:47:12 jer Exp $

EAPI=4

MODULE_AUTHOR=AMBS
MODULE_VERSION=0.56
MODULE_SECTION=XML
inherit perl-module

DESCRIPTION="A perl XML down translate module"

SLOT="0"
KEYWORDS="~alpha amd64 hppa ~ia64 ~ppc ~sparc ~x86"
IUSE="test"

RDEPEND=">=dev-perl/libwww-perl-1.35
	>=dev-perl/XML-LibXML-1.60
	>=dev-perl/XML-DTDParser-2.00"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"
