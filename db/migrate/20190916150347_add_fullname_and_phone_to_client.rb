class AddFullnameAndPhoneToClient < ActiveRecord::Migration[6.0]
  def change
    add_column :clients, :fullname, :string, null: false
    add_column :clients, :phone,    :string, null: false
  end
end
