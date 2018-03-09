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
    #
    # @attr_reader [JSON] json
    #   OWASP ZAP API response's JavaScript Object Notation  
    #
    attr_reader :json
    #
    # @attr_reader [String] text
    #   HTTP response body content
    #
    attr_reader :text
    #
    # @attr_reader [JSON] sess
    #   session location section of the OWASP ZAP API response body JSON
    #
    attr_reader :sess

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

      return '' if !@json.key?('sessionLocation') or @json['sessionLocation'].empty?

      @sess = @json['sessionLocation']

      super(@sess.dup)

      self
    end
  end
end
