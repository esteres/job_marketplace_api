class CreateOpportunities < ActiveRecord::Migration[8.0]
  def change
    create_table :opportunities do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.integer :salary, null: false
      t.integer :job_applications_count, default: 0, null: false
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end

    add_index :opportunities, :title
    add_index :opportunities, :salary
  end
end
