class JobTypeDetailsController < ApplicationController

  def index
	@job_type = JobType.find(params[:job_type_id])
    @job_type_details = @job_type.job_type_detail.find(:all)

    respond_to do |format|
      format.html
    end
  end


  def show
  	@job_type = JobType.find(params[:job_type_id])
    @job_type_detail = @job_type.job_type_detail.find(params[:id])

    respond_to do |format|
      format.html
    end
  end


  def new
  	@job_type = JobType.find(params[:job_type_id])
    @job_type_detail = @job_type.job_type_detail.new
	@job_type_detail.optional = false

    respond_to do |format|
      format.html
    end
  end


  def edit
  	@job_type = JobType.find(params[:job_type_id])
    @job_type_detail = @job_type.job_type_detail.find(params[:id])
  end


  def create
  	@job_type = JobType.find(params[:job_type_id])
    @job_type_detail = @job_type.job_type_detail.new(params[:job_type_detail])

    respond_to do |format|
      if @job_type_detail.save
        flash[:notice] = 'JobTypeDetail was successfully created.'
        format.html { redirect_to(@job_type) }
      else
        format.html { render :action => "new" }
      end
    end
  end


  def update
  	@job_type = JobType.find(params[:job_type_id])
    @job_type_detail = @job_type.job_type_detail.find(params[:id])

    respond_to do |format|
      if @job_type_detail.update_attributes(params[:job_type_detail])
        flash[:notice] = 'JobTypeDetail was successfully updated.'
        format.html { redirect_to(@job_type) }
      else
        format.html { render :action => "edit" }
      end
    end
  end


  def destroy
  	@job_type = JobType.find(params[:job_type_id])
    @job_type_detail = @job_type.job_type_detail.find(params[:id])
    @job_type_detail.destroy

    respond_to do |format|
      format.html { redirect_to(@job_type) }
    end
  end
end
