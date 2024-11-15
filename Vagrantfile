require 'yaml'
settings = YAML.load_file(File.join(File.dirname(__FILE__), 'settings.yaml'))

Vagrant.configure("2") do |config|
  config.vm.box = settings['box_name']
  # config.vm.box_version = settings['box_version']
  config.vm.box_check_update = false

  settings['vm'].each do |vm_config|
    config.vm.define vm_config['name'] do |vm|
      vm.vm.hostname = vm_config['name']
      vm.vm.network "private_network", ip: vm_config['ip']
      vm.vm.synced_folder ".", "/vagrant", disabled: false

      vm.vm.provider "vmware_fusion" do |vb|
        vb.gui = false
        vb.memory = vm_config['memory']
        vb.cpus = vm_config['cpus']
      end

      host_entries = settings['vm'].map do |entry|
	"echo '#{entry['ip']} #{entry['name']}' >> /etc/hosts"
      end.join("\n")

      vm.vm.provision "shell", inline: <<-SHELL
        apt update
        apt upgrade -y
        apt install -y wget vim net-tools gcc make tar git unzip sysstat tree

        # Followin lines till sysctl apply is pre requisite for kubernetes cluster creation for each cluster node
        cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
        net.ipv4.ip_forward = 1
EOF

        # Apply sysctl params without reboot
        sudo sysctl --system
        sudo sed -i '/^\/swap/ s/^/#/' /etc/fstab
	#{host_entries}
      SHELL
      # vm.vm.provision "shell", path: "scripts/common.sh"
    end
  end
end
