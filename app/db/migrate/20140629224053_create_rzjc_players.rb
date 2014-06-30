class CreateRzjcPlayers < ActiveRecord::Migration
  def change
    create_table :rzjc_players do |t|
      t.string :name
      t.references :mecha, index: true
      t.string :force_type
      t.string :pilot

      t.timestamps
    end
  end
end
