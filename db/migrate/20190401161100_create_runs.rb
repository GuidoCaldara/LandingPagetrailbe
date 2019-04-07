class CreateRuns < ActiveRecord::Migration[5.2]
  def change
    create_table :runs do |t|
      t.string :name
      t.string :starting_point
      t.string :starting_point_info
      t.integer :run_distance
      t.integer :elevation
      t.time :duration
      t.datetime :date
      t.float :latitude
      t.float :longitude
      t.text :description
      t.string :photo
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
