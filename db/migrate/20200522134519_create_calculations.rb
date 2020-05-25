class CreateCalculations < ActiveRecord::Migration[6.0]
  def change
    create_table :calculations do |t|
      t.references :system
      t.integer :panels_num, :default => 0                    
      t.integer :panel_rate, :default => 0
      t.integer :battery_Ah, :default => 0
      t.integer :batteries_no, :default => 0
      t.integer :inverter_rate, :default => 0
      t.integer :inverters_num, :default => 0
      t.integer :mppt_rate, :default => 0
      t.integer :mppt_num, :default => 0
      t.timestamps
    end
  end
end
