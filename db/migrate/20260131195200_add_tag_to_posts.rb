class AddTagToPosts < ActiveRecord::Migration[8.1]
  def change
    add_column :posts, :tag, :string
  end
end
