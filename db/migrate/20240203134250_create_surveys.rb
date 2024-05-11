class CreateSurveys < ActiveRecord::Migration[7.0]
  def change
    create_table :surveys, id: :uuid, default: "gen_random_uuid()" do |t|
      t.string :name, null: false
      t.string :description
      t.string :wallpaper
      t.string :question_mongo_id, null: false

      t.boolean :actived, null: false, default: true
      t.boolean :private, null: false, default: false
      t.boolean :anonymous, null: false, default: false

      t.datetime :start_date
      t.datetime :end_date

      t.string :completion_time
      t.string :completion_by_person
      t.string :needed_votes

      t.timestamps
    end
  end
end
