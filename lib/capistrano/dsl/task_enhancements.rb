module Capistrano
  module TaskEnhancements
    def default_tasks
      %w{install local build buildDevelop}
    end
  end
end