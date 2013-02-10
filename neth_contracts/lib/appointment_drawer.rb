class AppointmentDrawer

	def self.draw(appointment, customer)

		first_name = customer.first_name
		last_name = customer.last_name
		phone_primary = customer.phone_primary
		phone_alt = customer.phone_alt
		street_1 = customer.street_1
		street_2 = customer.street_2
		city = customer.city
		state = customer.state
		zip = customer.zip

		
		pdf = PDF::Writer.new
		s1 = PDF::Writer::StrokeStyle.new(1)
		pdf.stroke_style(s1)
		
		gray = Color::RGB.new(204, 204, 204)
		black = Color::RGB.new(0, 0, 0)
		
		pdf.move_pointer(25)
		pdf.text("<b>CUSTOMER CONTACT INFO</b>", :font_size => 16)
		
		pdf.move_pointer(10)
		pdf.start_columns(2)
		pdf.text("Customer Name:", :font_size => 12, :spacing => 1.5)
		pdf.start_new_page		
		pdf.text( "<c:uline>    " + customer_full_name(first_name, last_name) + "    </c:uline>", :left => -170, :spacing => 1.5)
		pdf.stop_columns

		pdf.move_pointer(5)
		pdf.start_columns(2)
		pdf.text("Customer Address:", :font_size => 12, :spacing => 1.5)
		pdf.start_new_page		
		pdf.text( "<c:uline>    " + printable_address(street_1, street_2, city, state, zip) + "    </c:uline>", :left => -170, :spacing => 1.5)
		pdf.stop_columns

		pdf.move_pointer(5)
		pdf.start_columns(2)
		pdf.text("Customer phone:", :font_size => 12, :spacing => 1.5)
		pdf.start_new_page		
		pdf.text( "<c:uline>    " + phone_primary + "    </c:uline>", :left => -170, :spacing => 1.5)
		pdf.stop_columns
		
		pdf.move_pointer(10)
		pdf.text("Estimator: " + appointment.estimator)
		pdf.move_pointer(5)
		pdf.text("Appointment Type: " + appointment.job_class)
		pdf.move_pointer(5)
		pdf.text("Estimate Type: " + appointment.job_type)
		pdf.move_pointer(5)
		pdf.text("Date and Time: " + appointment.datetime)

		pdf.move_pointer(10)
		pdf.text("How did you hear about us?", :font_size => 12, :spacing => 1.25)
		pdf.text(display_referred_by(appointment), :left => 20, :spacing => 1.25)


		pdf.move_pointer(5)
		pdf.text("Message:", :font_size => 12, :spacing => 1.25)
		pdf.text(appointment.message, :left => 20, :spacing => 1.25)
		
		pdf.render
	end	
	
	
	private
	
	def self.customer_full_name(first_name, last_name)
		first_name.capitalize + ' ' + last_name.capitalize
	end
	
	
	def self.printable_address(street_1, street_2, city, state, zip)
		comma = ', '
		if street_2 != ''
			street_1 + comma + street_2 + comma + city + comma + state + ' ' + zip
		else
			street_1 + comma + city + comma + state + ' ' + zip
		end
	end
	
	def self.display_referred_by(appointment)
		referral = appointment.referral.to_s
		referral_option = appointment.referral_option.to_s
		if referral == "Referred by"
			referred_by = referral + ": " + referral_option
		else
			referred_by = referral
		end
		return referred_by
	end	
end