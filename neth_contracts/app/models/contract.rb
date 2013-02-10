class Contract < ActiveRecord::Base
	belongs_to :customer
	has_one :job_type
	
	has_many :contract_details, :dependent => :destroy
	has_many :job_type_details, :through => :contract_details
	
	accepts_nested_attributes_for :contract_details, :allow_destroy => :true,
		:reject_if => proc { |attrs| attrs.all? {|k, v| v.blank} }
	
	validates_presence_of :job_type_id
	
	### I'm not sure if these are still needed as I'm using nested attributes to update the contract_details table.
	# def job_type_detail_ids=(job_type_detail_ids)
		# job_type_detail_ids.map!(&:to_i)
		# contract_details.each do |cd|
			# cd.destroy unless job_type_detail_ids.include? cd.job_type_detail_id
		# end
		
		# job_type_detail_ids.each do |jd|
			# self.contract_details.create(:job_type_detail_id => jd) unless contract_details.any? { |d| d.job_type_detail_id == jd}
		# end
	# end
	
	# def detail_options=(detail_options)
		# detail_options.each_value do |option|
		# arn(option[detail_option])
			# elf.contract_details.update(:detail_option => option[detail_option]) unless contract_details.any? { |o| o.detail_option == option[detail_option] }
		# end
	# end
	
	### These are better than the find_by_sql methods below. Consider fixing then swapping them out.
	# def self.get_available_details(contract)
		# job_type_id = contract.job_type_id
		# @available_contract_details = JobTypeDetail.find(:all,
			# :conditions => ["job_type_id = ?", job_type_id])
	# end
	
	# def self.get_selected_details(contract_id)
		# @selected_contracts_details = ContractDetail.find(:all,
			# :conditions => ["contract_id = ?", contract_id])
	# end
	
	
	def self.get_available_details(job_type_id)
		find_by_sql [ "SELECT jtd.job_type_id, jtd.detail FROM job_types jt LEFT OUTER JOIN job_type_details jtd
					ON jtd.job_type_id = jt.id
					WHERE jt.id = ?", "#{job_type_id}" ]
	end 
	
	def self.get_selected_details(contract_id)
		find_by_sql [ "SELECT cd.contract_id, cd.job_type_detail_id, j.detail
					FROM contract_details cd LEFT OUTER JOIN job_type_details j
					ON cd.job_type_detail_id = j.id
					WHERE cd.contract_id = ?", "#{contract_id}" ]
	end
end