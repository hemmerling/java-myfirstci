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
wget_outputDocument="--output-document -" # must be followed by SPACE and then the URL in single hyphons ( 'http://...' )
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
crumb=$($curl_cmd $curl_credentials -s $jenkinsUrl'/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)')
#$curl_cmd $curl_credentials $curl_post $curl_verbose -H "$crumb" $jenkinsUrl/job/$jenkinsJob/build?token=$trigger
$curl_cmd $curl_credentials $curl_post $curl_verbose -H "$crumb" $jenkinsUrl/job/$jenkinsJob/build?token=$trigger

# Works also with activated CSRF: 
#crumb=$($wget_cmd $wget_credentials $wget_outputDocument $jenkinsUrl'/crumbIssuer/api/xml?xpath=concat(//crumbRequestField,":",//crumb)')
#wget_header=--header="$crumb"
#$wget_cmd $wget_credentials $wget_post $wget_outputToStdout $wget_header $jenkinsUrl/job/$jenkinsJob/build?token=$trigger

