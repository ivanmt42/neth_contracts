class CreateJobTypeDetails < ActiveRecord::Migration
  def self.up
    create_table :job_type_details do |t|
      t.integer :job_type_id
      t.string :detail

      t.timestamps
    end
  end

  def self.down
    drop_table :job_type_details
  end
end
