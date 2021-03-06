class PostsController < ApplicationController

  before_filter :authenticate_user! 

  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  def like_post
    # Fecct the concerned post
    @post = Post.find(params[:id])

    # check if user has aloread jfjrjjfjklfdkkdkldsklf
    prev_like = Like.where(:user_id => current_user.id, :post_id => @post.id)

    if !prev_like.blank?
      # you already like me
      #go back to where you came from.
      redirect_to request.referer, notice: 'You already like Me.'
      return
    end

    # create like
    like = Like.new(:user_id => current_user.id, :post_id => @post.id)

    # Save it
    like.save

    #go back to where you came from.
    redirect_to request.referer, notice: 'Successfully liked post'
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    # Current user is the owner of the post
    @post.user_id = current_user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:caption, :user_id, :photon)
    end
end
