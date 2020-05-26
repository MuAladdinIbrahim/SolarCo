class CreateCalculations < ActiveRecord::Migration[6.0]
  def change
    create_table :calculations do |t|
      t.references :system
      t.integer :system_circuits, :default => 0
      t.integer :panels_num, :default => 0                    
      t.integer :panel_watt, :default => 0
      t.integer :battery_Ah, :default => 0
      t.integer :batteries_num, :default => 0
      t.integer :inverter_watt, :default => 0
      t.integer :mppt_amp, :default => 0
      t.timestamps
    end
  end
end
