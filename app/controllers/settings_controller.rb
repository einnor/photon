class SettingsController < ApplicationController
  
  # Cancan Workaround HACK!!
  before_filter do
    resource = controller_path.singularize.gsub('/', '_').to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  load_and_authorize_resource
  before_filter :authenticate_user!

  layout "admin"

  before_action :set_setting, only: [:show, :edit, :update, :destroy]
  #before_action :check_chama_service_validity

  # GET /settings
  # GET /settings.json
  def index
    @settings = Setting.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /settings/1
  # GET /settings/1.json
  def show
    @service_fee = ServiceFee.where(:chama_id => @setting.chama_id).last

    #If a chama is logged in load chamas layout
    if current_user.role_ids == [2] 
      render(:layout => "layouts/application")
    end
  end

  # GET /settings/new
  def new
    @setting = Setting.new
  end

  # GET /settings/1/edit
  def edit
    #If a chama is logged in load chamas layout
    if current_user.role_ids == [2] 
      render(:layout => "layouts/application")
    end
  end

  # POST /settings
  # POST /settings.json
  def create
    @setting = Setting.new(setting_params)

    respond_to do |format|
      if @setting.save
        format.html { redirect_to @setting, notice: 'Setting was successfully created.' }
        format.json { render :show, status: :created, location: @setting }
      else
        format.html { render :new }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /settings/1
  # PATCH/PUT /settings/1.json
  def update
    respond_to do |format|
      if @setting.update(setting_params)
        format.html { redirect_to @setting, notice: 'Setting was successfully updated.' }
        format.json { render :show, status: :ok, location: @setting }
      else
        format.html { render :edit }
        format.json { render json: @setting.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /settings/1
  # DELETE /settings/1.json
  def destroy
    @setting.destroy
    respond_to do |format|
      format.html { redirect_to settings_url, notice: 'Setting was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_setting
      @setting = Setting.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def setting_params
      params.require(:setting).permit(:remittance_deadline, :warning_days_before_deadline, :remittance_reminder_sms, :penalty_reminder_sms, :penalty_type, :penalty_amount, :penalty_repay_periods_in_days, :chama_id)
    end
end
