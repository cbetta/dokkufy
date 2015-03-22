require 'open-uri'
require 'hpricot'

module Dokkufy
  # Manage plugins with Dokkufy
  class Plugin
    attr_accessor :hostname, :username, :path

    def initialize(hostname, username)
      self.hostname = hostname
      self.username = username
    end

    def install(id_or_name)
      self.path = id_or_name
      Dokkufy::Server.new(hostname, username).install_plugin(path, name)
    end

    def uninstall(id_or_name)
      self.path = id_or_name
      Dokkufy::Server.new(hostname, username).uninstall_plugin(path, name)
    end

    def self.all(with_notes = false)
      return @plugins if @plugins
      open('http://progrium.viewdocs.io/dokku/plugins') do |file|
        @plugins = parse_html(file, with_notes)
      end
    end

    def self.parse_html(file, with_notes)
      parser = Hpricot(file)
      plugins = parser.search('tbody tr td').each_slice(3)
      plugins.each_with_index.map do |plugin, index|
        parse(plugin, index, with_notes)
      end
    end

    def self.parse(plugin, index, with_notes)
      first_element = find_first_element(plugin)
      entry = [index + 1,
               first_element.attributes['href'].split('github.com/').last,
               first_element.inner_text]
      entry << plugin.last.inner_text if with_notes
      entry
    end

    def self.find_first_element
      plugin.first.children.reject do |element|
        element.inner_text.strip == ''
      end.first
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
        return plugin[2].split(' ').first.downcase if plugin[1] == path
      end
    end
  end
end
