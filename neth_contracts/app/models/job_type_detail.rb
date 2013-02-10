class JobTypeDetail < ActiveRecord::Base
	belongs_to :job_type	
	has_many :contract_details
	has_many :contracts, :through => :contract_details	
	validates_presence_of :job_type_id, :detail
end
