# coding: utf-8

module ZapAttack::API
  MESSAGE_JSON = 'http://zap:8080/JSON/core/view/message?id='

  class Message < Hash
    attr_reader :json, :text, :message

    #
    # Instantiate custom Ruby Hash Object by parsing Message from ZAP API JSON
    #
    # @param [Integer] idnum
    #   Positive whole number that uniquely identifies message to retrieve
    #
    # @return [Hash] 
    #   Associated keys and values representing HTTP traffic protocol data
    #
    # @example 
    #   amessage = ZapAttack::API.Message(8)
    #
    # @see 
    #   http://zap:8080/JSON/core/view/message?id=
    #
    def initialize(idnum = 0)
      raise(TypeError, 'idnum must be a kind of Integer!') if !idnum.kind_of?(Integer)
      raise(RangeError, 'idnum must be greater than zero!') if idnum <= 0

      @json, @text, @mesg = [], '', {}

      open("#{MESSAGE_JSON}#{idnum}", OPEN_URI_OPTS) do |x|

        if x.content_type.include?('/json') and x.status.first.to_i.eql?(200)
          x.each_line do |l|
            @text << l
          end
        end
      end

      ahash, @json = {}, JSON.parse(@text)

      if json.key?('message')
        @mesg = @json['message']
        ahash = JSON.parse(@mesg)
      end

      ahash.each_pair do |k, v|
        self[:k] = v
      end

      self
    end
  end
end
