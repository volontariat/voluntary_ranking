require 'spec_helper'

describe Ranking do
  describe 'validations' do
    describe '#one_ranking_per_topic_scope_and_one_of_the_adjectives' do
      it 'does what the name says' do
        FactoryGirl.create(:ranking, topic: 'Dummy')
        
        [
          FactoryGirl.build(:ranking, topic: 'Dummy'),
          FactoryGirl.build(:ranking, adjective: 'x', topic: 'Dummy'),
          FactoryGirl.build(:ranking, negative_adjective: 'x', topic: 'Dummy')
        ].each do |ranking|
          ranking.valid?
          
          ranking.errors[:base].should include(
            I18n.t(
              'activerecord.errors.models.ranking.attributes.base.' + 
              'one_ranking_per_topic_scope_and_one_of_the_adjectives'
            )
          ), ranking.attributes.inspect 
        end
        
        FactoryGirl.build(:ranking, topic: 'Dummy2').valid?.should be_true
      end
    end
  end
end