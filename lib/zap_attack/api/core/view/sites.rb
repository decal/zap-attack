# coding: utf-8

module ZapAttack::API
  SITES_JSON = 'http://zap:8080/JSON/core/view/sites'

  class Sites < Array
    #
    # @attr_reader [JSON] json
    #   OWASP ZAP Web API JavaScript Object Notation
    #
    attr_reader :json

    #
    # @attr_reader [String] text
    #   HTTP response body content from the OWASP ZAP Web API
    #
    attr_reader :text

    #
    # @attr_reader [Array#String] sites
    #   List of sites visited by the OWASP Zed Attack Proxy
    #
    attr_reader :sites

    def initialize
      @sites, @json, @text = [], [], ''

      open(SITES_JSON, OPEN_URI_OPTS) do |x|
        if x.content_type.include?('/json') and x.status.first.to_i.eql?(200)
          x.each_line do |l|
            @text << l
          end
        end
      end

      @json = JSON.parse(@text)

      return [] if !@json.key?('sites')

      @sites = @json['sites']

      if block_given?
        @sites.each do |s|
          yield s
        end
      end

      self.concat(@sites)

      self 
    end
  end
end
