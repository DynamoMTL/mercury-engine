module Cms
  class Engine < ::Rails::Engine
    isolate_namespace Cms

    initializer :cms do
      ActiveAdmin.application.load_paths += Dir[File.expand_path('../../cms/admin', __FILE__)]
    end
  end
end
