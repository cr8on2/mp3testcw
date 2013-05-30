class CreatePlayers < ActiveRecord::Migration
  def change
    create_table :players do |t|
      t.string :mp3
      t.string :title

      t.timestamps
    end
  end
end
