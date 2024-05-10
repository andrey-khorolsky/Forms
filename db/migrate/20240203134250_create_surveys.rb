class CreateSurveys < ActiveRecord::Migration[7.0]
  def change
    create_table :surveys, id: :uuid, default: "gen_random_uuid()" do |t|
      t.string :name, null: false
      t.string :question_mongo_id, null: false
      t.boolean :actived, null: false, default: true
      t.boolean :private, null: false, default: false
      t.string :wallpaper
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
