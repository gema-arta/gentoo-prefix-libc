# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-devel/binutils-config/binutils-config-3-r3.ebuild,v 1.9 2012/07/29 18:36:13 armin76 Exp $

inherit eutils toolchain-funcs prefix

DESCRIPTION="Utility to change the binutils version being used"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc-aix ~x64-freebsd ~x86-freebsd ~hppa-hpux ~ia64-hpux ~x86-interix ~amd64-linux ~ia64-linux ~x86-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE=""

RDEPEND="userland_GNU? ( !<sys-apps/findutils-4.2 )"

S=${WORKDIR}

src_unpack() {
	cd "${S}"
	cp "${FILESDIR}"/${P} ./${PN} || die
	eprefixify ${PN} || die "eprefixify failed."
}

src_install() {
	dobin ${PN} || die "cannot install ${PN} script."
	doman "${FILESDIR}"/${PN}.8
}

pkg_postinst() {
	# refresh all links and the wrapper
	if [[ ${ROOT%/} == "" ]] ; then
		[[ -f ${EROOT}/etc/env.d/binutils/config-${CHOST} ]] \
			&& binutils-config $(${EROOT}/usr/bin/binutils-config --get-current-profile)
	fi
}
