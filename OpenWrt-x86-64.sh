  
#!/bin/bash
#=================================================

# 定制默认IP
sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate

# 添加第三方软件包
git clone https://github.com/KFERMercer/luci-app-serverchan package/luci-app-serverchan
git clone https://github.com/rufengsuixing/luci-app-adguardhome package/luci-app-adguardhome
git clone https://github.com/kang-mk/luci-app-smartinfo package/luci-app-smartinfo




#创建自定义配置文件 - OpenWrt-x86-64

rm -f ./.config*
touch ./.config

#
# ========================固件定制部分========================
# 

# 
# 如果不对本区块做出任何编辑, 则生成默认配置固件. 
# 

# 以下为定制化固件选项和说明:
#

#
# 有些插件/选项是默认开启的, 如果想要关闭, 请参照以下示例进行编写:
# 
#          =========================================
#         |  # 取消编译VMware镜像:                   |
#         |  cat >> .config <<EOF                   |
#         |  # CONFIG_VMDK_IMAGES is not set        |
#         |  EOF                                    |
#          =========================================
#

# 
# 以下是一些提前准备好的一些插件选项.
# 直接取消注释相应代码块即可应用. 不要取消注释代码块上的汉字说明.
# 如果不需要代码块里的某一项配置, 只需要删除相应行.
#
# 如果需要其他插件, 请按照示例自行添加.
# 注意, 只需添加依赖链顶端的包. 如果你需要插件 A, 同时 A 依赖 B, 即只需要添加 A.
# 
# 无论你想要对固件进行怎样的定制, 都需要且只需要修改 EOF 回环内的内容.
# 

# 编译x64固件:
cat >> .config <<EOF
CONFIG_TARGET_x86=y
CONFIG_TARGET_x86_64=y
CONFIG_TARGET_x86_64_Generic=y
EOF

# 设置固件大小:
cat >> .config <<EOF
CONFIG_TARGET_KERNEL_PARTSIZE=16
CONFIG_TARGET_ROOTFS_PARTSIZE=160
EOF

# 固件压缩:
cat >> .config <<EOF
CONFIG_TARGET_IMAGES_GZIP=y
EOF

# 编译UEFI固件:
# cat >> .config <<EOF
# CONFIG_EFI_IMAGES=y
# EOF

# IPv6支持:
cat >> .config <<EOF
CONFIG_PACKAGE_ipv6helper=y
CONFIG_PACKAGE_dnsmasq_full_dhcpv6=y
EOF

# 多文件系统支持:
# cat >> .config <<EOF
# CONFIG_PACKAGE_kmod-fs-nfs=y
# CONFIG_PACKAGE_kmod-fs-nfs-common=y
# CONFIG_PACKAGE_kmod-fs-nfs-v3=y
# CONFIG_PACKAGE_kmod-fs-nfs-v4=y
# CONFIG_PACKAGE_kmod-fs-ntfs=y
# CONFIG_PACKAGE_kmod-fs-squashfs=y
# EOF

# USB3.0支持:
# cat >> .config <<EOF
# CONFIG_PACKAGE_kmod-usb-ohci=y
# CONFIG_PACKAGE_kmod-usb-ohci-pci=y
# CONFIG_PACKAGE_kmod-usb2=y
# CONFIG_PACKAGE_kmod-usb2-pci=y
# CONFIG_PACKAGE_kmod-usb3=y
# EOF

# 第三方插件选择:
cat >> .config <<EOF
CONFIG_PACKAGE_luci-app-serverchan=y #微信推送
# CONFIG_PACKAGE_luci-app-adguardhome=y
# CONFIG_PACKAGE_luci-app-smartinfo=y
EOF

# CONFIG_PACKAGE_luci-app-pppoe-relay is not set #PPPoE 穿透
# CONFIG_PACKAGE_luci-app-pppoe-server is not set #PPPoE 服务器
# CONFIG_PACKAGE_luci-app-trojan-server is not set #Trojan 服务器
# CONFIG_PACKAGE_luci-app-v2ray-server is not set #V2ray 服务器
# CONFIG_PACKAGE_pptpd is not set #PPTP VPN 服务器
CONFIG_PACKAGE_luci-app-nlbwmon=y #宽带流量监控
CONFIG_PACKAGE_luci-app-wrtbwmon=y #实时流量监测
CONFIG_PACKAGE_luci-app-webadmin=y #Web 管理页面设置
CONFIG_PACKAGE_luci-app-filetransfer=y #系统-文件传输
CONFIG_PACKAGE_luci-app-unblockmusic=y #解锁网易云灰色歌曲
CONFIG_PACKAGE_luci-app-frpc=y #Frp内网穿透
CONFIG_PACKAGE_luci-app-upnp=y #通用即插即用（UPnP）
CONFIG_PACKAGE_luci-app-softethervpn=y #SoftEther VPN 服务器
EOF

# 常用LuCI插件选择:
cat >> .config <<EOF
# CONFIG_PACKAGE_luci-app-fileassistant is not set #文件助手
# CONFIG_PACKAGE_luci-app-vsftpd is not set #FTP 服务器
# CONFIG_PACKAGE_luci-app-samba is not set #网络共享
EOF

# LuCI主题:
cat >> .config <<EOF
# CONFIG_PACKAGE_luci-theme-darkmatter is not set
# CONFIG_PACKAGE_luci-theme-bootstrap-mod is not set
CONFIG_PACKAGE_luci-theme-netgear-mc=y
CONFIG_PACKAGE_luci-theme-argon-mod=y
EOF

# 常用软件包:
cat >> .config <<EOF
CONFIG_PACKAGE_curl=y
CONFIG_PACKAGE_htop=y
CONFIG_PACKAGE_nano=y
# CONFIG_PACKAGE_screen=y
# CONFIG_PACKAGE_tree=y
# CONFIG_PACKAGE_vim-fuller=y
CONFIG_PACKAGE_wget=y
EOF

# 
# ========================固件定制部分结束========================
# 


sed -i 's/^[ \t]*//g' ./.config

# 配置文件创建完成
