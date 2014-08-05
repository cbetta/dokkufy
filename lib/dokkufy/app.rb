module Dokkufy
  class App

    attr_accessor :hostname, :username, :repo, :app_name

    def initialize args
      if args.length == 1
        self.repo     = args.first
        self.username = args.first.split("@").first
        self.hostname = args.first.split("@").last.split(":").first
        self.app_name = args.first.split("@").last.split(":").last
      elsif args.length == 2
        self.hostname = args.first
        self.username = args.last
        self.app_name = File.basename(Dir.getwd)
        self.repo     = "#{username}@#{hostname}:#{app_name}"
      else
        raise ArgumentError("Invalid number of arguments")
      end
    end

    def dokkufy
      puts "Using #{repo}"
      Dokkufy::Git.new.dokku_remote = repo
      puts "You can now push your app using `git push dokku master`"
    end

  end
end
