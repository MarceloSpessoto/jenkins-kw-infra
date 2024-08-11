# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  ENV['VAGRANT_DEFAULT_PROVIDER'] = 'virtualbox'

  config.vm.box = 'generic/ubuntu1804'

  config.vm.network 'forwarded_port', guest: 22, host: Integer(ENV['VM_AGENT_PORT'])
  # config.vm.network "public_network"

  config.vm.provision 'shell' do |s|
    vm_ssh_key = File.readlines('vm_key.pub').first.strip
    s.inline = <<-SHELL
      apt update -y
      apt install -y default-jre
      adduser jenkins --disabled-password --gecos ""
      mkdir /var/lib/jenkins
      chown jenkins /var/lib/jenkins
      mkdir /home/jenkins/.ssh
      echo #{vm_ssh_key} > /home/jenkins/.ssh/authorized_keys
      chown -R jenkins /home/jenkins/.ssh
    SHELL
  end
end
