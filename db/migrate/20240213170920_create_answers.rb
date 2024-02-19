class CreateAnswers < ActiveRecord::Migration[7.0]
  def change
    create_table :answers, id: :uuid, default: "gen_random_uuid()" do |t|
      t.references :user, type: :uuid, null: false
      t.references :survey, type: :uuid, null: false
      t.string :answer_id, null: false

      t.timestamps
    end
  end
end
