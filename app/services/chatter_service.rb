class ChatterService
  attr_reader :conn

  def self.new_conversation
    response = conn.post('conversations')
    parsed = JSON.parse(response.body, symbolize_names: true)
    ChatterConversation.new(parsed)
  end

  def self.find_conversation(cid)
    path = 'conversations/' + cid.to_s
    json = conn.get(path)
    JSON.parse(json.body, symbolize_names: true)
  end

  def self.conn
    @conn ||= Faraday.new(url: 'http://159.203.168.46/api/v1')
  end

  def initialize
    @conn = Faraday.new(url: 'http://159.203.168.46/api/v1')
  end
end