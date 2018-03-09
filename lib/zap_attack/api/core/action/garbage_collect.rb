# coding: utf-8

module ZapAttack::API
  RUNGC_JSON = 'https://zap:8080/JSON/core/action/runGarbageCollection'

  #
  # Run garbage collection in the ZAP API JVM.
  #
  # @return [String] Value of the JSON "Result" key received from the ZAP API
  # @example urlarray = ZapAttack::API.RunGarbageCollection.new
  # @see http://zap:8080/JSON/core/action/runGarbageCollection
  #
  class RunGarbageCollection < String
    attr_reader :json, :text, :rungc

    def initialize
      @rungc, @json, @text = '', [], ''

      open(RUNGC_JSON, OPEN_URI_OPTS) do |x|
        if x.content_type.include?('/json') and x.status.first.to_i.eql?(200)
          x.each_line do |l|
            @text << l
          end
        end
      end

      @json = JSON.parse(@text)

      return '' if !@json.key?('Result')

      @rungc = @json['Result']

      super(@rungc.clone)

      self
    end
  end
end
