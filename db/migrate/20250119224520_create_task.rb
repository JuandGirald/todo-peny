class CreateTask < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.text :description
      t.string :project_name
      t.datetime :start_time
      t.datetime :end_time
      t.integer :status, default: 0
      t.integer :position, default: 0

      t.timestamps
    end

    add_index :tasks, :status
  end
end
