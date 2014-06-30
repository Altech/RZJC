class CreateRzjcTeams < ActiveRecord::Migration
  def change
    create_table :rzjc_teams do |t|
      t.string :name
      t.string :address
      t.string :region
      t.references :player1, index: true
      t.references :player2, index: true
      t.references :question, index: true

      t.boolean :confirmed

      t.timestamps
    end
  end
end
