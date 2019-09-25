# frozen_string_literal: true

# inn - идентификационный номер налогоплательщика (ИНН)
# ogrn - основной государственный регистрационный номер (ОГРН)

class CreateOrganizations < ActiveRecord::Migration[6.0]
  def change
    create_table :organizations do |t|
      t.string :name,              null: false
      t.string :form_of_ownership, null: false
      t.string :inn,               null: false
      t.string :ogrn,              null: false

      t.timestamps
    end
  end
end
