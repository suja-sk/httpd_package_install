#!/bin/bash

# check is user a root user.
# yum update 
# yum install httpd
# service check
# port allow or not
# copy content to /var/www/html/

############# define funcation  ##############
installPackage() {
    local packageName=${1}
    yum install -y ${packageName}
    if [[ $? != 0 ]]
    then    
        echo "${packageName} package not install."
    # else   
    #     echo ""
        exit 1
    fi
}
servicePackage () {
    local serviceName=${1}
    systemctl enable httpd
    if [[ $? != 0 ]]
    then    
        echo "httpd service not running"
    # else
    #     echo ""
        exit 1
   fi
}
firewallPort () {
    local portName=${1}
    firewall-cmd --add-service=http --permanent
    if [[ $? != 0 ]]
    then    
        echo "http port not running"
    # else
    #     ehco ""
        exit 1
   fi
}
# ###########################
if [[ $UID != 0 ]]
then
    echo "\033[0;31m user is not root user"
# else 
#     echo -e "\033[0;32 muser in not a root user"
    exit 1
fi
#########################
yum update 
if [[ $? != 0 ]]
then
    echo "not able update the repository"
# else    
#     echo ""
    exit 1
fi
##################
installPackage httpd
servicePackage httpd
firewallPort http
##################
cp /root/project1/index.html /var/www/html/
if [[ $? != 0 ]]
then    
    echo "content not done"
# else
#     ehco ""
    exit 1
fi

 
