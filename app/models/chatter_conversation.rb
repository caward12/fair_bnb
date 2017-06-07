class ChatterConversation
  attr_reader :id, :first_message_date
  attr_accessor :messages, :last_message_date

  def initialize(params)
    @id = params[:id]
    @messages = params[:messages]
    @first_message_date = DateTime.parse(params[:first_message_date])
    @last_message_date = DateTime.parse(params[:last_message_date])
  end
end