# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/openoffice-bin/openoffice-bin-3.4.1.ebuild,v 1.3 2012/09/19 09:52:57 johu Exp $

EAPI="4"

inherit eutils fdo-mime gnome2-utils pax-utils prefix rpm multilib

IUSE="gnome java"

BUILDID="9593"
BUILDID2="9593"
MST="OOO330_m20"
MY_PV="${PV}rc10"
MY_PV2="${MY_PV}_20110118"
BVER="${PV/_rc*/}-${BUILDID}"
BVER2="3.4-${BUILDID2}"
BASIS="ooobasis3.4"
BASIS2="basis3.4"
NM="openoffice"
NM1="${NM}.org"
NM2="${NM1}3"
NM3="${NM2}.4"
FILEPATH="mirror://sourceforge/openofficeorg.mirror/localized"
if [ "${ARCH}" = "amd64" ] ; then
	XARCH="x86_64"
else
	XARCH="i586"
fi
UP="en-US/RPMS"

DESCRIPTION="Apache OpenOffice productivity suite."
HOMEPAGE="http://www.openoffice.org/"
SRC_URI="amd64? ( mirror://sourceforge/openofficeorg.mirror/stable/${PV}/Apache_OpenOffice_incubating_${PV}_Linux_x86-64_install-rpm_en-US.tar.gz )
	x86? ( mirror://sourceforge/openofficeorg.mirror/stable/${PV}/Apache_OpenOffice_incubating_${PV}_Linux_x86_install-rpm_en-US.tar.gz )"

LANGS="ar zh_CN zh_TW cs nl en_GB fi fr gl de hu it ja km pt_BR ru sk sl es"

for X in ${LANGS} ; do
	[[ ${X} != "en" ]] && SRC_URI="${SRC_URI} linguas_${X}? (
		amd64? ( "${FILEPATH}"/${X/_/-}/${PV}/Apache_OpenOffice_incubating_${PV}_Linux_x86-64_langpack-rpm_${X/_/-}.tar.gz )
		x86? ( "${FILEPATH}"/${X/_/-}/${PV}/Apache_OpenOffice_incubating_${PV}_Linux_x86_langpack-rpm_${X/_/-}.tar.gz ) )"
	IUSE="${IUSE} linguas_${X}"
done

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"

RDEPEND="
	!app-office/openoffice
	!prefix? ( sys-libs/glibc )
	app-arch/unzip
	app-arch/zip
	>=dev-lang/perl-5.0
	>=media-libs/freetype-2.1.10-r2
	x11-libs/libXaw
	x11-libs/libXinerama"

DEPEND="${RDEPEND}
	sys-apps/findutils"

PDEPEND="java? ( >=virtual/jre-1.5 )"

RESTRICT="strip"

QA_PREBUILT="usr/$(get_libdir)/${NM}/${BASIS2}/program/*
	usr/$(get_libdir)/${NM}/program/*
	usr/$(get_libdir)/${NM}/ure/bin/*
	usr/$(get_libdir)/${NM}/ure/lib/*
	usr/$(get_libdir)/${NM}/share/prereg/bundled/*/*"
QA_TEXTRELS="usr/$(get_libdir)/${NM}/${BASIS2}/program/libvclplug_genli.so \
	usr/$(get_libdir)/${NM}/${BASIS2}/program/python-core-2.6.1/lib/lib-dynload/_curses_panel.so \
	usr/$(get_libdir)/${NM}/${BASIS2}/program/python-core-2.6.1/lib/lib-dynload/_curses.so \
	usr/$(get_libdir)/${NM}/ure/lib/*"

S=${WORKDIR}

src_unpack() {

	unpack ${A}

	cp "${FILESDIR}"/{50-${PN},wrapper.in} "${T}"
	eprefixify "${T}"/{50-${PN},wrapper.in}

	for i in base binfilter calc core01 core02 core03 core04 core05 core06 core07 draw graphicfilter images impress math ogltrans ooofonts ooolinguistic pyuno testtool writer xsltfilter ; do
		rpm_unpack "./${UP}/${BASIS}-${i}-${BVER}.${XARCH}.rpm"
	done

	rpm_unpack "./${UP}/${NM2}-${BVER}.${XARCH}.rpm"
	rpm_unpack "./${UP}/${NM1}-ure-${BVER}.${XARCH}.rpm"

	for j in base calc draw impress math writer; do
		rpm_unpack "./${UP}/${NM2}-${j}-${BVER}.${XARCH}.rpm"
	done

	rpm_unpack "./${UP}/desktop-integration/${NM3}-freedesktop-menus-${BVER2}.noarch.rpm"

	use gnome && rpm_unpack "./${UP}/${BASIS}-gnome-integration-${BVER}.${XARCH}.rpm"
	use java && rpm_unpack "./${UP}/${BASIS}-javafilter-${BVER}.${XARCH}.rpm"

	# English support installed by default
	rpm_unpack "./${UP}/${BASIS}-en-US-${BVER}.${XARCH}.rpm"
	rpm_unpack "./${UP}/${NM2}-en-US-${BVER}.${XARCH}.rpm"
	for s in base binfilter calc draw help impress math res writer ; do
		rpm_unpack "./${UP}/${BASIS}-en-US-${s}-${BVER}.${XARCH}.rpm"
	done

	# Localization
	strip-linguas ${LANGS}
	for l in ${LINGUAS}; do
		m="${l/_/-}"
		if [[ ${m} != "en" ]] ; then
			LANGDIR="${m}/RPMS/"
			rpm_unpack "./${LANGDIR}/${BASIS}-${m}-${BVER}.${XARCH}.rpm"
			rpm_unpack "./${LANGDIR}/${NM2}-${m}-${BVER}.${XARCH}.rpm"
			for n in base binfilter calc draw help impress math res writer; do
				rpm_unpack "./${LANGDIR}/${BASIS}-${m}-${n}-${BVER}.${XARCH}.rpm"
			done

		fi
	done

}

src_install () {

	INSTDIR="/usr/$(get_libdir)/${NM}"
	dodir ${INSTDIR}
	mv "${WORKDIR}"/opt/${NM1}/* "${ED}${INSTDIR}" || die
	mv "${WORKDIR}"/opt/${NM2}/* "${ED}${INSTDIR}" || die

	#Menu entries, icons and mime-types
	cd "${ED}${INSTDIR}/share/xdg/"
	for desk in base calc draw impress javafilter math printeradmin qstart startcenter writer; do
		if [ "${desk}" = "javafilter" ] ; then
			use java || { rm javafilter.desktop; continue; }
		fi
		mv ${desk}.desktop ${NM1}-${desk}.desktop
		sed -i -e s/${NM2}/ooffice/g ${NM1}-${desk}.desktop || die
		domenu ${NM1}-${desk}.desktop
	done
	insinto /usr/share
	doins -r "${WORKDIR}"/usr/share/icons
	doins -r "${WORKDIR}"/usr/share/mime

	# Make sure the permissions are right
	use prefix || fowners -R root:0 /

	# Install wrapper script
	newbin "${T}/wrapper.in" ooffice
	sed -i -e s/LIBDIR/$(get_libdir)/g "${ED}/usr/bin/ooffice" || die

	# Component symlinks
	for app in base calc draw impress math writer; do
		dosym ${INSTDIR}/program/s${app} /usr/bin/oo${app}
	done

	dosym ${INSTDIR}/program/spadmin /usr/bin/ooffice-printeradmin
	dosym ${INSTDIR}/program/soffice /usr/bin/soffice

	rm -f "${ED}${INSTDIR}/basis-link" || die
	dosym ${INSTDIR}/${BASIS2} ${INSTDIR}/basis-link

	# Change user install dir
	sed -i -e "s/.${NM1}\/3/.ooo3/g" "${ED}${INSTDIR}/program/bootstraprc" || die

	# Non-java weirdness see bug #99366
	use !java && rm -f "${ED}${INSTDIR}/ure/bin/javaldx"

	# prevent revdep-rebuild from attempting to rebuild all the time
	insinto /etc/revdep-rebuild && doins "${T}/50-${PN}"

	# remove soffice bin
	rm -rf "${ED}${EPREFIX}/usr/bin/soffice"

	# replace all symlinks by bash shell code in order to nicely cope with
	# libreoffice
	cd "${ED}${EPREFIX}/usr/bin/"
	for i in oo*; do
		[[ ${i} == ooffice ]] && continue

		rm ${i}
		cat >> ${i} << EOF
#!/usr/bin/env bash
pushd "${EPREFIX}/usr/$(get_libdir)/openoffice/program" > /dev/null
./${i/oo/s}
popd > /dev/null
EOF
		chmod +x ${i}
	done
}

pkg_preinst() {

	use gnome && gnome2_icon_savelist

}

pkg_postinst() {

	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	use gnome && gnome2_icon_cache_update

	pax-mark -m "${EPREFIX}"/usr/$(get_libdir)/${NM}/program/soffice.bin

}

pkg_postrm() {

	fdo-mime_desktop_database_update
	use gnome && gnome2_icon_cache_update

}
