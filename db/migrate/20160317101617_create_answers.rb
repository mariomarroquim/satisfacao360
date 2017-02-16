class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.references :user, index: true
      t.references :question, index: true
      t.integer :result, index: true
      t.text :observation, length: 1.megabyte
      t.timestamps null: false
    end
  end
end
