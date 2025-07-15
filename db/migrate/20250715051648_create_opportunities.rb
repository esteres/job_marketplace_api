class CreateOpportunities < ActiveRecord::Migration[8.0]
  def change
    create_table :opportunities do |t|
      t.string :title
      t.string :description
      t.integer :salary
      t.integer :job_applications_count
      t.references :client, null: false, foreign_key: true

      t.timestamps
    end

    add_index :opportunities, :title
    add_index :oppoprtunities, :salary
  end
end
