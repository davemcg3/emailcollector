class EmailsController < ApplicationController
  before_action :authorize, only: [:index, :edit, :update, :destroy]
  before_action :is_admin, only: [:index, :edit, :update, :destroy]
  before_action :set_email, only: [:show, :edit, :update, :destroy]

  layout "applicationflex", :only => [:new, :create, :show, :unsubscribe]

  # GET /emails
  # GET /emails.json
  def index
    @emails = Email.all
  end

  # GET /emails/1
  # GET /emails/1.json
  def show
    redirect_to root_path
  end

  # GET /emails/new
  def new
    @email = Email.new
  end

  # GET /emails/1/edit
  def edit
  end

  # POST /emails
  # POST /emails.json
  def create
    #explicitly set
    params[:email][:status] = 1
    params[:email][:unsubscribed] = nil
    params[:email][:source] = request.host
    @debug = email_params

    @email = Email.new(email_params)
    respond_to do |format|
      if @email.save
        logger.info "Added email #{@email.inspect}"
        format.html { render :show, notice: 'Email was successfully created.' }
        format.json { render :show, status: :created, location: @email }
      else
        set_email_by_email
        if @email.update(email_params)
          logger.info "Couldn't create email so updated existing email #{@email.inspect}"
          format.html { render :show, notice: 'Email was successfully updated.' }
          format.json { render :show, status: :created, location: @email }
        else
          logger.info("Couldn't create or update email #{@email.inspect}")
          format.html { render :new, notice: 'Unable to add email.' }
          format.json { render json: @email.errors, status: :unprocessable_entity }
        end
      end
    end
  end

  # PATCH/PUT /emails/1
  # PATCH/PUT /emails/1.json
  def update
    respond_to do |format|
      if @email.update(email_params)
        logger.info("Updated email #{@email.inspect}")
        format.html { redirect_to emails_path, notice: 'Email was successfully updated.' }
        format.json { render :show, status: :ok, location: @email }
      else
        format.html { render :edit }
        format.json { render json: @email.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /emails/1
  # DELETE /emails/1.json
  def destroy
    logger.info("Deleting email #{@email.inspect}")
    @email.destroy
    respond_to do |format|
      format.html { redirect_to emails_url, notice: 'Email was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def unsubscribe
  end

  def unsubscribed
    @email = Email.find_by email: email_params[:email]
    Rails.logger.debug @email
    Rails.logger.debug @email.present?
    if @email.present?
      @email[:status] = 0
      @email[:unsubscribed] =  DateTime.current
    end
    respond_to do |format|
      if @email.present? && @email.update(email_params)
        logger.info("Unsubscribing email #{@email.inspect}")
        format.html { redirect_to root_path, notice: 'You have been successfully unsubscribed.' }
        format.json { render :show, status: :ok, location: @email }
      else
        format.html { redirect_to root_path, notice: 'No email subscribed.' }
        format.json { render json @email.errors, status: unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_email
      @email = Email.find(params[:id])
    end

    def set_email_by_email
      @email = Email.find_by email:email_params[:email]
      #@debug = @found
      #@email.update_column(:id,@found[:id])
      #@debug = @email
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def email_params
      params.require(:email).permit(:email, :status, :source, :description, :unsubscribed)
    end

end
