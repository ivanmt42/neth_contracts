class CreateContracts < ActiveRecord::Migration
  def self.up
    create_table :contracts do |t|
      t.string :job_type
      t.date :start_date
      t.date :completion_date
      t.boolean :is_essence
      t.string :total_cost
      t.string :down_payment
      t.references :customer

      t.timestamps
    end
  end

  def self.down
    drop_table :contracts
  end
end
