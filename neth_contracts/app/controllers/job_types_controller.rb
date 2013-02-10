class JobTypesController < ApplicationController
  def index
	@job_types = JobType.find(:all)
	
	respond_to do |format|
      format.html
    end
  end

  def show
	@job_type = JobType.find(params[:id])
	
	respond_to do |format|
      format.html
    end
  end

  def new
	@job_type = JobType.new

	respond_to do |format|
      format.html
    end
  end

  def edit
	@job_type = JobType.find(params[:id])
  end

  def create
    @job_type = JobType.new(params[:job_type])

    respond_to do |format|
      if @job_type.save
        flash[:notice] = 'Job type was successfully created.'
        format.html { redirect_to(@job_type) }
      else
        format.html { render :action => "new" }
      end
    end
  end
  
  def update
    @job_type = JobType.find(params[:id])

    respond_to do |format|
      if @job_type.update_attributes(params[:job_type])
        flash[:notice] = 'Job type was successfully updated.'
        format.html { redirect_to(@job_type) }
      else
        format.html { render :action => "edit" }
      end
    end
  end
  
  def destroy
    @job_type = JobType.find(params[:id])
	@job_type.destroy

    respond_to do |format|
	  format.html { redirect_to(job_types_path) }
    end
  end
  
end
