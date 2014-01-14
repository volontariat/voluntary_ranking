module Concerns
  module Controller
    module BaseRankingItemsController
      extend ActiveSupport::Concern
    
      def ranking; @ranking ||= Ranking.find_or_create_by_params(params); end
    end
  end
end