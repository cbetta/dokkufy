module Dokkufy
  class Git

    def dokku_remote_present?
      !dokku_remote.nil?
    end

    def dokku_remote
      @dokku_remote ||= git_remote
    end

    def dokku_remote=(remote)
      @dokku_remote = remote
      self.git_remote=(remote)
    end

    def clear
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

    def git_remote=(remote)
      puts "Setting git remote"
      `git remote add dokku #{remote}`
    end
  end
end
