# !/bin/bash

#set -o xtrace


# Use run-upgrade to run prerequisites (remove main call)
sed -i s/'^main$'/''/g ./run-upgrade.sh

source ./run-upgrade.sh

# Set variables
export TERM=xterm
export I_REALLY_KNOW_WHAT_I_AM_DOING=true

# Run pre-requisites
echo 'YES' | pre_flight
check_for_current
#"${SCRIPTS_PATH}/bootstrap-ansible.sh"
