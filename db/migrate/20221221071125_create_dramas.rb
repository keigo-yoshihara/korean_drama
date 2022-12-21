class CreateDramas < ActiveRecord::Migration[6.1]
  def change
    create_table :dramas do |t|
      t.string :title
      t.string :content
      t.string :rating
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
