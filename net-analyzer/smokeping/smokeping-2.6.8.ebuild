# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/smokeping/smokeping-2.6.8.ebuild,v 1.1 2012/08/29 08:26:37 klausman Exp $

EAPI="4"

inherit eutils

DESCRIPTION="A powerful latency measurement tool."
HOMEPAGE="http://oss.oetiker.ch/smokeping/"
SRC_URI="http://oss.oetiker.ch/smokeping/pub/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
# dropping hppa and sparc because of way too may dependencies not having
# keywords in those architectures.
KEYWORDS=""
IUSE="apache2 curl dig echoping fcgi ipv6 ldap telnet"

DEPEND="!apache2? ( virtual/httpd-cgi )
		>=dev-lang/perl-5.8.8-r8
		>=dev-perl/SNMP_Session-1.13
		>=net-analyzer/fping-2.4_beta2-r2
		>=net-analyzer/rrdtool-1.2[perl]
		apache2? ( >=www-apache/mod_perl-2.0.1
		www-apache/mod_fcgid )
		curl? ( >=net-misc/curl-7.21.4 )
		dev-perl/CGI-Session
		dev-perl/Config-Grammar
		dev-perl/Digest-HMAC
		fcgi? ( dev-perl/FCGI )
		dev-perl/IO-Socket-SSL
		dev-perl/Net-DNS
		dev-perl/libwww-perl
		dig? ( net-dns/bind-tools )
		echoping? ( >=net-analyzer/echoping-6.0.2 )
		ipv6? ( >=dev-perl/Socket6-0.20 )
		ldap? ( dev-perl/perl-ldap )
		telnet? ( dev-perl/Net-Telnet )
		virtual/perl-libnet"

RDEPEND="${DEPEND}"

pkg_setup() {
	enewgroup smokeping
	enewuser smokeping -1 -1 /var/lib/smokeping smokeping
}

src_prepare() {
	rm -r lib/{BER.pm,SNMP_Session.pm,SNMP_util.pm} # dev-perl/SNMP_Session
	epatch "${FILESDIR}/smokeping_fping-3.3.patch"

}

src_configure() {
	econf \
	--sysconfdir=/etc/smokeping \
	--with-htdocs-dir=/var/www/localhost/smokeping
}

src_compile() {
	emake
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	newinitd "${FILESDIR}/${PN}.init.3" ${PN} || die

	mv "${D}/etc/smokeping/basepage.html.dist" "${D}/etc/smokeping/basepage.html"
	mv "${D}/etc/smokeping/config.dist" "${D}/etc/smokeping/config"
	mv "${D}/etc/smokeping/smokemail.dist" "${D}/etc/smokeping/smokemail"
	mv "${D}/etc/smokeping/smokeping_secrets.dist" "${D}/etc/smokeping/smokeping_secrets"
	mv "${D}/etc/smokeping/tmail.dist" "${D}/etc/smokeping/tmail"

	sed -e '/^imgcache/{s:\(^imgcache[ \t]*=\).*:\1 /var/lib/smokeping/.simg:}' \
		-e '/^imgurl/{s:\(^imgurl[ \t]*=\).*:\1 ../.simg:}' \
		-e '/^datadir/{s:\(^datadir[ \t]*=\).*:\1 /var/lib/smokeping:}' \
		-e '/^piddir/{s:\(^piddir[ \t]*=\).*:\1 /var/run/smokeping:}' \
	    -e '/^cgiurl/{s#\(^cgiurl[ \t]*=\).*#\1 http://some.place.xyz/perl/smokeping.pl#}' \
		-e '/^smokemail/{s:\(^smokemail[ \t]*=\).*:\1 /etc/smokeping/smokemail:}' \
		-e '/^tmail/{s:\(^tmail[ \t]*=\).*:\1 /etc/smokeping/tmail:}' \
		-e '/^secrets/{s:\(^secrets[ \t]*=\).*:\1 /etc/smokeping/smokeping_secrets:}' \
		-e '/^template/{s:\(^template[ \t]*=\).*:\1 /etc/smokeping/basepage.html:}' \
		-i "${D}/etc/${PN}/config" || die

	sed -e '/^<script/{s:cropper/:/cropper/:}' -i "${D}/etc/${PN}/basepage.html"

	sed -e 's/$FindBin::Bin\/..\/etc\/config/\/etc\/smokeping\/config/g' \
		-i "${D}/usr/bin/smokeping" -i "${D}/usr/bin/smokeping_cgi"

	sed -e 's:etc/config.dist:/etc/smokeping/config:' -i "${D}/usr/bin/tSmoke"

	sed -e 's:/usr/etc/config:/etc/smokeping/config:' -i \
		"${D}/var/www/localhost/smokeping/smokeping.fcgi.dist"

	dodir /var/www/localhost/cgi-bin
		mv "${D}/var/www/localhost/smokeping/smokeping.fcgi.dist" \
		"${D}/var/www/localhost/cgi-bin/smokeping.fcgi"

	fperms 700 /etc/${PN}/smokeping_secrets

	if use apache2 ; then
		insinto /etc/apache2/modules.d
		doins "${FILESDIR}/79_${PN}.conf" || die
	fi

	dodir /var/cache/smokeping
	keepdir /var/cache/smokeping

	# Create the files in /var for rrd file storage
	keepdir /var/lib/${PN}/.simg
	fowners smokeping:smokeping /var/lib/${PN}

	if use apache2 ; then
		fowners apache:apache /var/lib/${PN}/.simg
		fowners -R apache:apache /var/www
	else
		fowners smokeping:smokeping /var/lib/${PN}/.simg
	fi

	fperms 775 /var/lib/${PN} /var/lib/${PN}/.simg
}

pkg_postinst() {
	chown smokeping:smokeping "${ROOT}/var/lib/${PN}"
	chmod 755 "${ROOT}/var/lib/${PN}"
	elog
	elog "Additional steps are needed to get ${PN} up & running:"
	elog
	elog "First you need to edit /etc/${PN}/config. After that"
	elog "you can start ${PN} with '/etc/init.d/${PN} start'."
	elog
	if use apache2 ; then
		elog "For web interface make sure to add -D PERL to APACHE2_OPTS in"
		elog "/etc/conf.d/apache2 and to restart apache2. To access site from"
		elog "other places check permissions at /etc/apache2/modules.d/79_${PN}.conf"
		elog
	else
		elog "For web interface configure your web server to serve perl cgi"
		elog "script at /var/www/localhost/perl/"
	fi
	elog "To make cropper working you just need to copy /var/www/localhost/smokeping/cropper"
	elog "into you htdocs (or create symlink and allow webserver to follow symlinks)."
	elog
	elog "We install all files required for smoketrace, but you have to"
	elog "configure it manually. Just read 'man smoketrace'. Also you need to"
	elog "'emerge traceroute'."
	elog
}