class CreateVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :videos do |t|
      t.string :title
      t.text :description
      t.string :thumbnail
      t.string :url
      t.timestamps
    end
  end
end
