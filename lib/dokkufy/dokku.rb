module Dokkufy
  class Dokku
    attr_accessor :repo

    def initialize repo
      self.repo = repo
    end

    def run args
      output = `#{command(args)}`
      if output.strip.end_with?("does not exist")
        args = args.insert(1,app_name)
        output = `#{command(args)}`
      end
      puts output
    end

    private

    def command args
      command = "ssh -t -q #{server} #{args.join(" ")}"
    end

    def server
      @server ||= self.repo.split(":").first
    end

    def app_name
      @app_name ||= self.repo.split(":").last
    end

  end
end
