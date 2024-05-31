class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers, id: :uuid, default: "gen_random_uuid()" do |t|
      t.references :user, type: :uuid, null: false, foreign_key: true
      t.references :survey, type: :uuid, null: false, foreign_key: true

      t.string :answer_mongo_id, null: false

      t.timestamps
    end
  end
end
