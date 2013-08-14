class AddRankingProduct < ActiveRecord::Migration
  def up
    Product.create(name: 'Ranking', text: 'Ranking')
  end
  
  def down
    Product.where(name: 'Ranking').first.destroy
  end
end
