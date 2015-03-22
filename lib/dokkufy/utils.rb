require 'open-uri'

module Dokkufy
  # General utility functions used by other modules
  module Utils
    def self.scripts_directory
      gem_bin_directory = File.dirname(File.expand_path($PROGRAM_NAME))
      scripts_directory = "#{gem_bin_directory}/../scripts"
      paths = [File.expand_path(scripts_directory),
               "#{Gem.dir}/gems/#{Dokkufy::NAME}-#{Dokkufy::VERSION}/scripts"]
      paths.each { |path| return path if File.readable?(path) }
      fail 'No scripts found'
    end

    def self.script(name)
      File.join(scripts_directory, "#{name}.sh")
    end

    def self.stable_version
      uri = 'https://github.com/progrium/dokku/releases/latest'
      open(uri) do |resp|
        return resp.base_uri.to_s.split('/').last
      end
    end
  end
end
