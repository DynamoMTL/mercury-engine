# This migration comes from mercury_engine (originally 20130318125100)
class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string  :permalink
      t.integer :parent_id
      t.text    :content

      t.timestamps
    end
  end
end
