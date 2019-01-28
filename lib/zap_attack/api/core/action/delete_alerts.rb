# coding: utf-8

module ZapAttack::API
  RMALRTS_JSON = 'http://zap:8080/JSON/core/action/deleteAllAlerts'
  DELETE_ALERTS_JSON = RMALRTS_JSON

  #
  # Clear all current vulnerability alerts from the ZAP API.
  #
  # @return [String] Value of the JSON "Result" key received from the ZAP API JSON
  # @example urlarray = ZapAttack::API.DeleteAllAlerts.new
  # @see http://zap:8080/JSON/core/action/deleteAllAlerts
  #
  class DeleteAllAlerts < String
    attr_reader :json, :text, :rmall

    def initialize
      @rmall, @json, @text = '', [], ''

      open(RMALRTS_JSON, OPEN_URI_OPTS) do |x|
        if x.content_type.include?('/json') and x.status.first.to_i.eql?(200)
          x.each_line do |l|
            @text << l
          end
        end
      end

      @json = JSON.parse(@text)

      return '' if !@json.key?('Result')

      @rmall = @json['Result']

      super(@rmall.clone)

      self
    end
  end
end
