module Cms
  class Engine < ::Rails::Engine
    isolate_namespace Cms

    initializer :cms do
      ActiveAdmin.application.load_paths += Dir[File.dirname(__FILE__) + '/cms/admin']
    end
  end
end
