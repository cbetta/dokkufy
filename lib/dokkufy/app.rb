module Dokkufy
  # Dokkufy your App
  class App
    attr_accessor :hostname, :username, :repo, :app_name

    def initialize(args)
      if args.length == 1
        initialize_from_string(args.first)
      elsif args.length == 2
        initialize_from_arguments(args)
      else
        fail ArgumentError('Invalid number of arguments')
      end
    end

    private

    def initialize_from_string(repo)
      self.repo     = repo
      self.username = repo.split('@').first
      self.hostname = repo.split('@').last.split(':').first
      self.app_name = repo.split('@').last.split(':').last
    end

    def initialize_from_arguments(args)
      self.hostname = args.first
      self.username = args.last
      self.app_name = File.basename(Dir.getwd)
      self.repo     = "#{username}@#{hostname}:#{app_name}"
    end

    def dokkufy
      puts "Using #{repo}"
      Dokkufy::Git.new.dokku_remote = repo
      puts 'You can now push your app using `git push dokku master`'
    end
  end
end
