require 'spec_helper'

describe User do
  subject { FactoryGirl.create(:user) }
   
  describe '#add_ranking_item' do
    before :each do
      @attributes = { adjective: 'best', negative_adjective: 'worst', topic: 'movie', scope: 'ever' }
    end
    
    context 'ranking available' do
      before :each do
        @ranking = FactoryGirl.create(:ranking, @attributes)
      end
      
      context 'add new item' do
        context 'global ranking item available' do
          it 'reuses it' do
            ranking_item = FactoryGirl.create(:ranking_item, ranking: @ranking)
            
            user_ranking_item = subject.add_ranking_item @attributes.merge(thing_name: ranking_item.thing.name, best: false, stars: 1)
            
            user_ranking_item.ranking_item_id.should == ranking_item.id
          end
        end
    
        context 'best and worst items available' do
          before :each do
            subject.add_ranking_item @attributes.merge(thing_name: 'Thing 1', best: true, stars: 5)
            subject.add_ranking_item @attributes.merge(thing_name: 'Thing 2', best: true, stars: 4)
            subject.add_ranking_item @attributes.merge(thing_name: 'Thing 3', best: true, stars: 3)
            subject.add_ranking_item @attributes.merge(thing_name: 'Thing 4', best: false, stars: 2)
            subject.add_ranking_item @attributes.merge(thing_name: 'Thing 5', best: false, stars: 1)
            subject.add_ranking_item @attributes.merge(thing_name: 'Thing 6', best: false, stars: 0)
          end
          
          context 'item is best' do
            context 'with stars 5' do
              it 'inserts it at position 2' do
                subject.add_ranking_item @attributes.merge(thing_name: 'Dummy', best: true, stars: 5)
                
                subject.ranking_items.where(ranking_id: @ranking.id, position: 2).first.thing.name.should == 'Dummy'
                
                subject.ranking_items.where(ranking_id: @ranking.id).order('position ASC').to_a.map{|i| i.thing.name}.should == [
                  'Thing 1', 'Dummy', 'Thing 2', 'Thing 3', 'Thing 4', 'Thing 5', 'Thing 6'
                ]
              end
            end
            
            context 'with stars 4' do
              it 'inserts it at position 3' do
                subject.add_ranking_item @attributes.merge(thing_name: 'Dummy', best: true, stars: 4)
                
                subject.ranking_items.where(ranking_id: @ranking.id, position: 3).first.thing.name.should == 'Dummy'
                
                subject.ranking_items.where(ranking_id: @ranking.id).order('position ASC').to_a.map{|i| i.thing.name}.should == [
                  'Thing 1', 'Thing 2', 'Dummy', 'Thing 3', 'Thing 4', 'Thing 5', 'Thing 6'
                ]
              end
            end
            
            context 'with stars 3' do
              it 'inserts it at position 4' do
                subject.add_ranking_item @attributes.merge(thing_name: 'Dummy', best: true, stars: 3)
                
                subject.ranking_items.where(ranking_id: @ranking.id, position: 4).first.thing.name.should == 'Dummy'
                
                subject.ranking_items.where(ranking_id: @ranking.id).order('position ASC').to_a.map{|i| i.thing.name}.should == [
                  'Thing 1', 'Thing 2', 'Thing 3', 'Dummy', 'Thing 4', 'Thing 5', 'Thing 6'
                ]
              end
            end
          end
          
          context 'item is worst' do
            context 'with stars 2' do
              it 'inserts it at position 4' do
                subject.add_ranking_item @attributes.merge(thing_name: 'Dummy', best: false, stars: 2)
                
                subject.ranking_items.where(ranking_id: @ranking.id, position: 4).first.thing.name.should == 'Dummy'
                
                subject.ranking_items.where(ranking_id: @ranking.id).order('position ASC').to_a.map{|i| i.thing.name}.should == [
                  'Thing 1', 'Thing 2', 'Thing 3', 'Dummy', 'Thing 4', 'Thing 5', 'Thing 6'
                ]
              end
            end
            
            context 'with stars 1' do
              it 'inserts it at position 5' do
                subject.add_ranking_item @attributes.merge(thing_name: 'Dummy', best: false, stars: 1)
                
                subject.ranking_items.where(ranking_id: @ranking.id, position: 5).first.thing.name.should == 'Dummy'
                
                subject.ranking_items.where(ranking_id: @ranking.id).order('position ASC').to_a.map{|i| i.thing.name}.should == [
                  'Thing 1', 'Thing 2', 'Thing 3', 'Thing 4', 'Dummy', 'Thing 5', 'Thing 6'
                ]
              end
            end
            
            context 'with stars 0' do
              it 'inserts it at position 6' do
                subject.add_ranking_item @attributes.merge(thing_name: 'Dummy', best: false, stars: 0)
                
                subject.ranking_items.where(ranking_id: @ranking.id, position: 6).first.thing.name.should == 'Dummy'
                
                subject.ranking_items.where(ranking_id: @ranking.id).order('position ASC').to_a.map{|i| i.thing.name}.should == [
                  'Thing 1', 'Thing 2', 'Thing 3', 'Thing 4', 'Thing 5',  'Dummy', 'Thing 6'
                ]
              end
            end
          end
        end
        
        context 'multiple items with same stars available' do
          context 'item is best' do
            it 'inserts it at position of lowest item with same stars + 1' do
              subject.add_ranking_item @attributes.merge(thing_name: 'Thing 1', best: true, stars: 5)
              subject.add_ranking_item @attributes.merge(thing_name: 'Thing 2', best: true, stars: 5)
              
              subject.add_ranking_item @attributes.merge(thing_name: 'Dummy', best: true, stars: 5)
              
              subject.ranking_items.where(ranking_id: @ranking.id).order('position ASC').to_a.map{|i| i.thing.name}.should == [
                'Thing 1', 'Thing 2', 'Dummy'
              ]
            end
          end
          
          context 'item is worst' do
            it 'inserts it at position of highest item with same stars' do
              subject.add_ranking_item @attributes.merge(thing_name: 'Thing 2', best: false, stars: 0)
              subject.add_ranking_item @attributes.merge(thing_name: 'Thing 1', best: false, stars: 0)
              
              subject.add_ranking_item @attributes.merge(thing_name: 'Dummy', best: false, stars: 0)
              
              subject.ranking_items.where(ranking_id: @ranking.id).order('position ASC').to_a.map{|i| i.thing.name}.should == [
                'Dummy', 'Thing 1', 'Thing 2'
              ]
            end
          end
        end
        
        context 'no items available' do
          context 'item is best' do
            it 'inserts it at position 1' do
              subject.add_ranking_item @attributes.merge(thing_name: 'Dummy', best: true, stars: 3)
              
              subject.ranking_items.where(ranking_id: @ranking.id, position: 1).first.thing.name.should == 'Dummy'
            end
          end
          
          context 'item is worst' do
            it 'inserts it at position 1' do
              subject.add_ranking_item @attributes.merge(thing_name: 'Dummy', best: false, stars: 1)
              
              subject.ranking_items.where(ranking_id: @ranking.id, position: 1).first.thing.name.should == 'Dummy'
            end
          end
        end
        
        context 'add existing item' do
          it 'returns an invalid user ranking item' do
            subject.add_ranking_item @attributes.merge(thing_name: 'Dummy', best: true, stars: 3)
            
            user_ranking_item = subject.add_ranking_item @attributes.merge(thing_name: 'Dummy', best: true, stars: 3)
            
            user_ranking_item.valid?.should be_false
          end
        end 
      end
    end
    
    context 'ranking unavailable' do
      it 'creates the ranking' do
        subject.add_ranking_item(@attributes.merge(thing_name: 'Dummy', best: true, stars: 3))
        
        ranking = Ranking.first
        
        @attributes.each do |attribute, value|
          ranking.send(attribute).should == value
        end
      end
    end
  end
end