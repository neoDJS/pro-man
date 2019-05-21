class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :uid
      t.belongs_to :worker
      t.string :password_digest
      
      t.belongs_to :created_by, references: :users
      t.belongs_to :updated_by, references: :users
      t.timestamps null: false
    end
  end
end
