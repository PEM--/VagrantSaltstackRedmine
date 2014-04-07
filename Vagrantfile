# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Name of the node
  config.vm.box = "Redmine"

  # Import a preinstalled Ubuntu Server 13.10
  # TODO : use 64bits : config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-amd64-vagrant-disk1.box"
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-i386-vagrant-disk1.box"

  # Configure VM as a real server available on the LAN
  config.vm.network "private_network", ip: "192.168.50.10"

  # Set specific VirtualBox settings
  config.vm.provider "virtualbox" do |v|
    v.memory = 1024
    v.cpus = 2
  end

  # Synchronized folders
  config.vm.synced_folder "salt/srv/salt/", "/srv/salt/"
  config.vm.synced_folder "~/tmp/", "/var/log/salt/"

   # Use Saltstack as provisioner
  config.vm.provision :salt do |salt|
    # Set the directory where is stored your minion
    salt.minion_config = "salt/minion"
    # Maintain states
    salt.run_highstate = true
  end
end
