module MercuryEngine
  class Engine < ::Rails::Engine
    isolate_namespace MercuryEngine

    initializer :mercury_engine do
      ActiveAdmin.application.load_paths += Dir[File.expand_path('../../mercury_engine/admin', __FILE__)]
    end
  end
end
