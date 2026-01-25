class CreateProjects < ActiveRecord::Migration[8.1]
  def change
    create_table :projects do |t|
      t.string :title
      t.string :slug
      t.text :summary
      t.text :body
      t.datetime :published_at
      t.string :repo_link
      t.string :demo_link

      t.timestamps
    end
    add_index :projects, :slug, unique: true
  end
end
