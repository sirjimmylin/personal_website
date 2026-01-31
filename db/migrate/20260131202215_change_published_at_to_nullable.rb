class ChangePublishedAtToNullable < ActiveRecord::Migration[7.1]
  def change
    change_column_null :posts, :published_at, true
  end
end