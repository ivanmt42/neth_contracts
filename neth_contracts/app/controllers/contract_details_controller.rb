class ContractDetailsController < ApplicationController
	def index
		@contract = Contract.find(params[:contract_id])
		@contract_details = ContractDetail.find(:all, :conditions => ["contract_id = ?", params[:contract_id]])
	end

	def show
		@contract = Contract.find(params[:contract_id])
		@contract_details = ContractDetail.find(:all, :conditions => ["contract_id = ?", params[:contract_id]])
	end  

	def new
		@contract_details = ContractDetail.new
	end
	
	def edit
	end
	
	def create
	end

	def update
		@contract = Contract.find(params[:contract_id])
		@contract_details = ContractDetail.find(:all, :conditions => ["contract_id = ?", params[:contract_id]])
		@contract_details.save_details
	end

	def destroy
	end
end
