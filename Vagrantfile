  Vagrant.configure("2") do |config|


   config.vm.define "master" do |master|

     master.vm.hostname ="master.example.com"
     master.vm.box ="ubuntu/focal64"
     master.vm.network "private_network", ip: "192.168.33.35"

     master.vm.provision "shell", inline: <<-SHELL
     sudo apt-get update && sudo apt-get upgrade -y 
     sudo apt-get install -y avahi-daemon libnss-mdns
     sudo apt install sshpass -y
     SHELL
    end


   config.vm.define "slave" do|slave|
    
     slave.vm.box ="ubuntu/focal64"
     slave.vm.hostname ="slave.example.com"
     slave.vm.network  "private_network", ip: "192.168.33.20"

     slave.vm.provision "shell", inline: <<-SHELL
     sudo apt-get update && sudo apt-get upgrade -y
     sudo apt install sshpass -y
     sudo apt-get install -y avahi daemon libnss-mdns
     SHELL
    end


   config.vm.provider "virtualbox" do|vb|
     vb.memory ="1024"
     vb.cpus ="2"
    end
 end 
 
 
