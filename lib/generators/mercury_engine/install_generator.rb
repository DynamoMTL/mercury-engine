module MercuryEngine
  module Generators
    class InstallGenerator < Rails::Generators::Base
      def add_route
        route "mount MercuryEngine::Engine => '/'"
      end

      def add_migrations
        run 'bundle exec rake railties:install:migrations FROM=mercury_engine'
      end

      def run_migrations
         response = ask "Would you like to run the migrations now? [Y/n]"

         if response == "" || response.downcase == "y"
           run 'bundle exec rake db:migrate'
         else
           puts "Skipping rake db:migrate, don't forget to run it!"
         end
      end
    end
  end
end
