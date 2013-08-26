# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/HTML-Object/HTML-Object-2.29-r2.ebuild,v 1.1 2013/08/26 08:23:52 idella4 Exp $

EAPI=5

inherit perl-module

MY_P=libhtmlobject-perl-${PV}

DESCRIPTION="A HTML development and delivery Perl Module"
SRC_URI="mirror://sourceforge/htmlobject/${MY_P}.tar.gz"
HOMEPAGE="http://htmlobject.sourceforge.net"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="examples"

RDEPEND="dev-perl/Data-FormValidator
	dev-perl/DateManip"
DEPEND="${RDEPEND}"
SRC_TEST="do"

S=${WORKDIR}/${MY_P}

src_install() {
	perl-module_src_install
	if use examples; then
		docompress -x usr/share/doc/${PF}/examples/
		insinto usr/share/doc/${PF}
		doins -r examples/
	fi
}
