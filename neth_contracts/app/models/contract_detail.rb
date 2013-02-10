class ContractDetail < ActiveRecord::Base
	belongs_to :contract
	belongs_to :job_type_detail
	acts_as_list
end
