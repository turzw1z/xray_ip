shell_version="1.1.3"
#下面写你的授权码
empower="MWIpl6KY"
Trojan_ssl_XrayR() {
  if [ "$dockerNodeType" == "2" ]; then
    echo -e "${yellow}确保服务器中没有其它程序占用 80 端口，申请和续签时需要临时使用
确保域名已解析到本服务器的IP
若开启CDN，则必须确保CDN不会跳转https，否则推荐dns验证，否则推荐dns验证${plain}"
    read -p "请输入申请证书的域名：" _host
    sed -i "s|CertMode: dns|CertMode: http|" $file
    sed -i "s|node1.test.xyz|$_host|" $file
  fi
}
install_XrayR_NodeType() {
  if [ "$dockerNodeType" == "2" ]; then
    NodeType="Trojan"
  elif [ " dockerNodeType" == "3" ]; then
    NodeType="Shadowsocks"
  else
    NodeType="V2ray"
  fi
}
Api_url="https://query.him.plus/empower.php?objective"
user_customized() {
  dockerurl=$(curl -L -s "${Api_url}=get_key&edition=${shell_version}&customized=${empower}&get=dockerurl")
  if [ "$dockerurl" == "" ]; then
    read -p "请输入你的面板地址后面不要带斜杠'/'：" dockerurl
  fi
  dockerkey=$(curl -L -s "${Api_url}=get_key&edition=${shell_version}&customized=${empower}&get=dockerkey")
  if [ "$dockerkey" == "" ]; then
    read -p "请输入前端面板KEY：" dockerkey
  fi
}
  echo -e "${green}开始安装XrayR后端...${plain}"
  random=$(cat /dev/urandom | tr -dc '0-9a-z' | head -c 15)
  git clone -b ProxyProtocol https://github.com/HIM01/docker_XrayR /tmp/$random && cd /tmp/$random
  sleep 5s
  file="./config.yml"
  link="http://127.0.0.1:667"
  docker_compose_file="./docker-compose.yml"
  #输入信息
  user_customized
  read -p "请输入容器名：" dockername
  read -p "请输入节点类型编号(1、V2ray(默认) 2、Trojan 3、Shadowsocks)：" dockerNodeType
  read -p "请输入节点ID：" dockerid
  install_XrayR_NodeType
  Trojan_ssl_XrayR
  #写入配置文件
  sed -i "s|$link|$dockerurl|" $file
  sed -i "s|123|$dockerkey|" $file
  sed -i "s|41|$dockerid|" $file
  sed -i "s|HIM|$dockername|" $docker_compose_file

  docker-compose up -d
  docker ps