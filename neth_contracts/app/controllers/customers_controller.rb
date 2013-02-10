class CustomersController < ApplicationController

  def index
    @customers = Customer.find(:all)

    respond_to do |format|
      format.html
    end
  end
  
  
  def show
    @customer = Customer.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  
  def new
    @customer = Customer.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  
  def create
    @customer = Customer.new(params[:customer])

    respond_to do |format|
      if @customer.save
        flash[:notice] = 'Customer was successfully created.'
        format.html { redirect_to(@customer) }
      else
        format.html { render :action => "new" }
      end
    end
  end


  def update
    @customer = Customer.find(params[:id])

    respond_to do |format|
      if @customer.update_attributes(params[:customer])
        flash[:notice] = 'Customer was successfully updated.'
        format.html { redirect_to(@customer) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @customer.errors, :status => :unprocessable_entity }
      end
    end
  end


  def destroy
    @customer = Customer.find(params[:id])
    @customer.destroy

    respond_to do |format|
      format.html { redirect_to(customers_url) }
    end
  end
end
