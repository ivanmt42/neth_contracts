class AddJobTypeIdToContracts < ActiveRecord::Migration
  def self.up
    add_column :contracts, :job_type_id, :integer
  end

  def self.down
    remove_column :contracts, :job_type_id
  end
end
