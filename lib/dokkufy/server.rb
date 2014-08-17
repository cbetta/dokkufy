module Dokkufy
  class Server
    attr_accessor :hostname, :username

    def initialize hostname, username
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
      public_key = "id_rsa.pub"
      until File.exists?(File.expand_path("~/.ssh/#{public_key}")) do
        public_key = ask "Enter public key file name(e.g. id_rsa.pub):"
      end
      command = "cat ~/.ssh/#{public_key} | ssh #{username}@#{hostname} 'sudo sshcommand acl-add dokku #{user}'"
      system command
    end

    def method_missing(m, *args, &block)
      method_name = m.to_s
      filename = Dokkufy::Utils.script method_name
      server = "#{username}@#{hostname}"
      `scp #{filename} #{server}:`
      system("ssh -t -q #{server} 'OPTION1=#{args[0]} OPTION2=#{args[1]} ./#{method_name}.sh'")
      `ssh -t -q #{server} 'rm ~/#{method_name}.sh'`
    end
  end
end