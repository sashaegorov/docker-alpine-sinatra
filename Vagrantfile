VAGRANTFILE_API_VERSION = '2'
Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.synced_folder ".", "/vagrant", type: "rsync"
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"
  config.vm.box = 'debian/stretch64'
  config.vm.network 'private_network', ip: '192.168.50.4'
  config.vm.network :forwarded_port, guest: 5678, host: 5678
  config.vm.provision :docker do |d|
    d.pull_images 'gliderlabs/alpine:latest'
  end
end
