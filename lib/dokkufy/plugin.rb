require 'open-uri'
require 'hpricot'

module Dokkufy
  class Plugin

    attr_accessor :hostname, :username, :path

    def initialize hostname, username
      self.hostname = hostname
      self.username = username
    end

    def install id_or_name
      self.path = id_or_name
      Dokkufy::Server.new(hostname, username).install_plugin(path, name)
    end

    def uninstall id_or_name
      self.path = id_or_name
      Dokkufy::Server.new(hostname, username).uninstall_plugin(path, name)
    end

    def list
      plugins = []
      public_key = "id_rsa.pub"
        until File.exists?(File.expand_path("~/.ssh/#{public_key}")) do
          public_key = ask "Enter public key file name(e.g. id_rsa.pub):"
        end
      command = "cat ~/.ssh/#{public_key} | ssh #{username}@#{hostname} 'dokku plugins'"
      output=IO.popen(command).readlines
      output.each_with_index do |plugin_path,index| 
        name = File.basename(plugin_path.chomp)
        plugins.push [index+1,name,plugin_path]
      end
      plugins
    end

    def self.all with_notes = false
      return @plugins if @plugins
      open("https://github.com/progrium/dokku/wiki/Plugins") do |f|
        hp = Hpricot(f)
        plugins = hp.search("tbody tr td").each_slice(3)
        @plugins = plugins.each_with_index.map do |plugin, index|
          first_element = plugin.first.children.reject{|e| e.inner_text.strip == ""}.first
          entry = [index+1,
            first_element.attributes["href"].split("github.com/").last,
            first_element.inner_text]
          entry << plugin.last.inner_text if with_notes
          entry
        end
      end
    end

    private

    def path=(id_or_name)
      if id_or_name.to_i.to_s == id_or_name
        Dokkufy::Plugin.all.each do |plugin|
          if plugin[0] == id_or_name.to_i
            @path = plugin[1]
            return
          end
        end
      else
        @id = id_or_name
      end
    end

    def name
      Dokkufy::Plugin.all.each do |plugin|
        if plugin[1] == path
          return plugin[2].split(" ").first.downcase
        end
      end
    end


  end
end
