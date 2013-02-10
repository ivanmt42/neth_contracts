class JobType < ActiveRecord::Base
	belongs_to :contract
	has_many :job_type_detail, :dependent => :delete_all
	validates_presence_of :label
end
