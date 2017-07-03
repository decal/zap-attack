# coding: utf-8

module ZapAttack::API
  SESSLOC_JSON = 'https://zap:8080/JSON/core/view/sessionLocation'

  #
  # Get the filesystem location of the current ZAP session file.
  #
  # @return [String] location of session file
  # @example sess_loc = ZapAttack::API.SessionLocation.new
  # @see http://zap:8080/JSON/core/view/sessionLocation
  #
  class SessionLocation < String
    attr_reader :json, :text, :sess

    def initialize
      @sess, @json, @text = '', [], ''

      open(SESSLOC_JSON, OPEN_URI_OPTS) do |x|
        if x.content_type.include?('/json') and x.status.first.to_i.eql?(200)
          x.each_line do |l|
            @text << l
          end
        end
      end

      @json = JSON.parse(@text)

      return '' if !@json.key?('sessionLocation')

      @sess = @json['sessionLocation']

      super(@sess.clone)

      self
    end
  end
end
