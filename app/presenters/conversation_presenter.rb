class ConversationPresenter
  attr_reader :id, :property, :owner, :guest, :messages

  def initialize(args)
    prop = args[:property] || 'No property'
    convo = args[:convo] || 'No convo'
    guest = args[:guest] || 'No guest'

    @property = prop
    @owner = prop.owner.full_name
    @guest = guest.full_name
    @messages = convo.messages
    @id = convo.id
  end
end
