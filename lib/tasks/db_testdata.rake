require 'active_record/fixtures'

namespace :db do
  desc "bootstrap database with sample source adapters"
  task :bootstrap => 'db:fixtures:samples' do
  end
  
  namespace :fixtures do
    desc "load sample source adapters"
    task :samples => 'db:migrate' do
      Fixtures.create_fixtures(File.join(File.dirname(__FILE__), '..', '..', 'db', 'migrate'), 'sources')
    end
  end
end