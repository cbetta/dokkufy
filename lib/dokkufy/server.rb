module Dokkufy
  class Server
    attr_accessor :host, :username

    def initialize host, username
      self.host = host
      self.username = username
    end

    def setup_key
      user = `echo $USER`
      command = "cat ~/.ssh/id_rsa.pub | ssh #{username}@#{host} 'sudo sshcommand acl-add dokku #{user}'"
      system command
    end

    def method_missing(m, *args, &block)
      method_name = m.to_s
      filename = Dokkufy::Utils.script method_name
      server = "#{username}@#{host}"
      `scp #{filename} #{server}:`
      system("OPTION=#{args.first} ssh -t -q #{server} './#{method_name}.sh'")
      `ssh -t -q #{server} 'rm #{method_name}.sh'`
    end
  end
end
