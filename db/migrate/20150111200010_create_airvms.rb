class CreateAirvms < ActiveRecord::Migration
  def change
    create_table :airvms, id: :uuid do |t|
      t.string :encrypted_user
      t.string :encrypted_password
      t.string :host

      t.timestamps
    end
  end
end
