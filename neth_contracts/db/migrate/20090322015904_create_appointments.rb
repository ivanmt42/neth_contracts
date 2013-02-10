class CreateAppointments < ActiveRecord::Migration
  def self.up
    create_table :appointments do |t|
	  t.integer :customer_id
      t.string :datetime
      t.string :estimator
      t.string :job_class
	    t.string :job_type
      t.string :referral
      t.string :referral_option
      t.string :message

      t.timestamps
    end
  end

  def self.down
    drop_table :appointments
  end
end
