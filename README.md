# dns_server

## 事前準備

### /etc/systemd/resolved.conf の DNSStubListener のコメントを外して"no"に変更

```text
DNSStubListener=no
```

### systemd-resolved を再起動

```bash
sudo systemctl restart systemd-resolved
```

## 使用方法

```bash
git clone https://github.com/manba036/dns_server.git
cd dns_server

./setup.sh
docker-compose up -d
```
