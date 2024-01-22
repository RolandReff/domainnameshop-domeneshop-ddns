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

ipv6TEST="2a01:799:19eb:9300:6573:2132:8575:ecf7";


### Checks for the current public IPv6
#current_ip=$(curl -s -6 https://api64.ipify.org || curl -s -6 https://ipv6.icanhazip.com)

#if [[ ! $current_ip =~ ^$ipv6_regex$ ]]; then
#    echo "Failed to validate the IP address"
#    exit 1
#fi

idRegex='"id":"\K\d+';
ipv4regex='^ip=(\d.*)'
### '\"id":(\d*)'

### Gets the json info about the top domain and gets the domain ID
idRegex='\"id":(\d*)';
testID=$( curl https://$token:$secret@api.domeneshop.no/v0/domains?domain=$SecTopDomain); ret=$?
id=$(echo "$testID" | grep -oP '"id":\K\d+')

### Gets the json info abut the subdomain
echo $(curl https://$token:$secret@api.domeneshop.no/v0/domains/$id/dns?host=$subdomain);

### Updates the DNS record of the provided domain 
if [[ $old_ip != $current_ip ]] then
    #curl https://$token:$secret@api.domeneshop.no/v0/dyndns/update?hostname=$domain
    echo "They are NOT the same"
else
    echo "they are the same"
fi

cat > hell.txt