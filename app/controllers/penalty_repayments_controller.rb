class PenaltyRepaymentsController < ApplicationController
  before_action :set_penalty_repayment, only: [:show, :edit, :update, :destroy]

  # GET /penalty_repayments
  # GET /penalty_repayments.json
  def index
    members = Member.where(:chama_id => current_user.chama.id)
    penalties = Penalty.where(:member_id => members)
    @penalty_repayments = PenaltyRepayment.where(:penalty_id => penalties).paginate(:page => params[:page], :per_page => 10)
  end

  # GET /penalty_repayments/1
  # GET /penalty_repayments/1.json
  def show
  end

  # GET /penalty_repayments/new
  def new
    @penalty_repayment = PenaltyRepayment.new
  end

  # GET /penalty_repayments/1/edit
  def edit
  end

  # POST /penalty_repayments
  # POST /penalty_repayments.json
  def create
    @penalty_repayment = PenaltyRepayment.new(penalty_repayment_params)

    respond_to do |format|
      if @penalty_repayment.save
        format.html { redirect_to @penalty_repayment, notice: 'Penalty repayment was successfully created.' }
        format.json { render :show, status: :created, location: @penalty_repayment }
      else
        format.html { render :new }
        format.json { render json: @penalty_repayment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /penalty_repayments/1
  # PATCH/PUT /penalty_repayments/1.json
  def update
    respond_to do |format|
      if @penalty_repayment.update(penalty_repayment_params)
        format.html { redirect_to @penalty_repayment, notice: 'Penalty repayment was successfully updated.' }
        format.json { render :show, status: :ok, location: @penalty_repayment }
      else
        format.html { render :edit }
        format.json { render json: @penalty_repayment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /penalty_repayments/1
  # DELETE /penalty_repayments/1.json
  def destroy
    @penalty_repayment.destroy
    respond_to do |format|
      format.html { redirect_to penalty_repayments_url, notice: 'Penalty repayment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_penalty_repayment
      @penalty_repayment = PenaltyRepayment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def penalty_repayment_params
      params.require(:penalty_repayment).permit(:amount, :penalty_id)
    end
end
