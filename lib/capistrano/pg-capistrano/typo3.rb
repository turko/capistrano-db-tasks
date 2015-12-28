namespace :typo3 do
  desc "clearCache"
  task :clearCache do
    on roles(:all) do
      typo3_cli = "#{fetch(:current_path)}/web/typo3/cli_dispatch.phpsh"
      within release_path do
        execute :php, typo3_cli, "extbase cacheapi:clearallcaches"
      end
    end
  end
end