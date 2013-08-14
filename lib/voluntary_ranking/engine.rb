module VoluntaryRanking
  class Engine < ::Rails::Engine
    initializer 'configure ember-rails ranking', before: 'ember_rails.setup_vendor' do
      config.handlebars.templates_root << 'voluntary_ranking/templates'
    end
  end
end
