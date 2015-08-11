require 'spec_helper'

describe 'UserRankingItem' do
  let(:user) { FactoryGirl.create(:user)}
  
  before :each do
    @attributes = { adjective: 'best', negative_adjective: 'worst', topic: 'movie', scope: 'ever' }
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
end