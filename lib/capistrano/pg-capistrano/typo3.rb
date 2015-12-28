namespace :typo3 do
  desc "clearCache"
  task :clearCache do
    on roles(:web) do
      typo3_cli = File.join(fetch(:release_path),'web/typo3/cli_dispatch.phpsh')
      INFO "#{typo3_cli}"
      within release_path do
        execute :php, typo3_cli, "extbase cacheapi:clearallcaches"
      end
    end
  end
end