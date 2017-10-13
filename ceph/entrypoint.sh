#!/bin/bash
set -ex

if [ -z "$MONITOR" ] && [ -z "$OSD" ] && [ -z "$CLIENT" ]; then
  echo 'Expecting one of MONITOR, OSD or CLIENT variables'
  exit 1
fi
if [ -z "$CEPH_PUBLIC_NETWORK" ] || [ -z "$MON_IP" ]; then
  echo 'Expecting CEPH_PUBLIC_NETWORK and MON_IP variables'
  exit 1
fi

sed -i -e "s@monip@$MON_IP@" /etc/ceph/ceph.conf
sed -i -e "s@cephnet@$CEPH_PUBLIC_NETWORK@" /etc/ceph/ceph.conf

if [ -f /etc/ceph/extra.conf ]; then
  cat /etc/ceph/extra.conf >> /etc/ceph/ceph.conf
fi

if [ -n "$MONITOR" ]; then
  if [ -n "$CLIENT" ]; then
    /entrypoint.sh mon
  else
    exec /entrypoin.sh mon &
  fi
fi

if [ -n "$OSD" ]; then
  if [ -n "$CLIENT" ]; then
    run_osds &
  else
    exec run_osds
  fi
fi

if [ -n "$CLIENT" ]; then
  if [ -z "$CLIENT_SCRIPT" ]; then
    echo "No CLIENT_SCRIPT defined, running built-in radosbench script."
    CLIENT_SCRIPT=run_radosbench
  fi

  if ! ceph_health_ok; then
    echo "Failed waiting for HEALTH_OK from monitor"
    exit 1
  fi
  $CLIENT_SCRIPT
  exit 13
fi
