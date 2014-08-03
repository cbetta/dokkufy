require 'open-uri'
require 'hpricot'

module Dokkufy
  class Plugin

    attr_accessor :hostname, :username, :id

    def initialize hostname, username
      self.hostname = hostname
      self.username = username
    end

    def install id_or_name
      self.id = id_or_name
      Dokkufy::Server.new(hostname, username).install_plugin(id)
    end

    def self.all with_notes = false
      open("https://github.com/progrium/dokku/wiki/Plugins") do |f|
        hp = Hpricot(f)
        plugins = hp.search("tbody tr td").each_slice(3)
        return plugins.each_with_index.map do |plugin, index|
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

    def id=(id_or_name)
      if id_or_name.to_i.to_s == id_or_name
        Dokkufy::Plugin.all.each do |plugin|
          if plugin[0] == id_or_name.to_i
            @id = plugin[1]
            return
          end
        end
      else
        @id = id_or_name
      end
    end


  end
end
