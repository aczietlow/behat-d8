Vagrant.configure("2") do |config|

  # tunables
  env_prefix  = ENV['DRUPAL_VAGRANT_ENV_PREFIX'] || 'PALANTIR_VAGRANT'
  project     = ENV["#{env_prefix}_PROJECT"] || 'palantir'
  # end tunables

  config.vm.box = "palantir/ubuntu1404"
  config.vm.box_version = ">= 1.0.15"

  config.vm.provider "vmware_fusion" do |v|
    v.name = "#{project}-box"
    v.gui = false
    v.vmx["memsize"] = "2048"
  end

  config.vm.provider "virtualbox" do |vb|
    vb.name = "#{project}-box"
    vb.customize ["modifyvm", :id, "--memory", 2048]
  end

  config.ssh.forward_agent = true

  config.vm.provision "ansible" do |ansible|
    ansible.playbook = "provisioning/palantir_default_playbook.yml"
    ansible.limit = 'all'
    ansible.extra_vars = {
      hostname: "palantir",
    }
  end
end
