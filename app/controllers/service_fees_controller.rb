class ServiceFeesController < ApplicationController
  
  # Cancan Workaround HACK!!
  before_filter do
    resource = controller_path.singularize.gsub('/', '_').to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  load_and_authorize_resource except: [:pesapal_ipn, :pesapal_success]
  before_filter :authenticate_user!

  layout "admin"

  before_action :set_service_fee, only: [:show, :edit, :update, :destroy]
  before_action :check_chama_service_validity

  # GET /service_fees
  # GET /service_fees.json
  def index
    @service_fees = ServiceFee.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /service_fees/1
  # GET /service_fees/1.json
  def show
  end

  def pesapal_success
    txn_tracking_id = params['pesapal_transaction_tracking_id']
    merchant_ref = params['pesapal_merchant_reference']

    # Find corresponding Service_Fee Record
    @service_fee = ServiceFee.find(merchant_ref)

    # Update with Pesapal 
    @service_fee.update_pesapal_details(txn_tracking_id, merchant_ref)

    # If a chama is logged in load chamas layout
    if current_user.role_ids == [2] 
      render(:layout => "layouts/application")
    end
  end

  def pesapal_ipn
    pesapal = ServiceFeesHelper::PesaPalInterface.new

    # Fetch Pesapal Parameters
    txn_tracking_id = params['pesapal_transaction_tracking_id']
    merchant_ref = params['pesapal_merchant_reference']
    notification_type = params['pesapal_notification_type']

    # Find corresponding Sms_Fee Record
    @service_fee = ServiceFee.find(merchant_ref)

    # pass in the notification type, merchant reference and transaction id
    response_to_ipn = pesapal.ipn_listener(notification_type, merchant_ref,txn_tracking_id)

    new_status = response_to_ipn['status']

    # Update with Pesapal .Potential BUG respond to pesapal
    @service_fee.update_payment_status(new_status)

    # If a chama is logged in load chamas layout
    if current_user.role_ids == [2] 
      render(:layout => "layouts/application")
    end
  end

  # GET /service_fees/new
  def new
    @service_fee = ServiceFee.new
  end

  # GET /service_fees/1/edit
  def edit
  end

  # POST /service_fees
  # POST /service_fees.json
  def create
    @service_fee = ServiceFee.new(service_fee_params)

    respond_to do |format|
      if @service_fee.save
        format.html { redirect_to @service_fee, notice: 'Service fee was successfully created.' }
        format.json { render :show, status: :created, location: @service_fee }
      else
        format.html { render :new }
        format.json { render json: @service_fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /service_fees/1
  # PATCH/PUT /service_fees/1.json
  def update
    respond_to do |format|
      if @service_fee.update(service_fee_params)
        format.html { redirect_to @service_fee, notice: 'Service fee was successfully updated.' }
        format.json { render :show, status: :ok, location: @service_fee }
      else
        format.html { render :edit }
        format.json { render json: @service_fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /service_fees/1
  # DELETE /service_fees/1.json
  def destroy
    @service_fee.destroy
    respond_to do |format|
      format.html { redirect_to service_fees_url, notice: 'Service fee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_service_fee
      @service_fee = ServiceFee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def service_fee_params
      params.require(:service_fee).permit(:payment_type, :amount, :description, :next_payment_due_date, :service_status, :txn_status, :pesapal_txn_tracking_id, :pesapal_merchant_reference, :chama_id)
    end
end
