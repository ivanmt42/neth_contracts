class AddPositionToContractDetails < ActiveRecord::Migration
  def self.up
    add_column :contract_details, :position, :integer
  end

  def self.down
    remove_column :contract_details, :position
  end
end
