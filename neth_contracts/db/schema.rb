# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20090322015904) do

  create_table "appointments", :force => true do |t|
    t.integer  "customer_id"
    t.string   "datetime"
    t.string   "estimator"
    t.string   "job_class"
    t.string   "job_type"
    t.string   "referral"
    t.string   "referral_option"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contract_details", :force => true do |t|
    t.integer  "contract_id"
    t.integer  "job_type_detail_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "detail_option"
    t.integer  "position"
  end

  create_table "contracts", :force => true do |t|
    t.date     "start_date"
    t.date     "completion_date"
    t.boolean  "is_essence"
    t.string   "total_cost"
    t.string   "down_payment"
    t.integer  "customer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "job_type_id"
  end

  create_table "customers", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "phone_primary"
    t.string   "phone_alt"
    t.string   "street_1"
    t.string   "street_2"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_type_details", :force => true do |t|
    t.integer  "job_type_id"
    t.string   "detail"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "optional"
  end

  create_table "job_types", :force => true do |t|
    t.string   "label"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
