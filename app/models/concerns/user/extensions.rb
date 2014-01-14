class User
  module Extensions
    extend ActiveSupport::Concern
    
    include Ranking
  end
end