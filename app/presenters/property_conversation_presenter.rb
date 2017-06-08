class PropertyConversationPresenter
  attr_reader :guest, :owner, :property

  def initialize(pc)
    @guest = pc.user
    @owner = pc.property.owner
    @property = pc.property
  end
end