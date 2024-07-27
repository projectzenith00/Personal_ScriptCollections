# jul/27/2024 05:11:24 by RouterOS 6.48.6
# software id = QCDL-K0L6
#
# model = RB941-2nD
# serial number = HCV085W8SDB
#
# RouterOS Configuration Details
#
# 1. Multiple Virtual Wireless AP under wlan1 interface 
# 2. Bridged wlan1-Work with ethernet port 2-4
# 3. Added Simple Queues
# 4. MAC Address Whitelisting
# 5. Winbox access limited to bridge1 and wlan1-Admin interface
#
#
/interface bridge
add name=bridge1
/interface wireless
set [ find default-name=wlan1 ] disabled=no hide-ssid=yes mode=ap-bridge \
    ssid=wlan-MikroTik wireless-protocol=802.11
/interface list
add name=WAN
add name=LAN
/interface wireless security-profiles
set [ find default=yes ] supplicant-identity=MikroTik
add authentication-types=wpa-psk,wpa2-psk,wpa-eap,wpa2-eap mode=dynamic-keys \
    name="Work Devices WiFi - Security Keys" supplicant-identity="" \
    wpa-pre-shared-key=abc123*** wpa2-pre-shared-key=abc123***
add authentication-types=wpa-psk,wpa2-psk,wpa-eap,wpa2-eap mode=dynamic-keys \
    name="Entertainment Devices WiFi - Security Keys" supplicant-identity="" \
    wpa-pre-shared-key=abc123*** wpa2-pre-shared-key=abc123***
add authentication-types=wpa-psk,wpa2-psk,wpa-eap,wpa2-eap name=\
    "Adults WiFi - Security Keys" supplicant-identity="" wpa-pre-shared-key=\
    abc123*** wpa2-pre-shared-key=abc123***
add authentication-types=wpa-psk,wpa2-psk,wpa-eap,wpa2-eap mode=dynamic-keys \
    name="Kids WiFi - Security Keys" supplicant-identity="" \
    wpa-pre-shared-key=abc123*** wpa2-pre-shared-key=abc123***
add authentication-types=wpa-psk,wpa2-psk,wpa-eap,wpa2-eap mode=dynamic-keys \
    name="Guest WiFi - Security Keys" supplicant-identity="" \
    wpa-pre-shared-key=abc123*** wpa2-pre-shared-key=abc123***
add authentication-types=wpa-psk,wpa2-psk,wpa-eap,wpa2-eap mode=dynamic-keys \
    name="MTK - Security Keys" supplicant-identity="" wpa-pre-shared-key=\
    03553knt** wpa2-pre-shared-key=03553knt**
/interface wireless
add default-authentication=no disabled=no mac-address=1A:FD:74:5E:9C:A4 \
    master-interface=wlan1 name=wlan1-Admin security-profile=\
    "Adults WiFi - Security Keys" ssid=MTK-Admin wds-cost-range=0 \
    wds-default-cost=0
add default-authentication=no disabled=no mac-address=1A:FD:74:5E:9C:A1 \
    master-interface=wlan1 name=wlan1-Adults security-profile=\
    "Adults WiFi - Security Keys" ssid="Bugwakan Kalayo pag mu connect"
add default-authentication=no disabled=no mac-address=1A:FD:74:5E:9C:A0 \
    master-interface=wlan1 name=wlan1-Entertainment security-profile=\
    "Entertainment Devices WiFi - Security Keys" ssid="T-vee WiFi"
add disabled=no mac-address=1A:FD:74:5E:9C:A3 master-interface=wlan1 name=\
    wlan1-Guest security-profile="Guest WiFi - Security Keys" ssid=WayPay
add default-authentication=no disabled=no mac-address=1A:FD:74:5E:9C:A2 \
    master-interface=wlan1 name=wlan1-Kids security-profile=\
    "Kids WiFi - Security Keys" ssid=Gremlins
add default-authentication=no disabled=no mac-address=1A:FD:74:5E:9C:9F \
    master-interface=wlan1 name=wlan1-Work security-profile=\
    "Work Devices WiFi - Security Keys" ssid="Free Bayros"
/ip kid-control
add name=Lemon rate-limit=2M
/ip pool
add name=dhcp_pool1 ranges=10.10.10.10-10.10.10.254
add name=dhcp_pool2 ranges=10.10.20.10-10.10.20.254
add name=dhcp_pool3 ranges=10.10.30.10-10.10.30.254
add name=dhcp_pool4 ranges=10.10.40.10-10.10.40.254
add name=dhcp_pool5 ranges=10.10.50.10-10.10.50.254
add name=dhcp_pool7 ranges=10.10.70.10-10.10.70.100
/ip dhcp-server
add address-pool=dhcp_pool1 disabled=no interface=bridge1 name=dhcp1
add address-pool=dhcp_pool2 disabled=no interface=wlan1-Entertainment name=\
    dhcp2
add address-pool=dhcp_pool3 disabled=no interface=wlan1-Adults name=dhcp3
add address-pool=dhcp_pool4 disabled=no interface=wlan1-Kids name=dhcp4
add address-pool=dhcp_pool5 disabled=no interface=wlan1-Guest name=dhcp5
add address-pool=dhcp_pool7 disabled=no interface=wlan1-Admin name=dhcp7
/queue simple
add name="Work - Bandwidth Control" priority=1/1 target=bridge1
add max-limit=10M/10M name="TV - Bandwidth Control" priority=3/3 target=\
    wlan1-Entertainment
add max-limit=10M/10M name="Adults - Bandwidth Control" priority=2/2 target=\
    wlan1-Adults
add limit-at=1M/1M max-limit=2M/2M name="Kids - Bandwidth Control" priority=\
    4/4 target=wlan1-Kids time=0s-20h,sun,mon,tue,wed,thu,fri,sat
add limit-at=4M/4M max-limit=5M/5M name="Guests - Bandwidth Control" target=\
    wlan1-Guest
add limit-at=64k/64k max-limit=64k/64k name=\
    "Kids Bedtime - Bandwidth Control" priority=7/7 target=wlan1-Kids time=\
    21h-23h,sun,mon,tue,wed,thu,fri,sat
/interface bridge port
add bridge=bridge1 interface=ether2
add bridge=bridge1 interface=ether3
add bridge=bridge1 interface=ether4
add bridge=bridge1 interface=wlan1-Work
/interface list member
add interface=ether1 list=WAN
add list=LAN
/interface wireless access-list
add comment=KNT-Laptop interface=wlan1-Work mac-address=3C:A0:67:E5:B4:41 \
    vlan-mode=no-tag
add comment=KNT-Mobile interface=wlan1-Adults mac-address=8C:7A:3D:3E:5E:87 \
    vlan-mode=no-tag
add comment=KNT-Mobile interface=wlan1-Admin mac-address=8C:7A:3D:3E:5E:87 \
    vlan-mode=no-tag
/ip address
add address=10.10.10.1/24 interface=bridge1 network=10.10.10.0
add address=10.10.20.1/24 interface=wlan1-Entertainment network=10.10.20.0
add address=10.10.30.1/24 interface=wlan1-Adults network=10.10.30.0
add address=10.10.40.1/24 interface=wlan1-Kids network=10.10.40.0
add address=10.10.50.1/24 interface=wlan1-Guest network=10.10.50.0
add address=10.10.70.1/24 interface=wlan1-Admin network=10.10.70.0
/ip dhcp-client
add disabled=no interface=ether1
/ip dhcp-server network
add address=10.10.10.0/24 gateway=10.10.10.1
add address=10.10.20.0/24 gateway=10.10.20.1
add address=10.10.30.0/24 gateway=10.10.30.1
add address=10.10.40.0/24 gateway=10.10.40.1
add address=10.10.50.0/24 gateway=10.10.50.1
add address=10.10.70.0/24 gateway=10.10.70.1
/ip firewall filter
add action=accept chain=input dst-port=8291 in-interface=wlan1-Admin \
    protocol=tcp
add action=accept chain=input dst-port=8291 in-interface=bridge1 protocol=tcp
add action=drop chain=input dst-port=8291 in-interface=!wlan1-Admin protocol=\
    tcp
add action=drop chain=input dst-port=8291 in-interface=all-ppp protocol=tcp
/ip firewall nat
add action=masquerade chain=srcnat out-interface-list=WAN
/system clock
set time-zone-autodetect=no time-zone-name=Asia/Manila
/system clock manual
set time-zone=+08:00
/system identity
set name=RouterOS
