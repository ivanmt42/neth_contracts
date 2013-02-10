class ContractDrawer

	def self.draw(customer, contract, contract_details, job_type_details)
		
		@job_type = JobType.find(:all, :conditions => ["id = ?", contract.job_type_id])
		@job_type.each do |jt|
			@job_type_label = jt.label
		end
		
		if contract.start_date
			@start_date = contract.start_date.strftime('%B %d, %Y')
		else
			@start_date = '          '
		end
		
		if contract.completion_date
			@completion_date = contract.completion_date.strftime('%B %d, %Y')
		else
			@completion_date = '          '
		end
		
		customer.each do |c|
			@first_name = c.first_name
			@last_name = c.last_name
			@phone_primary = c.phone_primary
			@phone_alt = c.phone_alt
			@street_1 = c.street_1
			@street_2 = c.street_2
			@city = c.city
			@state = c.state
			@zip = c.zip
		end
		
		pdf = PDF::Writer.new
		s1 = PDF::Writer::StrokeStyle.new(1)
		pdf.stroke_style(s1)
		
		gray = Color::RGB.new(204, 204, 204)
		black = Color::RGB.new(0, 0, 0)
		
		pdf.move_pointer(50)
		pdf.text("<b>NETH AND SON, INC.</b>", :font_size => 12, :justification => :center)
		pdf.text("<b>146 Taylor Drive, Depew, New York 14043</b>", :font_size => 9, :justification => :center)
		pdf.text("<b>(716) 685-3539</b>", :font_size => 9, :justification => :center)
		pdf.move_pointer(50)
		pdf.text( Date.today.strftime('%B %d, %Y'), :font_size => 12, :justification => :right, :right => 40 )
		pdf.move_pointer(35)
		pdf.text( customer_full_name(@first_name, @last_name), :left => 40 )
		pdf.text( @street_1 + @street_2, :left => 40)
		pdf.text( @city + ", " + @state + " " + @zip, :left => 40)
		pdf.move_pointer(35)
		pdf.text("Thank you very much for the opportunity to bid on the work at your home.", :left => 40)
		pdf.move_pointer(8)
		pdf.text("If you have any questions regarding the estimate, or if we can be of service at any time, please give us a call.", :left => 40, :right => 40)
		pdf.move_pointer(8)
		pdf.text("You may be interested to know that we will be happy to accept Visa or Master Card.", :left => 40)
		pdf.move_pointer(8)
		pdf.text("Thank you, again, for considering our company.", :left => 40)
		pdf.move_pointer(35)
		pdf.text("Sincerely,", :left => 300)
		pdf.text("Neth and Son, Inc.", :left => 300)
		pdf.move_pointer(35)
		pdf.text("Bob Emser", :left => 300)		
		
		pdf.start_new_page
		pdf.image("E:/BitNami/rubystack-1.8.7-3/projects/neth_contracts/public/images/HIC_LOGO_small.png", :justification => :left, :resize => 0.50)
		pdf.move_pointer(-40)
		pdf.text("<b>NETH AND SON, INC.</b>", :font_size => 12, :justification => :center)
		pdf.text("<b>146 Taylor Drive, Depew, New York 14043</b>", :font_size => 9, :justification => :center)
		pdf.text("<b>(716) 685-3539</b>", :font_size => 9, :justification => :center)
		
		pdf.move_pointer(25)
		pdf.text("This contract, made on " + "<c:uline>    " + Date.today.strftime('%B %d, %Y') + "    </c:uline>" + " between Neth & Son, Inc. and the Owner, ", :left => 30, :font_size => 10, :spacing => 1)
		
		pdf.move_pointer(5)
		pdf.text( "<c:uline>   " + customer_full_name(@first_name, @last_name) + ",             " + printable_address(@street_1, @street_2, @city, @state, @zip) + "             Phone: " + @phone_primary + "             </c:uline>")
		
		pdf.move_pointer(5)
		pdf.text("Starting date " + "<c:uline>    " + @start_date + "    </c:uline>" + " Substantial completion date " + "<c:uline>    " + @completion_date + "    </c:uline>" + printable_is_essence(contract))
		
		pdf.move_pointer(5)
		pdf.text("Work according to the following specifications and conditions.  Contractor agrees to supply Labor & Material for the following:")
		
		pdf.move_pointer(5)
		pdf.text(@job_type_label + ":", :left => 20, :font_size => 9)
		
		for cd in contract_details
			for jtd in job_type_details
				if cd.job_type_detail_id.to_i == jtd.id.to_i
					if jtd.optional == false
						pdf.text("<C:bullet /> " + swap_detail_option(jtd, cd), :left => 35, :font_size => 8, :spacing => 1)
					end
				end
			end
		end
		pdf.text("Cost: " + contract.total_cost, :left => 20, :font_size => 9, :spacing => 1.25)
		pdf.move_pointer(4)
		for cd in contract_details
			for jtd in job_type_details
				if cd.job_type_detail_id.to_i == jtd.id.to_i
					if jtd.optional == true
						pdf.text("<C:bullet /> " + swap_detail_option(jtd, cd), :left => 35, :font_size => 8, :spacing => 1)
					end
				end
			end
		end
		
		pdf.move_pointer(10)
		pdf.fill_color(gray)
		pdf.rectangle(pdf.left_margin - 2, pdf.y - 2, pdf.margin_width + 2, -15).fill
		pdf.fill_color(black)
		pdf.text("<b>PAYMENT FOR MATERIALS, LABOR AND EXPENSES AS DESCRIBED ABOVE:</b>", :font_size => 9, :spacing => 1.25)

		
		pdf.move_pointer(3)		
		pdf.start_columns(2)
		pdf.text("Buyer agrees to pay Contractor", :font_size => 8, :spacing => 1.25)
		pdf.start_new_page
		pdf.text("$ _________________ (Contract Price) for the Work, as follows:", :left => -150, :spacing => 1.25)
		pdf.stop_columns
		
		pdf.start_columns(2)
		pdf.text("A. Down Payment", :spacing => 1.25)
		pdf.start_new_page
		pdf.text("$ <c:uline>        " + contract.down_payment + "        </c:uline> when Buyer signs this contract.", :left => -150, :spacing => 1.25)
		pdf.stop_columns
		
		pdf.start_columns(2)
		pdf.text("B. Second Payment", :spacing => 1.25)
		pdf.start_new_page
		pdf.text("$ _________________ when ______________________________________________", :left => -150, :spacing => 1.25)
		pdf.stop_columns
		
		pdf.start_columns(2)
		pdf.text("C. Third Payment", :spacing => 1.25)
		pdf.start_new_page
		pdf.text("$ _________________ when ______________________________________________", :left => -150, :spacing => 1.25)
		pdf.stop_columns
		
		pdf.start_columns(2)
		pdf.text("D. Fourth Payment", :spacing => 1.25)
		pdf.start_new_page
		pdf.text("$ <c:uline>         BALANCE        </c:uline> when <c:uline>                               JOB COMPLETE                                 </c:uline>", :left => -150, :spacing => 1.25)
		pdf.stop_columns		
		
		pdf.move_pointer(10)
		pdf.fill_color(gray)
		pdf.rectangle(pdf.left_margin - 2, pdf.y - 2, pdf.margin_width + 2, -15).fill
		pdf.fill_color(black)
		pdf.text("<b>NOTICES:</b>", :font_size => 9, :spacing => 1.25)
		pdf.move_pointer(6)
		pdf.text("1. Owner's failure to tender payment to a performing Contractor of Subcontractor may subject the Owners property to applicable liens by the Contractor or Subcontractor in order to enforce payments.", :font_size => 8, :spacing => 1)
		pdf.move_pointer(3)
		pdf.text("2. Payments received from Owner under this contract, prior to substantial completion of the work under this contract, shall be deposited within five (5) business days of receipt in an escrow account at <c:uline>         M & T Bank        </c:uline>.  Monies used in escrow become the property of the contractor when (a) they are applied and transferred according to the contract payment schedule or (b) a breach of contract by the Owner occurs and the Owner is given seven (7) days written notice of the breach by the Contractor or (c) the contract has been substantially performed.")
		pdf.move_pointer(3)
		pdf.text("3. Notice of cancellation (see attached copy).")
		pdf.move_pointer(3)
		pdf.text("4. Owner and Contractor expressly agree that the contents of this Agreement, subject to the terms and conditions stated on both the face and reverse sides of this document, comprise the complete, exclusive and mutual understanding of the corresponding obligations of the parties.  This Agreement shall not become binding upon the Contractor until it is accepted by an authorized agent of the Contractor. By executing this Agreement, Owner, acknowledges that Owner has read its terms and conditions, further understands and agrees to perform Owner's obligations hereunder, and acknowledges that Owner has received a true copy of this Agreement.  In the event this transaction is financed, all financing documents shall be considered a part of this Agreement.")
		pdf.move_pointer(3)
		pdf.text("<b>OWNER MAY CANCEL THIS TRANSACTION AT ANY TIME PRIOR TO MIDNIGHT ON THE THIRD BUSINESS DAY AFTER THE DATE OF THIS AGREEMENT. SEE ATTACHED NOTICE OF CANCELLATION FORM FOR AN EXPLANATION OF THIS RIGHT.</b>")
		
		pdf.move_pointer(5)
		pdf.fill_color(gray)
		pdf.rectangle(pdf.left_margin - 2, pdf.y - 2, pdf.margin_width + 2, -15).fill
		pdf.fill_color(black)
		pdf.text("<b>ACKNOWLEDGEMENT AND AGREEMENT TO DATES, PAYMENT, NOTICES AND RIGHT TO CANCEL:</b>", :font_size => 9, :spacing => 1.25)
		pdf.move_pointer(20)
		pdf.text("Owner __________________________________ Date _______________ By _______________________________ Date _______________", :font_size => 8, :spacing => 1)
		pdf.text("Neth and Son, Inc.", :left =>320, :font_size => 6)
		pdf.move_pointer(15)
		pdf.text("Owner __________________________________ Date _______________", :font_size => 8)
		
		pdf.start_new_page
		pdf.start_columns(2)
		pdf.text("<b>NOTICE OF CANCELLATION:</b>", :font_size => 9)
		pdf.start_new_page
		pdf.text("<b>Date of Agreement:</b> ____________________________", :font_size => 9)
		pdf.stop_columns
		
		pdf.move_pointer(20)
		pdf.text("OWNER MAY CANCEL THIS TRANSACTION, WITHOUT ANY PENALTY OR OBLIGATION, WITHIN THREE BUSINESS DAYS FROM THE ABOVE DATE.", :font_size => 9)
		pdf.move_pointer(5)
		pdf.text("IF OWNER CANCELS, ANY PROPERTY TRADED IN, ANY PAYMENTS MADE BY OWNER UNDER THE CONTRACT OR SALE, AND ANY NEGOTIABLE INSTRUMENT EXECUTED BY OWNER WILL BE RETURNED WITHIN TEN BUSINESS DAYS FOLLOWING THE RECEIPT BY THE CONTRACTOR OF OWNER'S CANCELLATION NOTICE, AND ANY SECURITY INTEREST ARISING OUT OF THE TRANSACTION WILL BE CANCELLED.")
		pdf.move_pointer(5)
		pdf.text("IF OWNER CANCELS, OWNER MUST MAKE AVAILABLE TO THE CONTRACTOR AT OWNER'S RESIDENCE, IN SUBSTANTIALLY AS GOOD CONDITION AS WHEN RECEIVED, ANY GOODS DELIVERED TO THE CONTRACTOR UNDER THIS CONTRACT OR SALE' OR MAY IF OWNER WISHES, COMPLE WITH THE INSTRUCTIONS OF THE CONTRACTOR REGARDING THE RETURN SHIPMENT OF THE GOODS AT THE CONTRACTOR'S EXPENSE AND RISK.")
		pdf.move_pointer(5)
		pdf.text("IF OWNER DOES MAKE THE GOODS AVAILABLE TO THE CONTRACTOR AND THE CONTRACTOR DOES NOT PICK THEM UP WITHIN TWENTY DAYS OF THE DATE OF YOUR NOTICE FO CANCELLATIONS, OWNER MAY RETURN OR DISPOSE OF THE GOODS WITHOUT ANY FURTHER OBLIGATION. IF OWNER FAILS TO MAKE THE GOODS AVAILABLE TO THE CONTRACTORS, OR IF OWNER AGREES TO RETURN THE GOODS TO THE CONTRACTOR AND FAILS TO DO SO, THEN THE OWNER REMAINS LIABLE FOR THE PERFORMANCE OF ALL OBLIGATIONS UNDER THIS CONTRACT.")
		pdf.move_pointer(5)
		pdf.text("TO CANCEL THIS TRANSACTION, MAIL OR DELIVER A SIGNED AND DATED COPY OF THIS CANCELLATION NOTICE OR ANY OTHER WRITTEN NOTICE, OR SEND A TELEGRAM TO: NETH & SON, INC., 146 TAYLOR DR., DEPEW, NEW YORK 14043 (716) 685-3539 NOT LATER THAN MIDNIGHT OF: (DATE) __________________")
		pdf.move_pointer(30)
		pdf.text("______________________________________________________	DATE _____________________________", :font_size => 9)
		pdf.text("(OWNER'S SIGNATURE)", :font_size => 6)
		pdf.move_pointer(15)
		pdf.text("______________________________________________________	DATE _____________________________", :font_size => 9)
		pdf.text("(OWNER'S SIGNATURE)", :font_size => 6)
		
		pdf.start_new_page
		pdf.text("<b>TERMS AND CONDITIONS</b>", :font_size => 11, :spacing => 1, :justification => :center)
		pdf.move_pointer(10)
		pdf.text("1.	PERFORMANCE OF WORK:  Contractor agrees to perform the work according to this contract. Contractor shall not be held liable in damages for delays in the performance of this contract due to causes beyond its reasonable control. Owner will not unreasonably refuse to allow Contractor to commence performance of this Contract, or unreasonably refuse to allow continuation of its performance.", :font_size => 9)
		pdf.move_pointer(5)
		pdf.text("2.	AUTHORIZATION BY CONTRACTOR: This agreement must be accepted or rejected by an officer of the Contractor or is duly authorized agent and authorization may be subject to that length of time which might be necessary to secure proper financing, plans and specifications or obtaining necessary zoning variances.")
		pdf.move_pointer(5)
		pdf.text("3.	AUTHORIZATION BY OWNER: Owner warrants that he is the homeowner, cooperative shareholder or residential tenant of the property of which the work is to be performed and that he is otherwise authorized on behalf of the owners to enter into this Agreement.")
		pdf.move_pointer(5)
		pdf.text("4.	GOOD FAITH: The Owner represents that the Owner knows of no impediment, legal or financial, which would prohibit Owner from fulfilling all of Owner's obligations under the Contract. The Owner's representations are made with the understanding that the Contractor is relying on them in accepting and performing this Agreement and in furnishing the materials and labor specified.")
		pdf.move_pointer(5)
		pdf.text("5.	PAYMENT: Owner expressly agrees that the terms, “Payment upon completion” or similar language describing the same general idea, means that all monies due are payable to Contractor on demand when the job is substantially complete or substantially performed. At the time of demand, Owner may withhold a sum of money equal to the fair value of work to be completed until the work is so complete. In order to withhold any money, the Owner must present the Contractor with a written list of the work he is withholding funds for and include a signed statement that it is the complete list of all the work to be done, providing that the work is part of the Contract.")
		pdf.move_pointer(5)
		pdf.text("6.	LATE CHARGES: Owner will pay Contractor a late charge of 1 ½% per month on any of the contract price not paid when due.")
		pdf.move_pointer(5)
		pdf.text("7.	ATTORNEY'S FEES: If Owner defaults in payment as provided for in this Contract, Owner must be charged attorney's collection fees upon the unpaid balance, whether upon a note or otherwise, in the amount of 30% of the sum then due.")
		pdf.move_pointer(5)
		pdf.text("8.	UTILITIES: Owner agrees that Contractor shall utilize present house plumbing and electrical lines and Contractor cannot be held responsible for poor water pressure, old plumbing or old electrical wring.  Any change of utilities, if needed, will be done at additional cost to Owner, unless expressly stated in this Contract.")
		pdf.move_pointer(5)
		pdf.text("9.	MATERIALS: All work and material delivered to the premises, whether actually incorporated in the property or not, are to be considered the property of the Contractor until is has been paid for. Owner agrees that the Contractor shall have access to the Contractor's materials at all reasonable times until the same have been paid for in full. All excess materials not incorporated into the work performed shall be considered the property of the Contractor, and Contractor may remove any material if the Contract is not paid when due. Surplus and unused materials belong to the Contractor and the Contractor has the right to enter the premises to remove it after completion.")
		pdf.move_pointer(5)
		pdf.text("10.	LANDSCAPE: Working on the house exterior will require access that may harm landscaping. The Contractor shall not be responsible for any damage that may occur to bushes, shrubs, flowers, or lawn while working on the job in fulfillment of this Contract.")
		pdf.move_pointer(5)
		pdf.text("11.	SELECTION OF MATERIALS: Slight differences may occur in the pattern grain or color shade from the sample the Owner has chosen. The Contractor shall not be responsible for the varied and different grains, designs, characteristics, color tones and patterns of products.")
		pdf.move_pointer(5)
		pdf.text("12.	ASBESTOS CLAUSE: The Contractor is not responsible for inspection, discovery, abatement, or removal of asbestos. If possible asbestos is identified, the Contractor will leave the job until it is licensed.  EPA-approved contractor makes the area asbestos-free. Upon the contractor's return, if additional work is required, it will be handled by a change order to the original Contract.")
		pdf.move_pointer(5)
		pdf.text("13.	ICE BACK-UP: Contractor is not responsible for any resulting damage (interior or exterior) caused by Ice Back-up. Products such as Ice and Water Shield are installed as preventative maintenance, therefore, there is no guarantee against Ice Back-up.")
		pdf.move_pointer(5)
		pdf.text("14.	CHANGE ORDERS: Any extra labor cost will be charged at the current rates in effect at the time plus materials.")
		
		pdf.move_pointer(40)
		pdf.rectangle(pdf.left_margin - 2, pdf.y - 2, pdf.margin_width + 2, -165).stroke
		pdf.move_pointer(3)
		pdf.text("5 YEAR WORKMANSHIP WARRANTY: Contractor guarantees that the materials used in performance of this Contract will be of good quality, and will be applied/installed in a workmanlike manner according to common practice or manufacturer's recommended procedure.  The following limitations or conditions apply:")
		pdf.move_pointer(5)
		pdf.text("A.	Length of Warranty: <b>Neth & Son, Inc.</b> will warrant its workmanship on roofing and siding for a <b>5-year</b> period. Warranties on interior remodeling, additions, and windows will be for a <b>1-year</b> period. The Contractor will service workmanship, if faulty, at no cost to the customer from date of completion, provided full payment has been received.")
		pdf.move_pointer(5)
		pdf.text("B.	Manufacturer's Warranties: This warranty does not apply to products which are covered by separate warranty by the manufacturer. If product failure is due to manufacturing defects, <b>Neth & Son, Inc.</b> will notify the manufacturer to inspect and expedite repair or replacement during the length of the workmanship warranty.")
		pdf.move_pointer(5)
		pdf.text("C.	Charges: There will be a charge to the customer for service not covered at the current labor rate in effect at the time. Service required for product abuse, excessive interior humidity levels, winds exceeding 60 miles per hour, or other abnormal weather conditions can be chargeable to the customer.")
		pdf.move_pointer(5)
		pdf.text("D.	Exclusions: Contractor does not guarantee any material, product, or method provided or specified by the Owner.")
		
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
	
	
	def self.printable_is_essence(contract)
		is_essence = contract.is_essence
		if is_essence == true
			label = " of the essence <c:uline>    X    </c:uline> not of the essence <c:uline>         </c:uline>"
		else
			label = " of the essence <c:uline>         </c:uline> not of the essence <c:uline>    X    </c:uline>"
		end
		return label		
	end
	
	
	def self.swap_detail_option(job_type_detail, contract_details)
		detail = job_type_detail.detail
		if detail.match(/\(\)/)
			split_detail = detail.split("()")
			first_part = split_detail[0]
			second_part = split_detail[1]
			if (contract_details.job_type_detail_id.to_i == job_type_detail.id.to_i)
				detail_option = contract_details.detail_option ? contract_details.detail_option : ''
				detail = first_part + " (" + detail_option + ") " + second_part
				return detail
			end
		end
		return detail	
	end
end