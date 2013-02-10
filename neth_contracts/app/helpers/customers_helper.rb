module CustomersHelper
	def customer_full_name(customer)
		first_name = customer.first_name
		last_name = customer.last_name
		first_name.capitalize + ' ' + last_name.capitalize
	end
	
	### Don't think this is needed any more after removing the print preview html page.
	# def printable_address(customer)
		# street_1 = customer.street_1
		# street_2 = customer.street_2
		# city = customer.city
		# state = customer.state
		# zip = customer.zip
		# comma = ', '
		# if street_2 != ''
			# street_1 + comma + street_2 + comma + city + comma + state + ' ' + zip
		# else
			# street_1 + comma + city + comma + state + ' ' + zip
		# end
	# end
	
	# def printable_phone(customer)
		# phone_primary = customer.phone_primary
	# end
end
