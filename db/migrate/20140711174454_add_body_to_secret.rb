class AddBodyToSecret < ActiveRecord::Migration
  def change
    add_column :secrets, :body, :text, null: false
  end
end
