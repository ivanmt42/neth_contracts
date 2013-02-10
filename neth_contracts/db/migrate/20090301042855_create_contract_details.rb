class CreateContractDetails < ActiveRecord::Migration
  def self.up
    create_table :contract_details do |t|
      t.integer :contract_id
      t.integer :job_type_detail_id

      t.timestamps
    end
  end

  def self.down
    drop_table :contract_details
  end
end
