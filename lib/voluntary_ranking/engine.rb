module VoluntaryRanking
  class Engine < ::Rails::Engine
    config.autoload_paths << File.expand_path("../..", __FILE__)
    config.autoload_paths << File.expand_path("../../../app/models/concerns", __FILE__)
     
    initializer 'configure ember-rails ranking', before: 'ember_rails.setup_vendor' do
      config.handlebars.templates_root << 'voluntary_ranking/templates'
    end
    
    config.to_prepare do
      User.send :include, Concerns::Model::User::Ranking
      
      ::Ability.add_after_initialize_callback(VoluntaryRanking::Ability.after_initialize)
    end
  end
end