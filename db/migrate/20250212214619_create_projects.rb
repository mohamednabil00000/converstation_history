# frozen_string_literal: true

class CreateProjects < ActiveRecord::Migration[7.2]
  def change
    create_table :projects do |t|
      t.string :name, null: false
      t.text :description
      t.string :status, null: false, default: 'active'
      t.references :owner, null: false, foreign_key: { to_table: :users, on_delete: :cascade }

      t.timestamps
    end
  end
end
