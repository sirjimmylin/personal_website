class AddPublishedAtToProjects < ActiveRecord::Migration[8.1]
  def change
    # 1. Start the check
    unless column_exists?(:projects, :published_at)
      add_column :projects, :published_at, :datetime
    end # 2. Closes the 'unless' check

  end # 3. Closes the 'def change' method
end # 4. Closes the 'class'