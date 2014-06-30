class CreateRzjcSoloPlayers < ActiveRecord::Migration
  def change
    create_table :rzjc_solo_players do |t|
      t.string :address
      t.string :name
      t.string :force_type
      t.string :pilot
      t.string :address
      t.boolean :confirmed
      t.string :region
      t.references :mecha_good_1, index: true
      t.references :mecha_good_2, index: true
      t.references :mecha_good_3, index: true
      t.references :mecha_wanted_1, index: true
      t.references :mecha_wanted_2, index: true
      t.references :mecha_wanted_3, index: true

      t.timestamps
    end
  end
end
