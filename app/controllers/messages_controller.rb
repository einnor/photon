class MessagesController < ApplicationController
  before_action :set_message, only: [:show, :edit, :update, :destroy]
  before_action :set_message_manager, only: [:msg_manager]

  # GET /messages
  # GET /messages.json
  def index
    @messages = Message.paginate(:page => params[:page], :per_page => 10)
    @message = Message.new
  end

  # GET /messages/1
  # GET /messages/1.json
  def show
  end

  # Gets chamas message manager
  # GET /messages/msg_manager/:id
  def msg_manager
  end

  # GET /messages/new
  def new
    @message = Message.new
  end

  # GET /messages/1/edit
  def edit
  end

  # POST /messages
  # POST /messages.json
  def create
    @message = Message.new(message_params)
    @message.message_manager_id = correct_message_manager(current_user)

    # Send SMS Here
    if (!@message.recepient.blank? && !@message.body.blank?)
      #send_sms(@message.recepient, @message.body)
    end

    respond_to do |format|
      if @message.save
        format.html { redirect_to messages_url, notice: 'Message was successfully created.' }
        format.json { render :show, status: :created, location: @message }
      else
        format.html { render :new }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /messages/1
  # PATCH/PUT /messages/1.json
  def update
    respond_to do |format|
      if @message.update(message_params)
        format.html { redirect_to messages_url, notice: 'Message was successfully updated.' }
        format.json { render :show, status: :ok, location: @message }
      else
        format.html { render :edit }
        format.json { render json: @message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.json
  def destroy
    @message.destroy
    respond_to do |format|
      format.html { redirect_to messages_url, notice: 'Message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def message_params
      params.require(:message).permit(:body, :recepient, :message_manager_id)
    end

    def set_message_manager
      @message_manager = MessageManager.find(params[:id])
    end

    # Returns Current Users Chama Message Manager
    def correct_message_manager(current_user)
     current_user.chama.message_manager.id
    end

    # Send an SMS
    def send_sms(to, message)

      # Specify your login credentials
      username = "trendprosystems";
      apikey   = "MyAfricasTalkingAPIKey";

      # Specify the numbers that you want to send to in a comma-separated list
      # Please ensure you include the country code (+254 for Kenya in this case)
      #to      = "+254711XXXYYYZZZ,+254733XXXYYYZZZ";

      # And of course we want our recipients to know what we really do
      # message = "I'm a lumberjack and it's ok, I sleep all night and I work all day"

      # Create a new instance of our awesome gateway class
      gateway = Messaging::AfricasTalkingGateway.new(username, apikey)

      # Any gateway errors will be captured by our custom Exception class below,
      # so wrap the call in a try-catch block
      begin
        # Thats it, hit send and we'll take care of the rest.
        reports = gateway.send_message(to, message)
        reports.each {|x|
          # Note that only the Status "Success" means the message was sent
          puts 'number=' + x.number + ';status=' + x.status + ';messageId=' + x.messageId + ';cost=' + x.cost
        }
      rescue Messaging::AfricasTalkingGatewayError => ex
        puts 'Encountered an error: ' + ex.message
      end
      # DONE!
    end
end
