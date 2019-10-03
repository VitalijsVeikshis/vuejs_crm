class CreateInteractions < ActiveRecord::Migration[6.0]
  def change
    create_table :interactions do |t|
      t.belongs_to :client
      t.belongs_to :organization

      t.timestamps
    end
  end
end
