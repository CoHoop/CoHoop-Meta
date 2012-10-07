# This migration comes from forem (originally 20121007222114)
class CreateForemConfigurations < ActiveRecord::Migration
  def change
    create_table :forem_configurations do |t|
      t.boolean :post_approval

      t.timestamps
    end
  end
end
