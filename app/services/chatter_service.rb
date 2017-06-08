class ChatterService
  def self.new_conversation
    response = conn.post('conversations')
    JSON.parse(response.body, symbolize_names: true)
  end

  def self.find_conversation(cid)
    path = 'conversations/' + cid.to_s
    json = conn.get(path)
    JSON.parse(json.body, symbolize_names: true)
  end

  def self.post_message(msg_params)
    cid = msg_params[:cid] || msg_params[:conversation_id]
    path = 'conversations/' + cid.to_s + '/messages'
    json = conn.post(path, msg_params)
    JSON.parse(json.body, symbolize_names: true)
  end

private

  attr_reader :conn

  def initialize
    @conn = Faraday.new(url: 'http://159.203.168.46/api/v1')
  end

  def self.conn
    @conn ||= Faraday.new(url: 'http://159.203.168.46/api/v1')
  end
end