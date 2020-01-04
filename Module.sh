  
#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================

# 定制默认IP
sed -i 's/192.168.1.1/12.0.0.1/g' openwrt/package/base-files/files/bin/config_generate

# 替换默认Argon主题
rm -rf package/lean/luci-theme-argon
git clone https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon

# 添加第三方软件包
git clone https://github.com/KFERMercer/luci-app-serverchan package/luci-app-serverchan
git clone https://github.com/rufengsuixing/luci-app-adguardhome package/luci-app-adguardhome
git clone https://github.com/kang-mk/luci-app-smartinfo package/luci-app-smartinfo

# 添加Lienol软件包
git clone https://github.com/Lienol/openwrt-package package/Lienol

# 删除shadowsocksr puls+
rm -rf package/lean/luci-app-ssr-plus	
rm -rf package/lean/luci-app-ssrserver-python
rm -rf package/lean/luci-app-v2ray-server
rm -rf package/lean/luci-app-verysync
rm -rf package/lean/shadowsocksr-libev
rm -rf package/lean/v2ray
