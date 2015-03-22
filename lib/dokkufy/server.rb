module Dokkufy
  # Dokkufy your server
  class Server
    attr_accessor :hostname, :username

    def initialize(hostname, username)
      self.hostname = hostname
      self.username = username
    end

    def dokkufy(version, domain)
      ensure_passwordless_sudo
      install_dokku(version)
      configure_vhost(domain)
      setup_key
    end

    def setup_key
      user = `echo $USER`
      public_key = 'id_rsa.pub'
      until File.exist?(File.expand_path("~/.ssh/#{public_key}"))
        public_key = ask 'Enter public key file name(e.g. id_rsa.pub):'
      end
      cat_key = "cat ~/.ssh/#{public_key}"
      acl_add_user = "'sudo sshcommand acl-add dokku #{user}'"
      ssh_add_user = "ssh #{username}@#{hostname} #{acl_add_user}"
      command = "#{cat_key} | #{ssh_add_user}"
      system command
    end

    def method_missing(m, *args, &_block)
      method_name = m.to_s
      filename = Dokkufy::Utils.script method_name
      server = "#{username}@#{hostname}"
      `scp #{filename} #{server}:`
      options = "'OPTION1=#{args[0]} OPTION2=#{args[1]}"
      system("ssh -t -q #{server} #{options} ./#{method_name}.sh'")
      `ssh -t -q #{server} 'rm ~/#{method_name}.sh'`
    end
  end
end
