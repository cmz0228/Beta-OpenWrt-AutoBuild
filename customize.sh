
  
#!/bin/bash
#=================================================
# Description: DIY script
# Lisence: MIT
# Author: P3TERX
# Blog: https://p3terx.com
#=================================================

# 定制默认IP
# sed -i 's/192.168.1.1/12.0.0.1/g' openwrt/package/base-files/files/bin/config_generate

# 增加LEAN源码软件包
cd package
git init
git remote add -f origin https://github.com/coolsnowwolf/lede.git
git config core.sparsecheckout true
echo package/lean >> .git/info/sparse-checkout
git pull origin master
mv package/*/ ./
rm -Rf ./.git
cd -

# 替换默认Argon主题
# rm -rf package/lean/luci-theme-argon
# git clone https://github.com/jerrykuku/luci-theme-argon package/luci-theme-argon

# 添加第三方软件包
git clone https://github.com/KFERMercer/luci-app-serverchan package/luci-app-serverchan
# git clone https://github.com/rufengsuixing/luci-app-adguardhome package/luci-app-adguardhome
# git clone https://github.com/kang-mk/luci-app-smartinfo package/luci-app-smartinfo
