class Customer < ActiveRecord::Base
	has_many :contracts, :dependent => :destroy
	has_many :appointments, :dependent => :destroy
			
	validates_format_of :first_name, :last_name,
		:with => /^\w+-?\w?/,
		:message => "is required"
		
	#~ validates_format_of :phone_primary,
		#~ :with => /^((\(\d{3}\))? ?(\d{3}-)?\d{3}-\d{4})$/,
		#~ :message => "must be in the form (716) 123-4567 or 716-123-4567"
		
	#~ validates_format_of :phone_alt,
		#~ :with => /^((\(\d{3}\))? ?(\d{3}-)?\d{3}-\d{4})$/,
		#~ :message => "must be in the form (716) 123-4567 or 716-123-4567",
		#~ :allow_blank => true
		
	validates_format_of :street_1,
		:with => /\w*\W*/,
		:message => "is required"
		
	validates_format_of :street_2,
		:with => /\w*\W*/,
		:message => "is required",
		:allow_blank => true
		
	validates_format_of :city,
		:with => /\w/,
		:message => "is required"
		
	validates_format_of :state,
		:with => /[A-Z]{2}/,
		:message => "must be capital letter abbreviation. ex: NY"
		
	validates_length_of :state,
		:maximum => 2
		
	validates_format_of :zip,
		:with => /^(\d{5}-\d{4})|(\d{5})$/, 
		:message => "must be at least 5 digits and may include optional 4 digits. ex: 14226 or 14226-1234"

	def self.search(query)
		find(:all,
			:conditions => ['first_name LIKE ? OR last_name LIKE ?', "%#{query}%", "%#{query}%"] )
	end	
end