class CreateProjects < ActiveRecord::Migration[5.2]
  def change
    create_table :projects do |t|
      t.string :name
      t.string :description
      t.integer :priority
      
      t.belongs_to :created_by, references: :users
      t.belongs_to :updated_by, references: :users
      t.timestamps
    end
  end
end
