class ChamasController < ApplicationController
 
  # Cancan Workaround HACK!!
  before_filter do
    resource = controller_path.singularize.gsub('/', '_').to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  load_and_authorize_resource
  before_filter :authenticate_user!

  layout "admin"

  before_action :set_chama, only: [:show, :edit, :update, :destroy]
  before_action :check_chama_service_validity

  # GET /chamas
  # GET /chamas.json
  def index
    @chamas = Chama.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /chamas/1
  # GET /chamas/1.json
  def show
  end

  # GET /chamas/new
  def new
    @chama = Chama.new
  end

  # GET /chamas/1/edit
  def edit
  end

  # POST /chamas
  # POST /chamas.json
  def create
    @chama = Chama.new(chama_params)

    respond_to do |format|
      if @chama.save
        format.html { redirect_to chamas_url, notice: 'Chama was successfully created.' }
        format.json { render :show, status: :created, location: @chama }
      else
        format.html { render :new }
        format.json { render json: @chama.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chamas/1
  # PATCH/PUT /chamas/1.json
  def update
    respond_to do |format|
      if @chama.update(chama_params)
        format.html { redirect_to chamas_url, notice: 'Chama was successfully updated.' }
        format.json { render :show, status: :ok, location: @chama }
      else
        format.html { render :edit }
        format.json { render json: @chama.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chamas/1
  # DELETE /chamas/1.json
  def destroy
    @chama.destroy
    respond_to do |format|
      format.html { redirect_to chamas_url, notice: 'Chama was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chama
      @chama = Chama.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chama_params
      params.require(:chama).permit(:name, :description, :chama_type, :approx_no_of_members, :user_id)
    end
end
