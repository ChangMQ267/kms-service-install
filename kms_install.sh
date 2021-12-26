#!/bin/sh
echo "----安装git、Python----"
yum install git python2
echo "----获取py-kms---"
git clone https://gitee.com/changmq267/py-kms.git
echo "--获取py-kms成功--"
echo "-----开始安装-----"

echo "----安装py-kms----"
sudo chmod +x -R py-kms/*.py
sudo mv py-kms /usr/local/py-kms

echo "----创建启动项----"
(
cat <<EOF
sudo python2 /usr/local/py-kms/server.py 
EOF
) > kms.sh
sudo chmod +x kms.sh
sudo mv -f kms.sh /usr/bin/kms.sh

echo "----创建服务----"
(
cat <<EOF
[Unit]
Description=KMS Service

[Service]
Type=simple
ExecStart=/usr/bin/sh /usr/bin/kms.sh

[Install]
WantedBy=multi-user.target
EOF
) > kms.service
sudo mv -f kms.service /etc/systemd/system/
sudo systemctl daemon-reload
echo "----安装完成----"
sudo systemctl restart kms.service
sudo systemctl enable kms.service
#end of script
