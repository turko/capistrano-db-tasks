namespace :typo3 do
  namespace :clearCache do
    desc "clearAllCache"
    task :all do
      on roles(:web) do
        typo3_cli = File.join(release_path, 'web/typo3/cli_dispatch.phpsh')
        within release_path do
          execute :php, typo3_cli, "extbase cacheapi:clearallcaches"
        end
      end
    end
    desc "clearSystemCache"
    task :system do
      on roles(:web) do
        typo3_cli = File.join(release_path, 'web/typo3/cli_dispatch.phpsh')
        within release_path do
          execute :php, typo3_cli, "extbase cacheapi:clearsystemcache"
        end
      end
    end
    desc "clearOpcodeCache"
    task :opCode do
      on roles(:web) do
        typo3_cli = File.join(release_path, 'web/typo3/cli_dispatch.phpsh')
        within release_path do
          execute :php, typo3_cli, "extbase cacheapi:clearallactiveopcodecache"
        end
      end
    end
    desc "clearConfigurationCache"
    task :configuration do
      on roles(:web) do
        typo3_cli = File.join(release_path, 'web/typo3/cli_dispatch.phpsh')
        within release_path do
          execute :php, typo3_cli, "extbase cacheapi:clearconfigurationcache"
        end
      end
    end
    desc "clearPageCache"
    task :page do
      on roles(:web) do
        typo3_cli = File.join(release_path, 'web/typo3/cli_dispatch.phpsh')
        within release_path do
          execute :php, typo3_cli, "extbase cacheapi:clearpagecache"
        end
      end
    end
    desc "clearallexceptpagecache"
    task :AllButPages do
      on roles(:web) do
        typo3_cli = File.join(release_path, 'web/typo3/cli_dispatch.phpsh')
        within release_path do
          execute :php, typo3_cli, "extbase cacheapi:clearallexceptpagecache"
        end
      end
    end
  end
end
