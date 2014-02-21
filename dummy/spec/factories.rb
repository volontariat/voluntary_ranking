def r_str
  SecureRandom.hex(3)
end

def resource_has_many(resource, association_name)
  association = if resource.send(association_name).length > 0
    nil
  elsif association_name.to_s.classify.constantize.count > 0
    association_name.to_s.classify.constantize.last
  else
    Factory.create association_name.to_s.singularize.to_sym
  end
  
  resource.send(association_name).send('<<', association) if association
end

FactoryGirl.define do
  Voluntary::Test::RspecHelpers::Factories.code.call(self)
  
  factory :ranking do
    adjective 'best'
    negative_adjective 'worst'
    sequence(:topic) { |n| "topic #{n}#{r_str}" } 
    scope 'ever'
  end
  
  factory :ranking_item do
    association :ranking
    association :thing
    best true
    stars 3
  end
  
  factory :user_ranking_item do
    association :user
    association :ranking_item
    association :ranking
    association :thing
    best true
    stars 3
  end
end