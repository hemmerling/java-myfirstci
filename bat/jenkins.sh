#! /bin/bash
#
# myfirstci
#
jenkinsJob="myfirstci"
jenkinsUrl="http://localhost:8080"     #URL to trigger Jenkins
user="admin"
password="admin"
trigger="BUILD"
#
wget_cmd=wget	                       #Location of wget command
wget_outputToStdout="-O-"
wget_post="--post-data="
wget_credentials="--auth-no-challenge --http-user=$user --http-password=$password"

curl_cmd=curl	                       #Location of curl command
curl_verbose="--verbose"
curl_post="-XPOST"
curl_credentials="--user $user:$password"

# Work without deactivated CSRF 
#$wget_cmd $wget_credentials $wget_post $wget_outputToStdout $jenkinsUrl/job/$jenkinsJob/build?token=$trigger
#$curl_cmd $curl_credentials $curl_post $curl_verbose $jenkinsUrl/job/$jenkinsJob/build?token=$trigger

# Works also with activated CSRF: 
crumb=$(curl $curl_credentials -s 'http://localhost:8080/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)')
$curl_cmd $curl_credentials $curl_post $curl_verbose -H "$crumb" $jenkinsUrl/job/$jenkinsJob/build?token=$trigger



#wget --user admin:admin --output-document - \
#'http://localhost:8080/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)'


#curl --user admin:admin -XPOST --show-error http://localhost:8080/job/myfirstci/build?token=BUILD


#SERVER=http://localhost:8080
#CRUMB=$(curl --user $USER:$APITOKEN \
#    $SERVER/crumbIssuer/api/xml?xpath=concat\(//crumbRequestField,%22:%22,//crumb\))
#echo $CRUMB
#user = admin
#apitoken = admin
#curl --user $USER:$APITOKEN -XPOST --show-error -H "$CRUMB" http://localhost:8080/job/myfirstci/build?token=BUILD
#
#http://localhost:8080/crumbIssuer/api/xml?xpath=concat\(//crumbRequestField,%22:%22,//crumb\))