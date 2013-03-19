# This migration comes from cms (originally 20130318125100)
class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title, :permalink
      t.integer :parent_id
      t.text :content
      t.text :meta_description, :meta_keywords

      t.timestamps
    end
  end
end
