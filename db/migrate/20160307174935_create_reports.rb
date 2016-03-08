class CreateReports < ActiveRecord::Migration
  def change
    create_table :reports do |t|
      t.float :temperature
      t.float :humidity
      t.float :pressure

      t.timestamps null: false
    end
  end
end
