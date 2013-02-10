class SearchController < ApplicationController
	def index
		@results = Customer.search(params[:query])
	
		respond_to do |format|
		  format.html
		end
	end
end
