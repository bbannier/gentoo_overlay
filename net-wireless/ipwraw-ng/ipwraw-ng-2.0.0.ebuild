inherit linux-mod

DESCRIPTION="A packet injection driver for the Intel PRO/Wireless 3945ABG miniPCI express adapter"

SRC_URI="http://homepages.tu-darmstadt.de/~p_larbig/wlan/${PN}-${PV}-10072007.tar.bz2"
S="${WORKDIR}/${PN}"

HOMEPAGE="http://homepages.tu-darmstadt.de/~p_larbig/wlan/"
IUSE=""
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="net-wireless/iwl3945-ucode"

MODULE_NAMES="ipwraw(kernel/drivers/net/wireless:)"
BUILD_TARGETS="default"


src_unpack() {
   unpack  ${A}
}

src_compile() {
cd   ${S}
local GENTOOARCH="${ARCH}"
unset ARCH
emake || die "emake failed"
ARCH="${GENTOOARCH}"
} 
	
src_install() {

linux-mod_src_install

into /usr

sed s/set_channel/ipwraw_set_channel/g set_channel > ipwraw_set_channel

sed s/set_power/ipwraw_set_power/g set_power > ipwraw_set_power

sed 1,10s/load/ipwraw_load/g load > ipwraw_load
echo "`sed "29i (lsmod| egrep -q -e ^ipw3945[[:space:]]+) && echo -n Unloading 'ipw3945'... && rmmod ipw3945 && echo done" ipwraw_load`" > ipwraw_load
echo "`sed "30i (lsmod| egrep -q -e ^iwl3945[[:space:]]+) && echo -n Unloading 'iwl3945'... && rmmod iwl3945 && echo done" ipwraw_load`" > ipwraw_load
echo "`sed 's/\.\/set_channel/ipwraw_set_channel/g' ipwraw_load`" > ipwraw_load

sed -e 's/ap-beacon/ipwraw_ap_beacon/g' -e 's/util\/wifi_tx/wifi_tx/g' ap-beacon util/wifi_tx > ipwraw_ap_beacon

echo '#!/bin/bash'> ipwraw_unload
echo "rmmod ipwraw 2>/dev/null && echo 'Unloading ipwraw...done'">> ipwraw_unload
echo "modprobe ipw3945 2>/dev/null && echo 'loading ipw3945...done'">> ipwraw_unload
echo "modprobe iwl3945 2>/dev/null && echo 'loading iwl3945...done'">> ipwraw_unload

dobin ipwraw_* util/wifi_tx

cat /etc/modprobe.d/blacklist |grep -v ipwraw> blacklist 
echo "blacklist ipwraw" >>blacklist

insinto /etc/modprobe.d
doins blacklist

}


pkg_postinst(){

/sbin/update-modules


elog "You will also need to update etc files"
elog "and run update-modules. You can do this like so:"
elog "	# etc-update && update-modules"
}
