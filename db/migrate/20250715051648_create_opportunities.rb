class CreateOpportunities < ActiveRecord::Migration[8.0]
  def change
    create_table :opportunities do |t|
      t.string :title
      t.string :description
      t.integer :salary
      t.references :client, null: false, foreign_key: true
      t.integer :job_applications_count

      t.timestamps
    end
  end
end
