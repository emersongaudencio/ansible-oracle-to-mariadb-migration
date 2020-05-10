#!/bin/bash
export SCRIPT_PATH="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
export PYTHON_BIN=/usr/bin/python
export ANSIBLE_CONFIG=$SCRIPT_PATH/ansible.cfg

cd $SCRIPT_PATH

VAR_HOST=${1}
VAR_USER=${2}

if [ "${VAR_HOST}" == '' ] ; then
  echo "No host specified. Please have a look at README file for futher information!"
  exit 1
elif [ "${VAR_USER}" == '' ] ; then
  echo "No USER specified. Please have a look at README file for futher information!"
  exit 1
fi

### SQLINES Setup ####
ansible-playbook -v -i $SCRIPT_PATH/hosts -e "{user: '$VAR_USER'}" $SCRIPT_PATH/playbook/sqlines.yml -l $VAR_HOST
