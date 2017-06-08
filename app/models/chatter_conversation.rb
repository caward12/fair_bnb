class ChatterConversation
  attr_reader :id, :first_message_date
  attr_accessor :messages, :last_message_date

  def self.service
    @service ||= ChatterService
  end

  def self.find(cid)
    cc = service.find_conversation(cid)
    new(cc)
  end

  def self.post_message(params)
    response = service.post_message(params)
    ChatterMessage.new(response)
  end

private

  def initialize(params = nil)
    params ||= ChatterService.new_conversation

    @id = params[:id]
    @messages = build_messages(params[:messages])
    @first_message_date = DateTime.parse(params[:first_message_date])
    @last_message_date = DateTime.parse(params[:last_message_date])
  end

  def build_messages(messages)
    messages.map do |msg|
      ChatterMessage.new(msg)
    end
  end
end