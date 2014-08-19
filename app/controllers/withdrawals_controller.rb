class WithdrawalsController < ApplicationController
  
  before_filter :authenticate_user!
  
  before_action :set_withdrawal, only: [:show, :edit, :update, :destroy]
  before_action :check_chama_service_validity

  # GET /withdrawals
  # GET /withdrawals.json
  def index
    @withdrawals = Withdrawal.where(:chama_id => current_user.chama.id).paginate(:page => params[:page], :per_page => 10)
  end

  # GET /withdrawals/1
  # GET /withdrawals/1.json
  def show
  end

  # GET /withdrawals/new
  def new
    @withdrawal = Withdrawal.new
  end

  # GET /withdrawals/1/edit
  def edit
  end

  # POST /withdrawals
  # POST /withdrawals.json
  def create
    @withdrawal = Withdrawal.new(withdrawal_params)
    @withdrawal.chama_id = current_user.chama.id

    respond_to do |format|
      if @withdrawal.save
        format.html { redirect_to withdrawals_url, notice: 'Withdrawal was successfully created.' }
        format.json { render :show, status: :created, location: @withdrawal }
      else
        format.html { render :new }
        format.json { render json: @withdrawal.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /withdrawals/1
  # PATCH/PUT /withdrawals/1.json
  def update
    respond_to do |format|
      if @withdrawal.update(withdrawal_params)
        format.html { redirect_to withdrawals_url, notice: 'Withdrawal was successfully updated.' }
        format.json { render :show, status: :ok, location: @withdrawal }
      else
        format.html { render :edit }
        format.json { render json: @withdrawal.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /withdrawals/1
  # DELETE /withdrawals/1.json
  def destroy
    @withdrawal.destroy
    respond_to do |format|
      format.html { redirect_to withdrawals_url, notice: 'Withdrawal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_withdrawal
      @withdrawal = Withdrawal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def withdrawal_params
      params.require(:withdrawal).permit(:amount, :description, :chama_id)
    end
end
