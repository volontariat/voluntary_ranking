require 'spec_helper'

describe 'UserRankingItem' do
  let(:user) { FactoryGirl.create(:user)}
  
  before :each do
    @attributes = { adjective: 'best', negative_adjective: 'worst', topic: 'movie', scope: 'ever' }
  end
  
  describe '#save' do
    context 'ranking with 2 items' do
      it 'updates the stars sum and position of ranking item by stars' do
        ranking_item = FactoryGirl.create :ranking_item, thing: FactoryGirl.create(:thing, name: 'Thing 1')
        ranking = ranking_item.ranking
        FactoryGirl.create(
          :user_ranking_item, 
          ranking_item: ranking_item, stars: 4, ranking: ranking, thing: ranking_item.thing
        )
        
        ranking_item = FactoryGirl.create(
          :ranking_item, ranking: ranking, thing: FactoryGirl.create(:thing, name: 'Thing 2')
        )
        user_ranking_item1 = FactoryGirl.create(
          :user_ranking_item, 
          ranking_item: ranking_item, stars: 3, ranking: ranking, thing: ranking_item.thing
        )
        
        user_ranking_item2 = FactoryGirl.create(
          :user_ranking_item, 
          ranking_item: ranking_item, stars: 5, ranking: ranking, thing: ranking_item.thing
        )
        
        RankingItem.order('position ASC').map{|i| [i.position, i.thing.name, i.stars_sum]}.should == [
          [1, 'Thing 2', 8], [2, 'Thing 1', 4]
        ]
        
        user_ranking_item2.stars = 0
        user_ranking_item2.best = false
        user_ranking_item2.save!
        
        RankingItem.order('position ASC').map{|i| [i.position, i.thing.name, i.stars_sum]}.should == [
          [1, 'Thing 1', 4], [2, 'Thing 2', 3]
        ]
        
        user_ranking_item1.stars = 0
        user_ranking_item1.best = false
        user_ranking_item1.save!
        
        RankingItem.order('position ASC').map{|i| [i.position, i.thing.name, i.stars_sum]}.should == [
          [1, 'Thing 1', 4], [2, 'Thing 2', 0]
        ]
      end
    end
    
    context 'ranking with 3 items' do
      it 'updates the stars sum and position of ranking item by stars' do
        ranking_item = FactoryGirl.create :ranking_item, thing: FactoryGirl.create(:thing, name: 'Thing 1')
        ranking = ranking_item.ranking
        FactoryGirl.create(
          :user_ranking_item, 
          ranking_item: ranking_item, stars: 5, ranking: ranking, thing: ranking_item.thing
        )
        
        ranking_item = FactoryGirl.create(
          :ranking_item, 
          ranking: ranking, thing: FactoryGirl.create(:thing, name: 'Thing 2')
        )
        ranking = ranking_item.ranking
        FactoryGirl.create(
          :user_ranking_item, 
          ranking_item: ranking_item, stars: 0, best: false, ranking: ranking, thing: ranking_item.thing
        )
        
        RankingItem.order('position ASC').map{|i| [i.position, i.thing.name, i.stars_sum]}.should == [
          [1, 'Thing 1', 5], [2, 'Thing 2', 0]
        ]
        
        ranking_item = FactoryGirl.create(
          :ranking_item, ranking: ranking, thing: FactoryGirl.create(:thing, name: 'Thing 3')
        )
        user_ranking_item1 = FactoryGirl.create(
          :user_ranking_item, 
          ranking_item: ranking_item, stars: 2, best: false, ranking: ranking, thing: ranking_item.thing
        )
        
        RankingItem.order('position ASC').map{|i| [i.position, i.thing.name, i.stars_sum]}.should == [
          [1, 'Thing 1', 5], [2, 'Thing 3', 2], [3, 'Thing 2', 0]
        ]
        
        user_ranking_item2 = FactoryGirl.create(
          :user_ranking_item, 
          ranking_item: ranking_item, stars: 3, ranking: ranking, thing: ranking_item.thing
        )
        
        RankingItem.order('position ASC').map{|i| [i.position, i.thing.name, i.stars_sum]}.should == [
          [1, 'Thing 1', 5], [2, 'Thing 3', 5], [3, 'Thing 2', 0]
        ]
        
        user_ranking_item2.stars = 0
        user_ranking_item2.best = false
        user_ranking_item2.save!
        
        RankingItem.order('position ASC').map{|i| [i.position, i.thing.name, i.stars_sum]}.should == [
          [1, 'Thing 1', 5], [2, 'Thing 3', 2], [3, 'Thing 2', 0]
        ]
        
        user_ranking_item1.stars = 0
        user_ranking_item1.best = false
        user_ranking_item1.save!
        
        RankingItem.order('position ASC').map{|i| [i.position, i.thing.name, i.stars_sum]}.should == [
          [1, 'Thing 1', 5], [2, 'Thing 2', 0], [3, 'Thing 3', 0]
        ]
      end
    end
  end
  
  describe '#set_position' do
    it 'copies stars from the item in the list to replace' do
      user.add_ranking_item @attributes.merge(thing_name: 'Thing 1', best: true, stars: 5)
      user.add_ranking_item @attributes.merge(thing_name: 'Thing 2', best: true, stars: 4)
      user_ranking_item = user.add_ranking_item @attributes.merge(thing_name: 'Thing 3', best: true, stars: 3)
      
      user_ranking_item.set_position(2); user_ranking_item.reload
      
      user_ranking_item.position.should == 2
      user_ranking_item.stars.should == 4
      user_ranking_item.best.should be_truthy
    end
  end
  
  describe '#move_to_top_of_page' do
    context '1 page available' do
      it 'inserts item at 1st position' do
        user.add_ranking_item @attributes.merge(thing_name: 'Thing 1', best: true, stars: 5)
        user.add_ranking_item @attributes.merge(thing_name: 'Thing 2', best: true, stars: 4)
        user_ranking_item = user.add_ranking_item @attributes.merge(thing_name: 'Thing 3', best: true, stars: 3)
        
        user_ranking_item.move_to_top_of_page(1); user_ranking_item.reload
        
        user_ranking_item.position.should == 1
        user_ranking_item.stars.should == 5
        user_ranking_item.best.should == true
      end
    end
    
    context 'move 7th item to page 2 of 2' do
      before :each do
        user.add_ranking_item @attributes.merge(thing_name: 'Thing 1', best: true, stars: 5)
        user.add_ranking_item @attributes.merge(thing_name: 'Thing 2', best: true, stars: 5)
        user.add_ranking_item @attributes.merge(thing_name: 'Thing 3', best: true, stars: 5)
        user.add_ranking_item @attributes.merge(thing_name: 'Thing 4', best: true, stars: 5)
        user.add_ranking_item @attributes.merge(thing_name: 'Thing 5', best: true, stars: 5)
        user.add_ranking_item @attributes.merge(thing_name: 'Thing 6', best: true, stars: 5)
        @user_ranking_item = user.add_ranking_item @attributes.merge(thing_name: 'Thing 7', best: true, stars: 3)
        user.add_ranking_item @attributes.merge(thing_name: 'Thing 8', best: true, stars: 3)
        user.add_ranking_item @attributes.merge(thing_name: 'Thing 9', best: true, stars: 3)
        user.add_ranking_item @attributes.merge(thing_name: 'Thing 10', best: true, stars: 3)
        
        user.add_ranking_item @attributes.merge(thing_name: 'Thing 11', best: false, stars: 2)
        user.add_ranking_item @attributes.merge(thing_name: 'Thing 12', best: false, stars: 1)
      end
      
      it 'inserts item at position 1 of page 2' do
        @user_ranking_item.move_to_top_of_page(2); @user_ranking_item.reload
        
        @user_ranking_item.position.should == 11
        @user_ranking_item.stars.should == 2
        @user_ranking_item.best.should == false
      end
    end
  end
  
  describe '#destroy' do
    it 'destroys ranking item if it has no user ranking items anymore' do
      ranking_item = FactoryGirl.create :ranking_item
      user_ranking_item1 = FactoryGirl.create(
        :user_ranking_item, 
        ranking_item: ranking_item, ranking: ranking_item.ranking, thing: ranking_item.thing
      )
      user_ranking_item2 = FactoryGirl.create(
        :user_ranking_item, 
        ranking_item: ranking_item, ranking: ranking_item.ranking, thing: ranking_item.thing
      )
      
      user_ranking_item2.ranking_item.user_ranking_items.count.should == 2
      
      user_ranking_item2.destroy
      
      user_ranking_item1.ranking_item.user_ranking_items.count.should == 1
      
      user_ranking_item1.destroy
      
      RankingItem.count.should == 0
    end
  end
end