Vagrant.configure("2") do |config|
  config.vm.define :base do |base|
    base.vm.box = "atomicapp/dev"
    base.vm.provider :libvirt do |domain|
      domain.memory = 4096
      domain.cpus = 4
    end
  end
end
