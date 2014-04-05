# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # Name of the node
  config.vm.box = "Redmine"

  # Import a preinstalled Ubuntu Server 12.04 LTS
  config.vm.box_url = "https://cloud-images.ubuntu.com/vagrant/precise/current/precise-server-cloudimg-i386-vagrant-disk1.box"

  # Add port forwarding to access service deployed in the node
  config.vm.network "forwarded_port", host: 8080, guest: 80

  # Synchronized folders
  config.vm.synced_folder "salt/www/", "/var/lib/www/"
  config.vm.synced_folder "salt/srv/salt/", "/srv/salt/"

   # Use Saltstack as provisioner
  config.vm.provision :salt do |salt|
    # Set the directory where is stored your minion
    salt.minion_config = "salt/minion"
    # Maintain states
    salt.run_highstate = true
  end
end
