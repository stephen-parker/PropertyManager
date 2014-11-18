class PropertiesController < ApplicationController
  before_action :set_property, only: [:show, :edit, :update, :destroy]

  # GET /properties
  # GET /properties.json
  def index
    @jobs = Work.all
    @properties = Property.all
    @properties.each do |prop|
      @jobs.each do |job|
        if job.property_id == prop.id
          # prop.active_job = "1"
          prop.update(active_job: "1")
          break
        else
          prop.active_job = "0"
        end
      end
    end
  end
  # GET /properties/1
  # GET /properties/1.json
  def show
    @property = Property.find(params[:id])
    @property_marker = Gmaps4rails.build_markers(@property) do |prop, marker|
      marker.lat prop.latitude
      marker.lng prop.longitude
      marker.infowindow prop.address
    @tenant = Tenant.where(params[:id])
    @job_count = Work.where(property_id: params[:id] ).count #specify key before paramater
    @property_count = Property.where(landlord_id: @property.landlord_id).count
    end
  end

  # GET /properties/new
  def new
    @property = Property.new
  end

  # GET /properties/1/edit
  def edit
  end

  # POST /properties
  # POST /properties.json
  def create
    @property = Property.new(property_params)
    puts @property.works

    respond_to do |format|
      if @property.save
        format.html { redirect_to @property, notice: 'Property was successfully created.' }
        format.json { render :show, status: :created, location: @property }
      else
        format.html { render :new }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /properties/1
  # PATCH/PUT /properties/1.json
  def update
    respond_to do |format|
      if @property.update(property_params)
        format.html { redirect_to @property, notice: 'Property was successfully updated.' }
        format.json { render :show, status: :ok, location: @property }
      else
        format.html { render :edit }
        format.json { render json: @property.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /properties/1
  # DELETE /properties/1.json
  def destroy
    @property.destroy
    respond_to do |format|
      format.html { redirect_to properties_url, notice: 'Property was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_property
      @property = Property.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def property_params
      params.require(:property).permit(:address, :landlord_id, :longitude, :latitude, :active_job)
    end
end
