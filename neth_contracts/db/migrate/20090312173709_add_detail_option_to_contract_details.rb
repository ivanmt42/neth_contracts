class AddDetailOptionToContractDetails < ActiveRecord::Migration
  def self.up
    add_column :contract_details, :detail_option, :string
  end

  def self.down
    remove_column :contract_details, :detail_option
  end
end
