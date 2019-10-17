class CreatePs4s < ActiveRecord::Migration[5.2]
  def change
    create_table :ps4s do |t|
      t.string "psId", null: false
      t.string "purpose", null: false
      t.boolean "vc", null: false
      t.integer "age", default: ""
      t.string "period", null: false
      t.text "comment", default: ""
      t.string "skill", null: false
      t.string "title", null: false
      t.timestamps
    end
  end
end
