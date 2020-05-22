class CreateCalculations < ActiveRecord::Migration[6.0]
  def change
    create_table :calculations do |t|
      t.references :system
      t.integer :panels_no, :default => 0                    
      t.integer :panel_rating_power, :default => 0
      t.string :panel_type
      t.integer :battery_rating_Ah, :default => 0
      t.integer :patterns_no, :default => 0
      t.integer :inverter_rating_power, :default => 0
      t.integer :inverters_no, :default => 0
      t.string :inverter_type
      t.integer :cc_rating_power, :default => 0
      t.integer :cc_no, :default => 0
      t.string :cc_type
      t.timestamps
    end
  end
end
