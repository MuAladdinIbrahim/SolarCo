class CreateCalculations < ActiveRecord::Migration[6.0]
  def change
    create_table :calculations do |t|
      t.integer :system_circuits, :default => 1
      t.integer :panels_num, :default => 0                    
      t.integer :panel_watt, :default => 250
      t.integer :battery_Ah, :default => 200
      t.integer :batteries_num, :default => 0
      t.integer :inverter_watt, :default => 0
      t.integer :mppt_amp, :default => 0
      
      t.references :system, null: false, foreign_key: true
      t.timestamps
    end
  end
end
