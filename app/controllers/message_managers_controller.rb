class MessageManagersController < ApplicationController
  
  # Cancan Workaround HACK!!
  before_filter do
    resource = controller_path.singularize.gsub('/', '_').to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  load_and_authorize_resource

  layout "admin"

  before_action :set_message_manager, only: [:show, :edit, :update, :destroy]

  # GET /message_managers
  # GET /message_managers.json
  def index
    @message_managers = MessageManager.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /message_managers/1
  # GET /message_managers/1.json
  def show
  end

  # GET /message_managers/new
  def new
    @message_manager = MessageManager.new
  end

  # GET /message_managers/1/edit
  def edit
  end

  # POST /message_managers
  # POST /message_managers.json
  def create
    @message_manager = MessageManager.new(message_manager_params)

    respond_to do |format|
      if @message_manager.save
        format.html { redirect_to message_managers_url, notice: 'Message manager was successfully created.' }
        format.json { render :show, status: :created, location: @message_manager }
      else
        format.html { render :new }
        format.json { render json: @message_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /message_managers/1
  # PATCH/PUT /message_managers/1.json
  def update
    respond_to do |format|
      if @message_manager.update(message_manager_params)
        format.html { redirect_to message_managers_url, notice: 'Message manager was successfully updated.' }
        format.json { render :show, status: :ok, location: @message_manager }
      else
        format.html { render :edit }
        format.json { render json: @message_manager.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /message_managers/1
  # DELETE /message_managers/1.json
  def destroy
    @message_manager.destroy
    respond_to do |format|
      format.html { redirect_to message_managers_url, notice: 'Message manager was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message_manager
      @message_manager = MessageManager.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_manager_params
      params.require(:message_manager).permit(:sms_balance, :chama_id)
    end
end
