module ContractsHelper

	def get_job_label(contract)
		job_type_id = contract.job_type_id
		@job_type = JobType.find(:first, :conditions => ["id = ?", job_type_id])
		job_label = @job_type.label
	end

	def is_essence_label(contract)
	is_essence = contract.is_essence
		if is_essence == true
			label = "Yes"
		else
			label = "No"
		end
		return label
	end
	
	### Don't think this is needed any more after removing the print preview html page.
	# def printable_is_essence(contract)
		# is_essence = contract.is_essence
		# if is_essence == true
			# label = 'of the essence: <strong class="underline">&nbsp;X&nbsp;</strong>, not of the essence: <font class="underline">&nbsp;&nbsp;&nbsp;</font>'
		# else
			# label = 'of the essence: <font class="underline">&nbsp;&nbsp;&nbsp;</font>, not of the essence: <strong class="underline">&nbsp;X&nbsp;</strong>'
		# end
		# return label		
	# end
	
	def get_available_details(contract)
		job_type_id = contract.job_type_id
		@available_contract_details = JobTypeDetail.find(:all,
			:conditions => ["job_type_id = ?", job_type_id])
	end
	
	def get_selected_details(contract)
		contract_id = contract.id
		@selected_contracts_details = ContractDetail.find(:all,
			:conditions => ["contract_id = ?", contract_id])
	end

	def get_detail(contract_detail)
		job_type_detail_id = contract_detail.job_type_detail_id
		@job_type = JobTypeDetail.find(:first, 
			:conditions => ["job_type_detail_id = ?", job_type_detail_id])
		detail = @job_type.detail
	end

	def get_detail_option(contract)
		job_type_detail_id = contract.job_type_detail_id
		contract_id = contract.contract_id
		option = ContractDetail.find(:all, 
			:conditions => ["contract_id = ? AND job_type_detail_id = ?",
				contract_id, job_type_detail_id ], :select => "detail_option")
	end

	### Don't think this is needed any more after removing the print preview html page.
	# def show_detail_option(job_type_detail)
		# detail = job_type_detail.detail
		# if detail.match(/\(\)/)
			# split_detail = detail.split("()")
			# first_part = split_detail[0]
			# second_part = split_detail[1]
			# for cd in @contract_details
				# if (cd.job_type_detail_id.to_i == contract.job_type_detail_id.to_i)
					# detail_option = cd.detail_option ? cd.detail_option : ''
					# detail = first_part + ' (' + detail_option + ') ' + second_part
					# return detail
				# end
			# end
		# end
		# return detail	
	# end
	
	def swap_detail_option(job_type_detail)
		detail = job_type_detail.detail
		if detail.match(/\(\)/)
			split_detail = detail.split("()")
			first_part = split_detail[0]
			second_part = split_detail[1]
			for cd in @contract_details
				if (cd.job_type_detail_id.to_i == job_type_detail.id.to_i)
					detail_option = cd.detail_option ? cd.detail_option : ''
					detail = first_part + ' (' + detail_option + ') ' + second_part
					return detail
				end
			end
		end
		return detail	
	end
end
