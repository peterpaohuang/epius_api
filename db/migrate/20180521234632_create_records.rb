class CreateRecords < ActiveRecord::Migration[5.0]
  def change
    create_table :records do |t|
      t.string :title
      t.text :transcription
      t.text :summary
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
