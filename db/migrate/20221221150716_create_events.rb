class CreateEvents < ActiveRecord::Migration[7.0]
  def change
    create_table :events do |t|
      t.string :action, :null => false
      t.integer :number, :null => false

      t.timestamps
    end
  end
end
