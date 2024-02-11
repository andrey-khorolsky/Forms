class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users, id: :uuid, default: "gen_random_uuid()" do |t|
      t.string :name, null: false
      t.date :birthday

      t.timestamps
    end
  end
end
