class Admin::UsersController < ApplicationController
  
  # Cancan Workaround HACK!!
  before_filter do
    #resource = controller_path.singularize.gsub('/', '_').to_sym
    #method = "#{resource}_params"
    #params[resource] &&= send(method) if respond_to?(method, true)
  end

  #load_and_authorize_resource
  before_filter :authenticate_user!

  layout "admin"

  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /Users
  # GET /Users.json
  def index
    @users = User.all#.paginate(:page => params[:page], :per_page => 3)
  end

  # GET /Users/1
  # GET /Users/1.json
  def show
    # If a chama is logged in load chamas layout
    if current_user.role_ids == [2] 
      render(:layout => "layouts/application")
    end
  end

  # GET /Users/new
  def new
    @user = User.new
  end

  # GET /Users/1/edit
  def edit
    # If a chama is logged in load chamas layout
    if current_user.role_ids == [2] 
      render(:layout => "layouts/application")
    end
  end

  # POST /Users
  # POST /Users.json
  def create
    @user = User.new(user_params)
    
    respond_to do |format|
      if @user.save
        format.html { redirect_to admin_users_path, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /Users/1
  # PATCH/PUT /Users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        sign_in(@user == current_user ? @user : current_user, :bypass => true)        format.html { redirect_to admin_user_path(@user), notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # DELETE /Users/1
  # DELETE /Users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params      
      params.require(:user).permit(:username, :name, :email, :password, :password_confirmation, :phone_number, :national_id_number)
    end

end