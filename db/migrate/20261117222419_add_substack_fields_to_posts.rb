# db/migrate/YYYYMMDDHHMMSS_add_substack_fields_to_posts.rb
class AddSubstackFieldsToPosts < ActiveRecord::Migration[8.1]
  def change
    add_column :posts, :external_url, :string
    add_column :posts, :is_html, :boolean, default: false, null: false
  end
end