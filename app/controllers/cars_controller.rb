class CarsController < ApplicationController
  before_action :set_car, only: [:show, :edit, :update, :destroy]

  # GET /cars
  # GET /cars.json
  def index
    @cars = Car.all
  end

  # GET /cars/1
  # GET /cars/1.json
  def show
  end

  # GET /cars/new
  def new
    @car = Car.new
  end

  # GET /cars/1/edit
  def edit
  end

  # POST /cars
  # POST /cars.json
  def create
    @car = Car.create(car_params.except(:car_images_attributes))
    original_file = car_params['car_images_attributes']['0']['photo']
# binding.pry
    directory_name = "/tmp/image_queue"
    Dir.mkdir(directory_name) unless File.exists?(directory_name)

    path = "/tmp/image_queue/#{original_file.original_filename.split('.')[0] + CarImage.count.to_s}#{File.extname(original_file.original_filename)}"
# binding.pry
    f = File.new path, "wb"
    f.binmode
    bin = original_file.read()
    f.write(bin)
    f.flush

    @picture = CarImage.new(temp_file_path: path)
    # @picture.car_id = @car.id
    @picture.save

# binding.pry
    # FastImageUploadJob.perform_later(@picture.id,@car.id)
    UploadfileWorker.perform_in(2.seconds,@picture.id,@car.id)

    # respond_with(@picture)

# binding.pry
    respond_to do |format|
      if @car.save
        format.html { redirect_to @car, notice: 'Car was successfully created.' }
        format.json { render :show, status: :created, location: @car }
      else
        format.html { render :new }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /cars/1
  # PATCH/PUT /cars/1.json
  def update
    respond_to do |format|
      if @car.update(car_params)
        format.html { redirect_to @car, notice: 'Car was successfully updated.' }
        format.json { render :show, status: :ok, location: @car }
      else
        format.html { render :edit }
        format.json { render json: @car.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /cars/1
  # DELETE /cars/1.json
  def destroy
    @car.destroy
    respond_to do |format|
      format.html { redirect_to cars_url, notice: 'Car was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_car
      @car = Car.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def car_params
      params.require(:car).permit(:title, :description, :price, :price_currency,
                                  car_images_attributes: [:photo])
    end
end
