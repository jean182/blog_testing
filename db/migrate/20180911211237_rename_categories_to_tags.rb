class RenameCategoriesToTags < ActiveRecord::Migration[5.1]
  def change
    rename_table :categories, :tags
    rename_table :has_categories, :has_tags
    rename_column :has_tags, :category_id, :tag_id
  end
end
