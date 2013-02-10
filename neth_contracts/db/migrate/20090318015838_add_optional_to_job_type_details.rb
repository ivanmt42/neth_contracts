class AddOptionalToJobTypeDetails < ActiveRecord::Migration
  def self.up
    add_column :job_type_details, :optional, :boolean
  end

  def self.down
    remove_column :job_type_details, :optional
  end
end
