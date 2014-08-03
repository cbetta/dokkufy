module Dokkufy
  class Server
    attr_accessor :hostname, :username

    def initialize hostname, username
      self.hostname = hostname
      self.username = username
    end

    def setup_key
      user = `echo $USER`
      command = "cat ~/.ssh/id_rsa.pub | ssh #{username}@#{hostname} 'sudo sshcommand acl-add dokku #{user}'"
      system command
    end

    def method_missing(m, *args, &block)
      method_name = m.to_s
      filename = Dokkufy::Utils.script method_name
      server = "#{username}@#{hostname}"
      `scp #{filename} #{server}:`
      system("ssh -t #{server} 'OPTION=#{args.first} ./#{method_name}.sh'")
      `ssh -t -q #{server} 'rm #{method_name}.sh'`
    end
  end
end
