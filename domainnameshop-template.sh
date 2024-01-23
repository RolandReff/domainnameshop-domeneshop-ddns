### All API commands used in this script can be found within the offical domeneshop API documentation
### that can be found bellow, but short explanations can be found within the script.
### https://api.domeneshop.no/docs/

### To create the credentials visit the page bellow
### https://domene.shop/admin?view=api
token=""
secret=""
domain=""

IFS='.' read -r subdomain SecTopDomain <<< "$domain"
ipv6_regex="(([0-9a-fA-F]{1,4}:){7,7}[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,7}:|([0-9a-fA-F]{1,4}:){1,6}:[0-9a-fA-F]{1,4}|([0-9a-fA-F]{1,4}:){1,5}(:[0-9a-fA-F]{1,4}){1,2}|([0-9a-fA-F]{1,4}:){1,4}(:[0-9a-fA-F]{1,4}){1,3}|([0-9a-fA-F]{1,4}:){1,3}(:[0-9a-fA-F]{1,4}){1,4}|([0-9a-fA-F]{1,4}:){1,2}(:[0-9a-fA-F]{1,4}){1,5}|[0-9a-fA-F]{1,4}:((:[0-9a-fA-F]{1,4}){1,6})|:((:[0-9a-fA-F]{1,4}){1,7}|:)|fe80:(:[0-9a-fA-F]{0,4}){0,4}%[0-9a-zA-Z]{1,}|::(ffff(:0{1,4}){0,1}:){0,1}((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])|([0-9a-fA-F]{1,4}:){1,4}:((25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9])\.){3,3}(25[0-5]|(2[0-4]|1{0,1}[0-9]){0,1}[0-9]))"
ipv4_regex='"id":"\K\[^"]*'

idRegex='"id":"\K\d+';


### Gets the json info about the top domain and gets the domain ID
testID=$( curl https://$token:$secret@api.domeneshop.no/v0/domains?domain=$SecTopDomain); ret=$?

id=$(echo "$testID" | grep -oP '"id":\K\d+')
echo $id

### Gets the json info abut the subdomain
old_ip=$(curl https://$token:$secret@api.domeneshop.no/v0/domains/$id/dns?host=$subdomain);
echo $old_ip
old_ip=$(echo "$old_ip" | grep -oP '"id":"\K[^"]*')
echo $old_ip

current_ip=$(curl -g -4 ifconfig.me)
echo $current_ip

if [[ $old_ip != $current_ip ]]; then
#    curl https://$token:$secret@api.domeneshop.no/v0/dyndns/update?hostname=$domain
    echo "They are NOT the same"
else
   echo "they are the same"
fi
cat > helllo.txt