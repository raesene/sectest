#!/bin/sh

: ${SSH_USERPASS:=$(dd if=/dev/urandom bs=1 count=15 | base64)}

__create_rundir() {
	mkdir -p /var/run/sshd
}

__create_user() {
# Create a user to SSH into as.
echo  "root:$SSH_USERPASS" | chpasswd
echo ssh user password: $SSH_USERPASS
}

__create_hostkeys() {
ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key -N '' 
}

__ip_address() {
IPADDRESS="$(/sbin/ifconfig eth0 | grep 'inet' | cut -d: -f2 | awk '{print $2}')"
echo IP Address: $IPADDRESS
}

__enable_root_login() {
echo "PermitRootLogin Yes" >> /etc/ssh/sshd_config
}


# Call all functions
__create_rundir
__create_hostkeys
__create_user
__ip_address
__enable_root_login

exec /usr/sbin/sshd -D -e "$@"
