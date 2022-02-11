Vagrant.configure("2") do |config|
    # Crea una llave por defecto
    config.ssh.insert_key = false

	#la siguiente linea define el nombre de la vm 
	config.vm.define :vmpagina do |vmpagina|
		#se define en que box estara basada
    	vmpagina.vm.box = "rhel7.9"
    	#asigna una IP especifica
		vmpagina.vm.network :private_network,:ip => "192.168.121.115"
		#se define el nombre del host de la vm
	    vmpagina.vm.hostname = "mipagina"
	    vmpagina.vm.provider :libvirt do |libvirt|
		  	#define la cantidad de memoria RAM
	    	libvirt.memory = 2040
	    	#define la cantidad de CPUs
	      	libvirt.cpus = 2
	      	#define personalizadamente como estara distribuida la CPU
	      	libvirt.cputopology :sockets => '1', :cores => '2', :threads => '1'
	      	libvirt.storage :file, :device => :cdrom, :path => '/laboratorio/Sistemas-Operativos/rhel-server-7.9-x86_64-dvd.iso'
	    end
  	end
	## Shell para ejecutar despues de que la maquina corra
	config.vm.provision "shell", run: "/vagrant/setup.sh", inline: "sh /vagrant/setup.sh"
end
