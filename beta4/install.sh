all_run(){
  # Set up yum
  subscription-manager repos --disable="*"
  subscription-manager repos \
  --enable="rhel-7-server-rpms" \
  --enable="rhel-7-server-extras-rpms" \
  --enable="rhel-7-server-optional-rpms" \
  --enable="rhel-server-7-ose-beta-rpms"

  #

  rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-redhat-beta

  yum -y install deltarpm
  yum -y install wget vim-enhanced net-tools bind-utils tmux git
  yum -y update

  yum -y install docker

  # Configure Docker

  sed -i "/OPTIONS='--selinux-enabled'/c\OPTIONS='--selinux-enabled --insecure-registry 0.0.0.0/0'" /etc/sysconfig/docker

  # Start and Enable Docker
  systemctl start docker
  systemctl enable docker

  # Pull down required docker images.
  docker pull registry.access.redhat.com/openshift3_beta/ose-haproxy-router:v0.5.2.2
  docker pull registry.access.redhat.com/openshift3_beta/ose-deployer:v0.5.2.2
  docker pull registry.access.redhat.com/openshift3_beta/ose-sti-builder:v0.5.2.2
  docker pull registry.access.redhat.com/openshift3_beta/ose-sti-image-builder:v0.5.2.2
  docker pull registry.access.redhat.com/openshift3_beta/ose-docker-builder:v0.5.2.2
  docker pull registry.access.redhat.com/openshift3_beta/ose-pod:v0.5.2.2
  docker pull registry.access.redhat.com/openshift3_beta/ose-docker-registry:v0.5.2.2
  docker pull registry.access.redhat.com/openshift3_beta/sti-basicauthurl:latest
  docker pull registry.access.redhat.com/openshift3_beta/ose-keepalived-ipfailover:v0.5.2.2

  # Pull down optional docker images for demos
  docker pull registry.access.redhat.com/openshift3_beta/ruby-20-rhel7
  docker pull registry.access.redhat.com/openshift3_beta/mysql-55-rhel7
  docker pull registry.access.redhat.com/jboss-eap-6/eap-openshift
  docker pull openshift/hello-openshift:v0.4.3


  # Clone the Training repos
  cd
  git clone https://github.com/openshift/training.git

  # Add Sample Users

  useradd joe
  useradd alice

}

master_run(){
  yum -y install http://dl.fedoraproject.org/pub/epel/7/x86_64/e/epel-release-7-5.noarch.rpm

  sed -i -e "s/^enabled=1/enabled=0/" /etc/yum.repos.d/epel.repo

  yum -y --enablerepo=epel install ansible

  ssh-keygen

  for host in ose3-master.example.com ose3-node1.example.com ose3-node2.example.com; do ssh-copy-id -i ~/.ssh/id_rsa.pub $host; done

  cd
  git clone https://github.com/detiber/openshift-ansible.git -b v3-beta4
  cd ~/openshift-ansible

  /bin/cp -r ~/training/beta4/ansible/* /etc/ansible/
}

run_playbook(){
  ansible-playbook ~/openshift-ansible/playbooks/byo/config.yml
}

if [ $# -eq 0 ]; then
  echo "You need to specify 'master', 'node', or 'ansible' to run this script."
  exit 1
fi

if [ "$1" == "master" ]; then
  all_run
  master_run
  run_playbook
fi

if [ "$1" == "node" ]; then
  all_run
fi

if [ "$1" == "ansible" ]; then
  run_playbook
fi
