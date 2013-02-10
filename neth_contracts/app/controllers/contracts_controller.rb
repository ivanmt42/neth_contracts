class ContractsController < ApplicationController

  def index
	@contracts = Contract.find(:all)

    respond_to do |format|
      format.html
    end
  end
  
  def sort
	params[:details].each_with_index do |id, index|
		ContractDetail.update_all(['position=?', index+1], ['id=?', id])
	end
	render :nothing => true
  end
  
  def show
	@contract = Contract.find(params[:id])
	@contract_details = @contract.contract_details.find(:all,
		:conditions => ["contract_id = ?", params[:id]], :order => "position")
	@customer = Customer.find(:all, :conditions => ["id = ?", @contract.customer_id])
		
	job_type_id = @contract.job_type_id
	@job_type_details = JobTypeDetail.find(:all, :conditions =>["job_type_id = ?", job_type_id])

	@selected_contract_details = Contract.get_selected_details(params[:id])
	
    respond_to do |format|
		format.html
		format.pdf do
			send_data ContractDrawer.draw(@customer, @contract, @contract_details, @job_type_details),
				:filename => 'contract.pdf', :type => 'application/pdf', :disposition => 'inline'
		end	
    end
  end
  
  def new
	@customer = Customer.find(params[:customer_id])
    @contract = @customer.contracts.new
	@contract.total_cost = '$'
	@contract.down_payment = '1/3 of Total'

    respond_to do |format|
      format.html
    end
  end  
  
  def edit
	@contract = Contract.find(params[:id])
	@contract_details = @contract.contract_details.find(:all,
		:conditions => ["contract_id = ?", params[:id]], :order => "position")
	
	job_type_id = @contract.job_type_id
	@job_type_details = JobTypeDetail.find(:all, :conditions =>["job_type_id = ?", job_type_id])
	
	@available_contract_details = JobTypeDetail.find(:all, :conditions =>["job_type_id = ?", job_type_id], :order => "optional")
	@assigned_contract_details = @contract.job_type_details.find(:all, :conditions => ["job_type_id = ?", job_type_id])
  end
  
  def create
	@customer = Customer.find(params[:customer_id])
    @contract = @customer.contracts.new(params[:contract])

    respond_to do |format|
      if @contract.save
        flash[:notice] = 'Contract was successfully created.'
        format.html { redirect_to(@customer) }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def update
	params[:contract][:job_type_detail_ids] ||= []
	params[:contract][:detail_options]
	@contract = Contract.find(params[:id])
		
    respond_to do |format|
      if @contract.update_attributes(params[:contract])
        flash[:notice] = 'Contract was successfully updated.'
        format.html { redirect_to(@contract) }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
	@contract = Contract.find(params[:id])
	customer = @contract.customer_id
    @contract.destroy

    respond_to do |format|
      format.html { redirect_to(customer_path(customer)) }
    end
  end
end
