module Dokkufy
  class Dokku
    attr_accessor :repo

    def initialize repo
      self.repo = repo
    end

    def run args
      args = args.insert(1,app_name) if requires_app_name?(args)
      output = `#{command(args)}`
      output.gsub!(" <app>", "") if args.first == 'help'

      puts output
    end

    private

    def requires_app_name? args
      help.lines.each do |line|
        return line.include?("<app>") if line.strip.start_with?(args[0])
      end
      false
    end

    def command args
      command = "ssh -t -q #{server} #{args.join(" ")}"
    end

    def server
      @server ||= self.repo.split(":").first
    end

    def app_name
      @app_name ||= self.repo.split(":").last
    end

    def help
      @help ||= `#{command(["help"])}`
    end

  end
end
