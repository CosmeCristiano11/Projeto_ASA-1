# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "debian/bookworm64"

  # Montagem padrão da pasta do projeto
  config.vm.synced_folder ".", "/vagrant"

  config.vm.provider :virtualbox do |vb|
    vb.memory = 512
    vb.linked_clone = true
    vb.check_guest_additions = false
  end

  # Servidor ARQ
  config.vm.define "arq" do |arq|
    arq.vm.hostname = "arq.caua.cosme.devops"
    arq.vm.network :private_network, ip: "192.168.56.236"

    arq.trigger.before :"Vagrant::Action::Builtin::WaitForCommunicator", type: :action do |t|
      t.warn = "Interrompendo o servidor DHCP do VirtualBox (se existir)..."
      t.run = {
        inline: "sh -c 'VBoxManage list dhcpservers | grep -q vboxnet0 && VBoxManage dhcpserver stop --interface vboxnet0'"
      }
    end

    arq.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "/vagrant/playbooks/arq.yml"
      ansible.inventory_path = "/vagrant/hosts.ini"
    end
  end

  # Servidor DB
  config.vm.define "db" do |db|
    db.vm.hostname = "db.caua.cosme.devops"
    db.vm.network "private_network", type: "dhcp"

    db.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "/vagrant/playbooks/db.yml"
      ansible.inventory_path = "/vagrant/hosts.ini"
    end
  end

  # Servidor APP
  config.vm.define "app" do |app|
    app.vm.hostname = "app.caua.cosme.devops"
    app.vm.network "private_network", type: "dhcp"

    app.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "/vagrant/playbooks/app.yml"
      ansible.inventory_path = "/vagrant/hosts.ini"
    end
  end

  # Cliente CLI
  config.vm.define "cli" do |cli|
    cli.vm.hostname = "cli.caua.cosme.devops"
    cli.vm.network "private_network", type: "dhcp"

    cli.vm.provision "ansible_local" do |ansible|
      ansible.playbook = "/vagrant/playbooks/cli.yml"
      ansible.inventory_path = "/vagrant/hosts.ini"
    end
  end
end

