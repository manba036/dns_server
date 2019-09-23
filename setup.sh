#!/bin/sh

echo "########################################"
echo "# dnsmasqをインストール"
echo "########################################"
sudo apt-get install -y dnsmasq
echo ""

echo "########################################"
echo "# dnsmasq設定ファイルをコピー"
echo "########################################"
sudo mkdir -p /etc/dnsmasq.d
sudo cp dnsmasq.conf /etc/
sudo cp dnsmasq.conf /etc/dnsmasq.d/
echo ""

echo "########################################"
echo "# systemd-resolvedを停止"
echo "########################################"
sudo systemctl disable systemd-resolved
sudo systemctl stop systemd-resolved
echo ""

echo "########################################"
echo "# NetworkManager.confを変更"
echo "########################################"
check=`cat /etc/NetworkManager/NetworkManager.conf | grep "dns=none"`
if [ -z "$check" ]; then
  cat /etc/NetworkManager/NetworkManager.conf | sed -e 's/\[main\]/[main]\ndns=none/' | sudo tee /etc/NetworkManager/NetworkManager.conf
fi

echo "########################################"
echo "# dnsmasqを再起動"
echo "########################################"
sudo systemctl restart NetworkManager
echo ""

echo "########################################"
echo "# resolv.confを変更"
echo "########################################"
check=`ls -lah /etc/resolv.conf | grep -E '^l'`
echo $check
if [ -n "$check" ]; then
  sudo unlink /etc/resolv.conf
else
  sudo rm -f /etc/resolv.conf
fi
echo 'nameserver 127.0.0.1' | sudo tee /etc/resolv.conf
echo ""

echo "########################################"
echo "# dnsmasqを再起動"
echo "########################################"
sudo systemctl restart dnsmasq
echo ""

echo "########################################"
echo "# DNSをチェック"
echo "########################################"
nmcli d sh | grep DNS
echo ""

echo "########################################"
echo "# セットアップ完了"
echo "########################################"
