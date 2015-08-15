# This migration comes from voluntary_ranking_engine (originally 20130817115303)
class AddRankingProduct < ActiveRecord::Migration
  def up
    Product::Ranking.create(name: 'Ranking', text: 'Ranking')
    
    # MongoDB to the rescue?
    create_table :rankings, force:  true do |t|
      t.string :adjective # best
      t.string :topic
      t.string :scope
      t.string :negative_adjective # worst
      t.timestamps
    end
    
    create_table :ranking_items, force:  true do |t|
      t.integer :ranking_id
      t.integer :thing_id
      t.integer :position
      t.boolean :best
      t.integer :stars
      t.timestamps
    end
    
    #add_column :things, :position, :integer
    #add_column :things, :rating, :float
    
    create_table :user_ranking_items, force:  true do |t|
      t.integer :user_id
      t.integer :ranking_item_id
      t.integer :position
      t.boolean :best
      t.integer :stars
      t.integer :ranking_id # cache column
      t.integer :thing_id # cache column
      t.timestamps
    end
    
    add_index :user_ranking_items, [:user_id, :ranking_id, :position], unique: true
  end
  
  def down
    Product::Ranking.first.destroy
    
    [:rankings, :ranking_items, :user_ranking_items].each do |table|
      drop_table table
    end
  end
end
