# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Template-Toolkit/Template-Toolkit-2.230.0.ebuild,v 1.1 2012/01/24 15:19:34 tove Exp $

EAPI=4

MODULE_AUTHOR=ABW
MODULE_VERSION=2.23
inherit perl-module

DESCRIPTION="The Template Toolkit"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~x86-solaris"
IUSE="xml gd mysql postgres latex vim-syntax"

RDEPEND="dev-perl/text-autoformat
	mysql? ( dev-perl/DBD-mysql )
	postgres? ( dev-perl/DBD-Pg )
	>=dev-perl/AppConfig-1.56"
DEPEND="${RDEPEND}"
PDEPEND="dev-perl/text-autoformat
	vim-syntax? ( app-vim/tt2-syntax )
	xml? ( dev-perl/Template-XML )
	gd? ( dev-perl/Template-GD )
	mysql? ( dev-perl/Template-DBI )
	latex? ( dev-perl/Template-Latex )
	postgres? ( dev-perl/Template-DBI )"

myconf=(
	TT_XS_ENABLE=y
	TT_XS_DEFAULT=y
	TT_QUIET=y
	TT_ACCEPT=y
)

SRC_TEST=do