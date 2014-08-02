require 'open-uri'

module Dokkufy
  module Utils
    def self.scripts_directory
      t = [File.expand_path("#{File.dirname(File.expand_path($0))}/../scripts"),
           "#{Gem.dir}/gems/#{Dokkufy::NAME}-#{Dokkufy::VERSION}/scripts"]
      t.each {|i| return i if File.readable?(i) }
      raise "No scripts found"
    end

    def self.script name
      File.join(scripts_directory, "#{name}.sh")
    end

    def self.stable_version
      uri = "https://github.com/progrium/dokku/releases/latest"
      open(uri) do |resp|
        return resp.base_uri.to_s.split("/").last
      end
    end
  end
end
