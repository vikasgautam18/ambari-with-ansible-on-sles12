#! /bin/bash

black() {
    echo -e "\e[30m${1}\e[0m"
}

red() {
    echo -e "\e[31m${1}\e[0m"
}

green() {
    echo -e "\e[32m${1}\e[0m"
}

yellow() {
    echo -e "\e[33m${1}\e[0m"
}

blue() {
    echo -e "\e[34m${1}\e[0m"
}

magenta() {
    echo -e "\e[35m${1}\e[0m"
}

cyan() {
    echo -e "\e[36m${1}\e[0m"
}

gray() {
    echo -e "\e[90m${1}\e[0m"
}


ts()
{
    yellow $(echo "`date +%Y-%m-%d,%H:%M:%S`")
}

function stop_service() {

service_name=$1
return_code=0
n=0

if [ $(sh ambari-service.sh $service_name status | grep INSTALLED | wc -l) -gt 0 ]; then
   return_code=2
else
  result=$((sh ambari-service.sh $service_name stop) >/dev/null 2>&1 && echo "TRUE" || echo "FALSE")
  if [ ! -z "$result" ] && [ "$result" = "FALSE" ]; then
     return_code=3
  else
    echo  "$(date +"%Y-%m-%d-%H-%M-%S"): $(blue 'INFO') : Attempting to bring down $service_name service, please wait... "
    until [ $(sh ambari-service.sh $service_name status | grep INSTALLED | wc -l) -gt 0 ]
    do
       echo  "$(date +"%Y-%m-%d-%H-%M-%S"): $(blue 'INFO') : Attempting to bring down $service_name, please wait... "

       if [ "$n" -gt 30  ]; then
          echo  "$(date +"%Y-%m-%d-%H-%M-%S"): $(red 'ERROR') : $service_name not down after 300 seconds.. "
          return_code=1
          break
       fi

       n=$((n+1))
       sleep 10
    done
  fi
fi

if [ "$return_code" = 1 ]; then
   echo "$(date +"%Y-%m-%d-%H-%M-%S"): $(red 'ERROR') : $service_name stop taking longer than expected, please verify the status in Ambari UI"
elif [ "$return_code" = 2 ]; then
  echo "$(date +"%Y-%m-%d-%H-%M-%S"): $(green 'INFO') : $service_name already not running !"
elif [ "$return_code" = 3 ]; then
  echo "$(date +"%Y-%m-%d-%H-%M-%S"): $(red 'ERROR') : error stopping $service_name, please verify the status in Ambari UI"
else
   echo "$(date +"%Y-%m-%d-%H-%M-%S"): $(green 'INFO') : $service_name stopped successfully !"
fi

return $return_code
}

function start_service() {

service_name=$1
return_code=0
n=0

if [ $(sh ambari-service.sh $service_name status | grep STARTED | wc -l) -gt 0 ]; then
   return_code=2
else
  result=$((sh ambari-service.sh $service_name start) >/dev/null 2>&1 && echo "TRUE" || echo "FALSE")
  if [ ! -z "$result" ] && [ "$result" = "FALSE" ]; then
     return_code=3
  else
    echo  "$(date +"%Y-%m-%d-%H-%M-%S"): $(blue 'INFO') : Attempting to bring up $service_name service, please wait... "
    until [ $(sh ambari-service.sh $service_name status | grep STARTED | wc -l) -gt 0 ]
    do
       echo  "$(date +"%Y-%m-%d-%H-%M-%S"): $(blue 'INFO') : Attempting to bring up $service_name, please wait... "

       if [ "$n" -gt 30  ]; then
          echo  "$(date +"%Y-%m-%d-%H-%M-%S"): $(red 'ERROR') : $service_name not up after 300 seconds.. "
          return_code=1
          break
       fi

       n=$((n+1))
       sleep 10
    done
  fi
fi

if [ "$return_code" = 1 ]; then
   echo "$(date +"%Y-%m-%d-%H-%M-%S"): $(red 'ERROR') : $service_name start taking longer than expected, please verify the status in Ambari UI"
elif [ "$return_code" = 2 ]; then
  echo "$(date +"%Y-%m-%d-%H-%M-%S"): $(green 'INFO') : $service_name already running !"
elif [ "$return_code" = 3 ]; then
  echo "$(date +"%Y-%m-%d-%H-%M-%S"): $(red 'ERROR') : error starting $service_name, please verify the status in Ambari UI"
else
   echo "$(date +"%Y-%m-%d-%H-%M-%S"): $(green 'INFO') : $service_name started successfully !"
fi

return $return_code
}

