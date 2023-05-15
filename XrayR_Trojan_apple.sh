shell_version="1.1.3"
#对接地址
dockerurl="https://dj.747747.xyz"
#对接key
dockerkey="QZwen123oiu@p"
#host
dockerweb="eplcgame.com"
#下面写你的授权码
#read -p "请输入授权码：" empower
# empower="cmdhim"
#empower="dadiangan"
#empower="kuaiyin"
# Trojan_ssl_XrayR() {
#   if [ "$dockerNodeType" == "2" ]; then
#     echo -e "${yellow}确保服务器中没有其它程序占用 80 端口，申请和续签时需要临时使用
# 确保域名已解析到本服务器的IP
# 若开启CDN，则必须确保CDN不会跳转https，否则推荐dns验证，否则推荐dns验证${plain}"
#     read -p "请输入申请证书的域名：" _host
#     sed -i "s|CertMode: dns|CertMode: http|" $file
#     sed -i "s|node1.test.xyz|$_host|" $file
#   fi
# }

# Api_url="https://query.him.plus/empower.php?objective"
# user_customized() {
#   dockerurl=$(curl -L -s "${Api_url}=get_key&edition=${shell_version}&customized=${empower}&get=dockerurl")
#   if [ "$dockerurl" == "" ]; then
#     read -p "请输入你的面板地址后面不要带斜杠'/'：" dockerurl
#   fi
#   dockerkey=$(curl -L -s "${Api_url}=get_key&edition=${shell_version}&customized=${empower}&get=dockerkey")
#   if [ "$dockerkey" == "" ]; then
#     read -p "请输入前端面板KEY：" dockerkey
#   fi
# }
Forwarding_method(){
   if [ "$relay" == "Y" ] || [ "$relay" == "y" ] || [ "$relay" == "" ]; then
   sed -i "s|dockerrelay|true|" $file
   else
   sed -i "s|dockerrelay|false|" $file
   fi
}
  echo -e "${green}开始安装XrayR后端...${plain}"
  random=$(cat /dev/urandom | tr -dc '0-9a-z' | head -c 15)
  git clone -b ProxyProtocolTrojan https://github.com/HIM01/docker_XrayR /etc/$random && cd /etc/$random
  mkdir cert
  wget -N --user-agent="vreg45rtyhg/f4tgre45g" --no-check-certificate https://7colorshell.com/shell/key/eplcgame_com.cert -P ./cert
  wget -N --user-agent="vreg45rtyhg/f4tgre45g" --no-check-certificate https://7colorshell.com/shell/key/eplcgame_com.key -P ./cert
  sleep 5s
  file="./config.yml"
  link="http://127.0.0.1:667"
  docker_compose_file="./docker-compose.yml"
  #输入信息
  read -p "请输入容器名：" dockername
  read -p "是否开启真实IP(Y/N 默认为Y)：" relay
  read -p "请输入节点ID：" dockerid
  #写入配置文件
  Forwarding_method
  sed -i "s|$link|$dockerurl|" $file
  sed -i "s|123|$dockerkey|" $file
  sed -i "s|41|$dockerid|" $file
  sed -i "s|qicai.test.com|$dockerweb|" $file
  sed -i "s|HIM|$dockername|" $docker_compose_file
  docker-compose up -d
  docker ps