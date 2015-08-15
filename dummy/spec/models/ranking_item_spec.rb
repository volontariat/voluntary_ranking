require 'spec_helper'

describe RankingItem do
  describe '#save' do
    describe '#update_position' do
      context 'stars_sum is not the highest' do
        it 'sets the position to 1 position after the item with >= stars_sum' do
          i = FactoryGirl.create :ranking_item, thing: FactoryGirl.create(:thing, name: 'Thing 1'), stars_sum: 5
          i.update_position
          i = FactoryGirl.create :ranking_item, ranking: i.ranking, thing: FactoryGirl.create(:thing, name: 'Thing 2'), stars_sum: 3
          i.update_position
          
          i = FactoryGirl.create :ranking_item, ranking: i.ranking, thing: FactoryGirl.create(:thing, name: 'Thing 3'), stars_sum: 5
          i.update_position
          
          RankingItem.order('position ASC').map{|i| [i.position, i.thing.name]}.should == [
            [1, 'Thing 1'], [2, 'Thing 3'], [3, 'Thing 2']
          ]
        end
      end
      
      context 'stars_sum is the highest' do
        it 'sets the position to 1' do
          i = FactoryGirl.create :ranking_item, thing: FactoryGirl.create(:thing, name: 'Thing 1'), stars_sum: 4
          i.update_position
          
          i = FactoryGirl.create :ranking_item, ranking: i.ranking, thing: FactoryGirl.create(:thing, name: 'Thing 2'), stars_sum: 5
          i.update_position
          
          RankingItem.order('position ASC').map{|i| [i.position, i.thing.name]}.should == [
            [1, 'Thing 2'], [2, 'Thing 1']
          ]
        end
      end
    end
  end
end