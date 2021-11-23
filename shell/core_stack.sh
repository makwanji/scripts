#!/bin/bash

stack() {
  echo "service status..."
  /usr/local/bin/brew services list

  /usr/local/bin/brew services $1 mysql
  /usr/local/bin/brew services $1 postgresql@12
  /usr/local/bin/brew services $1 redis

  echo "service status..."
  /usr/local/bin/brew services list
}

## script execution
export ACTION=$1

## call function
case $ACTION in
start) stack $ACTION ;;
stop) stack $ACTION ;;
*) echo "!! Invalid choice, use e.g. ~/core_stack.sh start|stop" ;;
esac

