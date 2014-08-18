class LoanRepaymentsController < ApplicationController
  before_action :set_loan_repayment, only: [:show, :edit, :update, :destroy]
  before_action :check_chama_service_validity

  # GET /loan_repayments
  # GET /loan_repayments.json
  def index
    members = Member.where(:chama_id => current_user.chama.id)
    loans = Loan.where(:member_id => members)
    @loan_repayments = LoanRepayment.where(:loan_id => loans).paginate(:page => params[:page], :per_page => 10)
  end

  # GET /loan_repayments/1
  # GET /loan_repayments/1.json
  def show
  end

  # GET /loan_repayments/new
  def new
    @loan_repayment = LoanRepayment.new
  end

  # GET /loan_repayments/1/edit
  def edit
  end

  # POST /loan_repayments
  # POST /loan_repayments.json
  def create
    @loan_repayment = LoanRepayment.new(loan_repayment_params)

    respond_to do |format|
      if @loan_repayment.save
        format.html { redirect_to loan_repayments_url, notice: 'Loan repayment was successfully created.' }
        format.json { render :show, status: :created, location: @loan_repayment }
      else
        format.html { render :new }
        format.json { render json: @loan_repayment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /loan_repayments/1
  # PATCH/PUT /loan_repayments/1.json
  def update
    respond_to do |format|
      if @loan_repayment.update(loan_repayment_params)
        format.html { redirect_to loan_repayments_url, notice: 'Loan repayment was successfully updated.' }
        format.json { render :show, status: :ok, location: @loan_repayment }
      else
        format.html { render :edit }
        format.json { render json: @loan_repayment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /loan_repayments/1
  # DELETE /loan_repayments/1.json
  def destroy
    @loan_repayment.destroy
    respond_to do |format|
      format.html { redirect_to loan_repayments_url, notice: 'Loan repayment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_loan_repayment
      @loan_repayment = LoanRepayment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def loan_repayment_params
      params.require(:loan_repayment).permit(:amount, :loan_id)
    end
end
