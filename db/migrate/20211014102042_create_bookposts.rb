class CreateBookposts < ActiveRecord::Migration[6.1]
  def change
    create_table :bookposts do |t|
      t.string :content
      t.string :title
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
