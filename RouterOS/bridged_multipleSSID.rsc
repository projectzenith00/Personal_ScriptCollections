# // **************************************************** //
# 
# RouterOS script for multiple virtual SSID. 
# 
# Details:
# 
# Ethernet port 1 is the ISP connection port
# Ethernet ports 2, 3, 4 and virtual AP ("wlan1-Work") are on the same bridge
# 5 Virtual Access Points under WLAN1 interface: "Work Devices WiFi", "Entertainment Devices WiFi", "Guest WiFi", "Mobile 1 WiFi", "Mobile 2 WiFi"
# 
# // **************************************************** //
# 
# 
# 
# jul/22/2024 03:58:12 by RouterOS 6.48.6
# software id = QCDL-K0L6
#
# model = RB941-2nD
# serial number = HCV085W8SDB
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
add authentication-types=wpa-psk,wpa2-psk,wpa-eap,wpa2-eap mode=dynamic-keys \
    name="Mobile 1 WiFi - Security Keys" supplicant-identity="" \
    wpa-pre-shared-key=abc123*** wpa2-pre-shared-key=abc123***
add authentication-types=wpa-psk,wpa2-psk,wpa-eap,wpa2-eap mode=dynamic-keys \
    name="Mobile 2 WiFi - Security Keys" supplicant-identity="" \
    wpa-pre-shared-key=abc123*** wpa2-pre-shared-key=abc123***
add authentication-types=wpa-psk,wpa2-psk,wpa-eap,wpa2-eap mode=dynamic-keys \
    name="Guest WiFi - Security Keys" supplicant-identity="" \
    wpa-pre-shared-key=abc123*** wpa2-pre-shared-key=abc123***
/interface wireless
add disabled=no mac-address=1A:FD:74:5E:9C:A0 master-interface=wlan1 name=\
    wlan1-Entertainment security-profile=\
    "Entertainment Devices WiFi - Security Keys" ssid=\
    "Entertainment Devices WiFi"
add disabled=no mac-address=1A:FD:74:5E:9C:A3 master-interface=wlan1 name=\
    wlan1-Guest security-profile="Guest WiFi - Security Keys" ssid=\
    "Guest WiFi"
add disabled=no mac-address=1A:FD:74:5E:9C:A1 master-interface=wlan1 name=\
    wlan1-Mobile1 security-profile="Mobile 1 WiFi - Security Keys" ssid=\
    "Mobile 1 WiFi"
add disabled=no mac-address=1A:FD:74:5E:9C:A2 master-interface=wlan1 name=\
    wlan1-Mobile2 security-profile="Mobile 2 WiFi - Security Keys" ssid=\
    "Mobile 2 WiFi"
add disabled=no mac-address=1A:FD:74:5E:9C:9F master-interface=wlan1 name=\
    wlan1-Work security-profile="Work Devices WiFi - Security Keys" ssid=\
    "Work Devices WiFi"
/ip pool
add name=dhcp_pool1 ranges=10.10.10.10-10.10.10.254
add name=dhcp_pool2 ranges=10.10.20.10-10.10.20.254
add name=dhcp_pool3 ranges=10.10.30.10-10.10.30.254
add name=dhcp_pool4 ranges=10.10.40.10-10.10.40.254
add name=dhcp_pool5 ranges=10.10.50.10-10.10.50.254
/ip dhcp-server
# DHCP server can not run on slave interface!
add address-pool=dhcp_pool1 disabled=no interface=wlan1-Work name=dhcp1
add address-pool=dhcp_pool2 disabled=no interface=wlan1-Entertainment name=\
    dhcp2
add address-pool=dhcp_pool3 disabled=no interface=wlan1-Mobile1 name=dhcp3
add address-pool=dhcp_pool4 disabled=no interface=wlan1-Mobile2 name=dhcp4
add address-pool=dhcp_pool5 disabled=no interface=wlan1-Guest name=dhcp5
/interface bridge port
add bridge=bridge1 interface=ether2
add bridge=bridge1 interface=ether3
add bridge=bridge1 interface=ether4
add bridge=bridge1 interface=wlan1-Work
/interface list member
add interface=ether1 list=WAN
add list=LAN
/ip address
add address=10.10.20.1/24 interface=ether2 network=10.10.20.0
add address=10.10.10.1/24 interface=bridge1 network=10.10.10.0
add address=10.10.20.1/24 interface=wlan1-Entertainment network=10.10.20.0
add address=10.10.30.1/24 interface=wlan1-Mobile1 network=10.10.30.0
add address=10.10.40.1/24 interface=wlan1-Mobile2 network=10.10.40.0
add address=10.10.50.1/24 interface=wlan1-Guest network=10.10.50.0
/ip dhcp-client
add disabled=no interface=ether1
/ip dhcp-server network
add address=10.10.10.0/24 gateway=10.10.10.1
add address=10.10.20.0/24 gateway=10.10.20.1
add address=10.10.30.0/24 gateway=10.10.30.1
add address=10.10.40.0/24 gateway=10.10.40.1
add address=10.10.50.0/24 gateway=10.10.50.1
/ip firewall nat
add action=masquerade chain=srcnat out-interface-list=WAN
/system clock
set time-zone-name=Asia/Manila
/system identity
set name=RouterOS
