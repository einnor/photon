class SmsFeesController < ApplicationController
  before_action :set_sms_fee, only: [:show, :edit, :update, :destroy]

  # GET /sms_fees
  # GET /sms_fees.json
  def index
    @sms_fees = SmsFee.paginate(:page => params[:page], :per_page => 10)
    render(:layout => "layouts/admin")
  end

  # GET /sms_fees/1
  # GET /sms_fees/1.json
  def show
  end

  # GET /sms_fees/new
  def new
    @sms_fee = SmsFee.new
  end

  # GET /sms_fees/1/edit
  def edit
  end

  # POST /sms_fees
  # POST /sms_fees.json
  def create
    @sms_fee = SmsFee.new(sms_fee_params)
    @sms_fee.chama_id = current_user.chama.id

    #populate amount field
    if @sms_fee.package == "100-SMS@KES-200"
      @sms_fee.amount = 200
    elsif @sms_fee.package == "500-SMS@KES-1000"
      @sms_fee.amount = 1000
    elsif @sms_fee.package == "1000-SMS@KES-2000"
      @sms_fee.amount = 2000
    end
      

    respond_to do |format|
      if @sms_fee.save
        format.html { redirect_to @sms_fee, notice: 'Sms fee was successfully created.' }
        format.json { render :show, status: :created, location: @sms_fee }
      else
        format.html { render :new }
        format.json { render json: @sms_fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sms_fees/1
  # PATCH/PUT /sms_fees/1.json
  def update
      
    @sms_fee.update(sms_fee_params)

    #populate amount field
    if @sms_fee.package == "100-SMS@KES-200"
      @sms_fee.amount = 200
    elsif @sms_fee.package == "500-SMS@KES-1000"
      @sms_fee.amount = 1000
    elsif @sms_fee.package == "1000-SMS@KES-2000"
      @sms_fee.amount = 2000
    end
    
    respond_to do |format|
      if @sms_fee.update(sms_fee_params)

        @sms_fee.chama_id = current_user.chama.id

        #populate amount field
        if @sms_fee.package == "100-SMS@KES-200"
          @sms_fee.amount = 200
        elsif @sms_fee.package == "500-SMS@KES-1000"
          @sms_fee.amount = 1000
        elsif @sms_fee.package == "1000-SMS@KES-2000"
          @sms_fee.amount = 2000
        end
    
        format.html { redirect_to @sms_fee, notice: 'Sms fee was successfully updated.' }
        format.json { render :show, status: :ok, location: @sms_fee }
      else
        format.html { render :edit }
        format.json { render json: @sms_fee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sms_fees/1
  # DELETE /sms_fees/1.json
  def destroy
    @sms_fee.destroy
    respond_to do |format|
      format.html { redirect_to sms_fees_url, notice: 'Sms fee was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sms_fee
      @sms_fee = SmsFee.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sms_fee_params
      params.require(:sms_fee).permit(:package, :amount, :txn_status, :pesapal_txn_tracking_id, :pesapal_merchant_reference, :chama_id)
    end
end
