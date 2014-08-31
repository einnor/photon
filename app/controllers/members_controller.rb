class MembersController < ApplicationController
  # Cancan Workaround HACK!!
  before_filter do
    resource = controller_path.singularize.gsub('/', '_').to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end

  load_and_authorize_resource
  before_filter :authenticate_user!
  
  before_action :set_member, only: [:show, :edit, :update, :destroy]
  before_action :check_chama_service_validity

  # GET /members
  # GET /members.json
  def index
    @members = Member.where(:chama_id => current_user.chama.id).paginate(:page => params[:page], :per_page => 10)
  end

  # GET /members/1
  # GET /members/1.json
  def show
  end

  # GET /members/new
  def new
    @member = Member.new
  end

  # GET /members/1/edit
  def edit
  end

  # POST /members
  # POST /members.json
  def create
    # Limit number of users a Chama can have
    cur_count = Member.where(:chama_id => current_user.chama.id).count

    can_create = false

    if cur_count < current_user.chama.approx_no_of_members
      can_create = true
    end

    # Create action
    @member = Member.new(member_params)
    @member.chama_id = current_user.chama.id

    respond_to do |format|
      if can_create
        if @member.save
          format.html { redirect_to members_url, notice: 'Member was successfully created.' }
          format.json { render :show, status: :created, location: @member }
        else
          format.html { render :new }
          format.json { render json: @member.errors, status: :unprocessable_entity }
        end
      else
        format.html { redirect_to members_url, notice: 'Your Chama has reached max number of members. Contact SmartChama Admin for assistance' }
        format.json { render :show, status: :created, location: @member }
      end

    end
  end

  # PATCH/PUT /members/1
  # PATCH/PUT /members/1.json
  def update
    respond_to do |format|
      if @member.update(member_params)
        format.html { redirect_to members_url, notice: 'Member was successfully updated.' }
        format.json { render :show, status: :ok, location: @member }
      else
        format.html { render :edit }
        format.json { render json: @member.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /members/1
  # DELETE /members/1.json
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: 'Member was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:member).permit(:name, :phone_number, :occupation, :national_id_number, :others, :chama_id)
    end
end
