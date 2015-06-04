# This must be run as root, so...

if [[ $EUID -ne 0  ]]; then
	echo "This must be run as root!" 1>&2
	exit 1
fi



subscription-manager repos --disable="*"
subscription-manager repos \
	--enable="rhel-7-server-rpms" \
	--enable="rhel-7-server-extras-rpms" \
	--enable="rhel-7-server-optional-rpms" \
	--enable="rhel-server-7-ose-beta-rpms"

rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-beta

yum -y install deltarpm

yum -y remove NetworkManager*

yum -y install wget vim-enhanced net-tools bind-utils tmux git

yum -y update

yum -y install docker

sed -i "/OPTIONS='--selinux-enabled'/c\OPTIONS='--selinux-enabled --insecure-registry 0.0.0.0/0'" /etc/sysconfig/docker


systemctl start docker

docker pull registry.access.redhat.com/openshift3_beta/ose-haproxy-router:v0.4.3.2
docker pull registry.access.redhat.com/openshift3_beta/ose-deployer:v0.4.3.2
docker pull registry.access.redhat.com/openshift3_beta/ose-sti-builder:v0.4.3.2
docker pull registry.access.redhat.com/openshift3_beta/ose-docker-builder:v0.4.3.2
docker pull registry.access.redhat.com/openshift3_beta/ose-pod:v0.4.3.2
docker pull registry.access.redhat.com/openshift3_beta/ose-docker-registry:v0.4.3.2
docker pull registry.access.redhat.com/openshift3_beta/sti-basicauthurl:latest

docker pull registry.access.redhat.com/openshift3_beta/ruby-20-rhel7
docker pull registry.access.redhat.com/openshift3_beta/mysql-55-rhel7
docker pull openshift/hello-openshift:v0.4.3
docker pull openshift/ruby-20-centos7
