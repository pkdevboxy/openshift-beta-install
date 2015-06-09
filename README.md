# OpenShift Beta 4 Installer
A set of scripts that automate the steps in the ````openshift/training```` demos.

## Instructions
Here's how to use them:

1.  Before runnning, you'll need to provision at least one system running Red Hat Enterprise Linux 7 in a VM. These systems should have at least 20GB of storage and 2GB of RAM each (preferably 4GB or more). This system can be running on VirtualBox, Boxes, or VMware. Alternatively, with a bit more configuration, you can also use these scripts to deploy OpenShift Enterprise v3 Beta 4 on an IaaS platform like OpenStack, **with some minor changes**.

1. Be sure to register your system and attach it:
  ````
  subscription-manager register
  subscription-manager attach --pool <POOL-ID> # Replace <POOL-ID> with proper pool identifier
  ````

2. Configure your ``/etc/hosts`` file by adding the IPs of each VM to it, such as:

  ````
  192.168.155.128   ose3-master.example.com
  192.168.155.129   ose3-node1.example.com
  192.168.155.130   ose3-node2.example.com
  ````

3. Copy your ``/etc/hosts`` file to each of the machines in your deployment.
  ````
  scp /etc/hosts root@ose3-master.example.com:/etc/hosts
  scp /etc/hosts root@ose3-node1.example.com:/etc/hosts
  scp /etc/hosts root@ose3-node2.example.com:/etc/hosts
  ````

4. Clone this repository
  ````
  cd
  git clone https://github.com/rjleaf/openshift-beta-install
  ````

4. Copy all of the files from the repo over to each machine
  ````
  scp ~/openshift-beta-install/beta4/*.sh root@ose3-master.example.com:openshift-beta-install/beta4
  scp ~/openshift-beta-install/beta4/*.sh root@ose3-node1.example.com:openshift-beta-install/beta4
  scp ~/openshift-beta-install/beta4/*.sh root@ose3-node2.example.com:openshift-beta-install/beta4
  ````

5. Run the install on your nodes (can be done in parallel with the next step).
  ````
  ssh root@ose3-node1.example.com
  ./openshift-beta-install/beta4/install.sh node
  ````
  **Important: Do not forget to specify "node" when running the install script. This tells it to prepare the entire cluster properly.**

  You will need to repeat this same step for the second node.

6. Run the install on your master (can be done in parallel with previous).
  ````
  ssh root@ose3-node1.example.com
  ./openshift-beta-install/beta4/install.sh master
  ````
  **Important: Again, do not forget to specify "master" when running the install script. This tells it to prepare the entire cluster properly.**

8. Finally, the fun part: you should now have a fully functional deployment installed on all servers. To access the Web UI, open your browser and navigate to the following page:

  ````
  https://ose3-master.example.com:8443/console
  ````
  Do not forget to specify ``https`` and port ``8443`` when trying to connect. If you fail to do either, you won't be able to load the WebUI.

9. *Enjoy OpenShift Enterprise v3 Beta 4*.

### Things You Need to Do After Installing

To have a fully working deployment, you will need to finish:
  - Configuring DNS (using DNSMasq or creating forward records)
  - Add users and set their passwords
  - Deploy an application
  - Add builder images, templates, and anything else you want to use

### Improvements

This updated release includes some improvements over the previous version, including:
  - Better documentation.
  - Out-of-the-box support for more than one node. You don't need to rerun your configuration
  - One script for doing everything.
