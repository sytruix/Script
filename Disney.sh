#!/bin/bash

# 检查 Disney+ 网站访问状态的脚本
# 使用方法：直接运行该脚本，输出 Disney+ 的 HTTP 响应头信息

# 定义目标网址
URL="https://www.disneyplus.com/"

# 使用 curl 检查网站的 HTTP 响应头
# -I 参数表示仅获取响应头信息
# -s 参数表示静默模式，不显示多余信息
response=$(curl -I -s "$URL")

# 提取 HTTP 状态码
# 通过管道将响应头过滤出第一行，并提取其中的状态码
status_code=$(echo "$response" | head -n 1 | awk '{print $2}')

# 输出响应头信息
echo "=============== Disney+ 网站访问状态检查 ==============="
echo "目标网址：$URL"

if [ -z "$status_code" ]; then
  echo "状态：无法获取响应（可能是网络问题或网站无法访问）"
else
  echo "HTTP 状态码：$status_code"

  # 根据状态码进行进一步说明
  case $status_code in
    200)
      echo "状态描述：访问正常"
      ;;
    301|302)
      echo "状态描述：页面被重定向（通常正常）"
      ;;
    403)
      echo "状态描述：访问被拒绝（可能是 IP 被封禁或地区限制）"
      ;;
    404)
      echo "状态描述：页面不存在"
      ;;
    5**)
      echo "状态描述：服务器内部错误"
      ;;
    *)
      echo "状态描述：未知状态码"
      ;;
  esac
fi

echo "====================================================="
