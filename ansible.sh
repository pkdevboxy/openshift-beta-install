if [[ $EUID -ne 0 ]]; then
	echo "This must be run as root!" 1>&2
	exit 1
fi

git clone https://github.com/openshift/training.git

yum -y install http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm

sed -i -e "s/^enabled=1/enabled=0/" /etc/yum.repos.d/epel.repo

yum -y --enablerepo=epel install ansible

ssh-keygen

for host in ose3-master.example.com ose3-node1.example.com ose3-node2.example.com; do ssh-copy-id -i ~/.ssh/id_rsa.pub $host; done

cd
git clone https://github.com/detiber/openshift-ansible.git -b v3-beta3
cd ~/openshift-ansible

/bin/cp -r ~/training/beta3/ansible/* /etc/ansible/

ansible-playbook ~/openshift-ansible/playbooks/byo/config.yml



