# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "generic/ubuntu2004"

  config.vm.provider "virtualbox" do |v|
    v.cpus = 2
  end
  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  config.vm.synced_folder "./demos", "/home/vagrant/demos"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.
  # if Vagrant.has_plugin?("vagrant-vbguest")
  #   config.vbguest.auto_update = false  
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Ansible, Chef, Docker, Puppet and Salt are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision "shell", inline: <<-SHELL
    apt-get update
    apt-get install bpfcc-tools linux-headers-$(uname -r) targetcli-fb libiscsi-bin -y
    apt install python3-distutils -y

    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 4052245BD4284CDD

    apt-get -y install bison build-essential cmake flex git libedit-dev libllvm6.0 llvm-6.0-dev libclang-6.0-dev python zlib1g-dev libelf-dev

    git clone https://github.com/iovisor/bcc.git
    mkdir bcc/build; cd bcc/build
    cmake ..
    make
    make install
    cmake -DPYTHON_CMD=python3 ..
    pushd src/python
    make
    make install
    popd
    
    apt-get install -y bpftrace
    apt-get install -y mariadb-server docker.io

    curl -sL -o /usr/local/bin/gimme https://raw.githubusercontent.com/travis-ci/gimme/master/gimme
    chmod +x /usr/local/bin/gimme

    # seems more likely to have recent fixes vs the apt package
    # see https://github.com/iovisor/bpftrace/blob/master/INSTALL.md#copying-bpftrace-binary-from-docker
    docker run -v /home/vagrant:/output quay.io/iovisor/bpftrace:master-vanilla_llvm_clang_glibc2.23 /bin/bash -c "cp /usr/bin/bpftrace /output"

    wget -O chruby-0.3.9.tar.gz https://github.com/postmodern/chruby/archive/v0.3.9.tar.gz
    tar -xzvf chruby-0.3.9.tar.gz
    cd chruby-0.3.9/
    sudo make install

    wget -O ruby-install-0.8.1.tar.gz https://github.com/postmodern/ruby-install/archive/v0.8.1.tar.gz
    tar -xzvf ruby-install-0.8.1.tar.gz
    cd ruby-install-0.8.1/
    sudo make install

    ruby-install ruby 2.6 -- --enable-dtrace

    echo "PATH=$PATH:/usr/share/bcc/tools" >> ~/.bashrc
    echo "chruby ruby-2.6" >> ~/.bashrc
    echo "Defaults secure_path=\"$PATH:/usr/share/bcc/tools\"" > /etc/sudoers.d/conf
  SHELL

  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    
    echo "PATH=$PATH:/usr/share/bcc/tools" >> /home/vagrant/.bashrc
    echo 'eval "$(gimme 1.16)"' >> /home/vagrant/.bashrc
    git clone https://github.com/iovisor/gobpf.git

    git clone https://github.com/cloudflare/ebpf_exporter.git
    eval $(gimme 1.16)
    go get -u -v github.com/cloudflare/ebpf_exporter/...
  SHELL
end
