#!/bin/bash
# fix ORA-04035: unable to allocate 4096 bytes of shared memory in shared object cache "JOXSHM" of size "1073741824"
mount -o remount,exec /dev/shm
# fix ORA-27106: system pages not available to allocate memory
sysctl vm.hugetlb_shm_group=54321

########### SIGINT handler ############
function _int() {
   kill -SIGINT $childPID
}

########### SIGTERM handler ############
function _term() {
   kill -SIGTERM $childPID
}

########### SIGKILL handler ############
function _kill() {
   kill -SIGKILL $childPID
}

# Set SIGINT handler
trap _int SIGINT

# Set SIGTERM handler
trap _term SIGTERM

# Set SIGKILL handler
trap _kill SIGKILL

su - oracle -c "$ORACLE_BASE/runOls.sh $ORACLE_SID $ORACLE_PDB $ORACLE_PWD $ORACLE_CHARACTERSET" &
childPID=$!
wait $childPID
