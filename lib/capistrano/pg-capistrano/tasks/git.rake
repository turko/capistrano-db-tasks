namespace :git do
  desc "Prune remote git cached copy (fixes errors with deleted branches)"
  task :prune do
    repository_cache = File.join(shared_path, 'cached-copy')
    logger.info "Pruning origin in remote cached-copy..."
    run "cd #{repository_cache}; git remote prune origin"
  end

  desc "Clear Capistrano Git cached-copy"
  task :clear_cache do
    repository_cache = File.join(shared_path, 'cached-copy')
    logger.info "Clearing Git Cache: #{repository_cache}"
    run "rm -rf #{repository_cache}"
  end
end