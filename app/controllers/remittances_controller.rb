class RemittancesController < ApplicationController
  before_action :set_remittance, only: [:show, :edit, :update, :destroy]

  # GET /remittances
  # GET /remittances.json
  def index
    members = Member.where(:chama_id => current_user.chama.id)
    @remittances = Remittance.where(:member_id => members).paginate(:page => params[:page], :per_page => 10)
  end

  # GET /remittances/1
  # GET /remittances/1.json
  def show
  end

  # GET /remittances/new
  def new
    @remittance = Remittance.new
  end

  # GET /remittances/1/edit
  def edit
  end

  # POST /remittances
  # POST /remittances.json
  def create
    @remittance = Remittance.new(remittance_params)

    respond_to do |format|
      if @remittance.save
        format.html { redirect_to @remittance, notice: 'Remittance was successfully created.' }
        format.json { render :show, status: :created, location: @remittance }
      else
        format.html { render :new }
        format.json { render json: @remittance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /remittances/1
  # PATCH/PUT /remittances/1.json
  def update
    respond_to do |format|
      if @remittance.update(remittance_params)
        format.html { redirect_to @remittance, notice: 'Remittance was successfully updated.' }
        format.json { render :show, status: :ok, location: @remittance }
      else
        format.html { render :edit }
        format.json { render json: @remittance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /remittances/1
  # DELETE /remittances/1.json
  def destroy
    @remittance.destroy
    respond_to do |format|
      format.html { redirect_to remittances_url, notice: 'Remittance was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_remittance
      @remittance = Remittance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def remittance_params
      params.require(:remittance).permit(:amount, :remittance_type, :member_id)
    end
end
