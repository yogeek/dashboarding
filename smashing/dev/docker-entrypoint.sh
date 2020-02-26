#!/bin/bash
set -e

# Change uid and gid of node user so it matches ownership of current dir
if [ "$MAP_NODE_UID" != "no" ]; then
    if [ ! -d "$MAP_NODE_UID" ]; then
        MAP_NODE_UID=$PWD
    fi

    uid=$(stat -c '%u' "$MAP_NODE_UID")
    gid=$(stat -c '%g' "$MAP_NODE_UID")

    usermod -u $uid $USER 2> /dev/null && {
      groupmod -g $gid $GROUP 2> /dev/null || usermod -a -G $gid $USER
    }
    chown -R $USER:$GROUP /home/$USER
    echo "$USER  ALL=(ALL) NOPASSWD:ALL" | sudo tee /etc/sudoers.d/$USER
fi

exec /usr/local/bin/gosu $USER "$@"