# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "debian/bookworm64"
  config.ssh.insert_key = false
  config.vm.synced_folder ".", "/vagrant", disabled: true

  config.vm.provider :virtualbox do |vb|
    vb.memory = 512
    vb.linked_clone = true
    vb.check_guest_additions = false
  end

  # Servidor de Arquivos
  config.vm.define "arq" do |arq|
    arq.vm.hostname = "arq.caua.cosme.devops"
    arq.vm.network :private_network, ip: "192.168.56.236"
    arq.vm.provider :virtualbox do |vb|
      vb.memory = 512
    end
    (1..3).each do |i|
      arq.vm.disk :disk, size: "10GB", name: "disk-#{i}"
    end
  end

  # Servidor de Banco de Dados
  config.vm.define "db" do |db|
    db.vm.hostname = "db.caua.cosme.devops"
    db.vm.network :private_network, type: "dhcp"
    db.vm.provider :virtualbox do |vb|
      vb.memory = 512
    end
  end

  # Servidor de Aplicação
  config.vm.define "app" do |app|
    app.vm.hostname = "app.caua.cosme.devops"
    app.vm.network :private_network, type: "dhcp"
    config.vm.network "private_network", type: "dhcp"
    app.vm.provider :virtualbox do |vb|
      vb.memory = 512
    end
  end

  # Cliente
  config.vm.define "cli" do |cli|
    cli.vm.hostname = "cli.caua.cosme.devops"
    cli.vm.network :private_network, type: "dhcp"
    config.vm.network "private_network", type: "dhcp"
    cli.vm.provider :virtualbox do |vb|
      vb.memory = 1024
    end
  end
end

