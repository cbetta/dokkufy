module Dokkufy
  class Git

    def dokku_remote_present?
      !dokku_remote.nil?
    end

    def dokku_remote
      @dokku_remote ||= git_remote || dokkufile_remote
    end

    def dokku_remote=(remote)
      @dokku_remote = remote
      set_git_remote
      set_dokkufile_remote
    end

    def clear
      `rm .dokkurc`
      `git remote remove dokku`
    end

    private

    def git_remote
      output = `git remote -v`
      output.lines.each do |line|
        return line.split(" ")[1] if line.include?("dokku@")
      end
      nil
    end

    def dokkufile_remote
      output = File.open(".dokkurc").read
      return output.strip unless output.empty?
    rescue
      nil
    end

    def set_git_remote
      puts "Setting git remote"
      `git remote add dokku #{@dokku_remote}`
    end

    def set_dokkufile_remote
      puts "Writing .dokkurc"
      `echo #{@dokku_remote} > .dokkurc`
    end

  end
end
