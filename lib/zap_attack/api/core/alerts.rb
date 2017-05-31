# encoding: utf-8

require 'uri'

module ZapAttack::API
  #
  # URL to access alerts via ZAP API with baseurl parameter to narrow results
  #
  ALERTS_JSON = 'https://zap:8080/JSON/core/view/alerts?baseurl='

  class Alerts < Array
    attr_reader :json, :text, :alerts

    #
    # Instantiate Ruby Alerts Array Object by parsing JSON from ZAP API
    # 
    # @param [String] 
    #   abase URL
    #
    # @param [Proc] block 
    #   code statements to apply to each alert
    #
    # @return [Array#Hash] 
    #   a Hash Array consisting of pairs describing the threat
    #
    # @yield [Hash]
    #   Hash object encapsulates alert member variable names/values as String's
    #
    # @example 
    #   alerts = ZapAttack::API.Alerts.new
    #
    # @see 
    #   ZapAttack::Data::Alert
    #   https://zap:8080/JSON/core/view/alerts
    #
    def initialize(abase = '')
      raise(EmptyError 'abase cannot be nil!') if !abase
      raise(TypeError, 'abase must be a kind of String!') if !(abase.kind_of?(String) or abase.kind_of?(URI))

      abase = abase.to_s if abase.kind_of?(URI)

      alerts_json, @text, @alerts, @json = ALERTS_JSON.dup, '', [], []
      alerts_json << abase if !abase.empty?

      open(alerts_json, OPEN_URI_OPTS) do |x|
        if x.content_type.include?('/json') and x.status.first.to_i.eql?(200)
          x.each_line do |l|
            @text << l
          end
        end
      end

      @json = JSON.parse(@text)

      return [] if !@json.key?('alerts')

      @alerts = @json['alerts']

      if block_given? 
        @alerts.each do |a|
          yield a
        end
      end

      self.concat(@alerts)

      self
    end
  end
end
