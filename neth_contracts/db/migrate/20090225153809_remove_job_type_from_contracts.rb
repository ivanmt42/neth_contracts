class RemoveJobTypeFromContracts < ActiveRecord::Migration
  def self.up
    remove_column :contracts, :job_type
  end

  def self.down
    add_column :contracts, :job_type, :string
  end
end
