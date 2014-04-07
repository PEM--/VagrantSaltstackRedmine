# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Name of the node
  config.vm.box = "Redmine"

  # Import a preinstalled Ubuntu Server 12.04 LTS
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-i386-vagrant-disk1.box"

  # Configure VM as a real server available on the LAN
  config.vm.network "private_network", ip: "192.168.50.10"
  # Add port forwarding to access service deployed in the node
  #config.vm.network "forwarded_port", host: 8080, guest: 80
  #config.vm.network "forwarded_port", host: 3000, guest: 3000

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
