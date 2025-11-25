#!/bin/bash

# 需要修改的部分
ZONE_ID="5870155e459a2b3f8d77d8401e574d55"
API_TOKEN="DQnDct_XKruedgYg-MAuejKRcu7vhdICSN5pzG9w"
RECORD_NAME="twnat.747747.xyz"

IP=$(curl -s https://ipv4.icanhazip.com)

RECORD_ID=$(curl -s -X GET \
  "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records?type=A&name=$RECORD_NAME" \
  -H "Authorization: Bearer $API_TOKEN" \
  -H "Content-Type: application/json" | jq -r '.result[0].id')

RESPONSE=$(curl -s -X PATCH \
  "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$RECORD_ID" \
  -H "Authorization: Bearer $API_TOKEN" \
  -H "Content-Type: application/json" \
  --data "{\"type\":\"A\",\"name\":\"$RECORD_NAME\",\"content\":\"$IP\",\"ttl\":120,\"proxied\":false}")

echo "$(date): $RESPONSE"