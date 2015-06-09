# OpenShift Beta 3 Installer
A set of scripts that automate the steps in the openshift/training demos.

## Instructions
Here's how to use them:

1.  Before runnning, you'll need to provision at least one system running Red Hat Enterprise Linux 7 in a VM. These systems should have at least 20GB of storage and 2GB of RAM each (preferably 4GB or more). This system can be running on VirtualBox, Boxes, or VMware. Alternatively, with a bit more configuration, you can also use these scripts to deploy OpenShift Enterprise v3 Beta 3 on an IaaS platform like OpenStack.

1.  You will also need to manually modify the hosts file on each of the systems to reflect the IP addresses of the VMs in your environment:

  ```
  vi /etc/hosts
  # Type 'i' (without quotes) to enter "insert" mode.
  # Modify the required lines.
  # Type ':x' (without quotes) to save.
  ```

  Be sure to complete all of these steps on each machine in your deployment.

3.  Afterwards, you'll need to modify the ``attach.sh`` script to use your own pool IDs for subscription_manager. For this install method to work, you need an active subscription to Red Hat Enterprise Linux and OpenShift Enterprise.

  Once you've completed thse two previous steps, you're ready to go:
  
  ```
  su root   # You must be root. Switch to root if you aren't already root.
  ./install.sh
  # Get a cup of coffee... this will take a while.
  ```
