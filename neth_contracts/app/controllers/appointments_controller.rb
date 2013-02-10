class AppointmentsController < ApplicationController
include CustomersHelper

  def index
    @customer = Customer.find(params[:customer_id])
    @appointment = @customer.appointments.all

    respond_to do |format|
      format.html
    end
  end

  def show
    @appointment = Appointment.find(params[:id])
	@customer = Customer.find(@appointment.customer_id)

    respond_to do |format|
		format.html
		format.pdf do
			send_data AppointmentDrawer.draw(@appointment, @customer), :filename => 'appt.pdf', :type => 'application/pdf', :disposition => 'inline'
		end	
    end
  end
  
  def new
  	@customer = Customer.find(params[:customer_id])
    @appointment = @customer.appointments.new

    respond_to do |format|
      format.html
    end
  end

  def edit
    @appointment = Appointment.find(params[:id])
  end

  def create
    @customer = Customer.find(params[:customer_id])
    @appointment = @customer.appointments.new(params[:appointment])

    respond_to do |format|
      if @appointment.save
        flash[:notice] = 'Appointment was successfully created.'
        format.html { redirect_to(customer_appointments_path(@appointment.customer_id)) }
      else
        format.html { render :action => "new" }
      end
    end
  end

  def update
    @appointment = Appointment.find(params[:id])

    respond_to do |format|
      if @appointment.update_attributes(params[:appointment])
        flash[:notice] = 'Appointment was successfully updated.'
        format.html { redirect_to(customer_appointments_path(@appointment.customer_id)) }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy

    respond_to do |format|
      format.html { redirect_to(customer_appointments_path(@appointment.customer_id)) }
    end
  end
end
