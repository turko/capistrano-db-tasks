module Util
  def self.prompt(msg, prompt = "(y)es, (n)o ")
    ask(:answer, "#{msg} #{prompt} ? ")
    (fetch(:answer) =~ /^y$|^yes$/i) == 0
  end
  def self.current_git_branch
    `git symbolic-ref HEAD 2> /dev/null`.strip.gsub(/^refs\/heads\//, '')
  end
end
