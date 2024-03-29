  class UsersController < ApplicationController
  before_action :authorize, only: [:index, :show, :edit, :update, :destroy]
  before_action :is_admin, only: [:index, :show, :edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    checked_user_params = @current_user.present? && @current_user.admin? ? user_params : user_params.merge(admin: false)
    @user = User.new(checked_user_params)

    respond_to do |format|
      if @user.save
        logger.info("Created user #{@user.inspect}")
        format.html { render :show, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        logger.info("Failed to create user #{@user.inspect}")
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        logger.info("Updated user #{@user.inspect}")
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    logger.info("Destroying user #{@user.inspect}")
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
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
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :admin)
    end
end
