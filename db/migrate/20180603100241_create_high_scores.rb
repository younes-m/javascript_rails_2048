class CreateHighScores < ActiveRecord::Migration[5.1]
  def change
    create_table :high_scores do |t|
      t.text :user
      t.integer :score

      t.timestamps
    end
  end
end
