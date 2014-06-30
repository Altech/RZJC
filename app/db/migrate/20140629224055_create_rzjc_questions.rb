class CreateRzjcQuestions < ActiveRecord::Migration
  def change
    create_table :rzjc_questions do |t|
      t.string :exhibition

      t.timestamps
    end
  end
end
