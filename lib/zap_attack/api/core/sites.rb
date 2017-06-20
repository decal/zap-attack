# coding: utf-8

module ZapAttack::API
  SITES_JSON = 'https://zap:8080/JSON/core/view/sites'

  #
  # @param [Proc] block code to apply to each site
  # @return [Array] An Array of URI String's or an empty Array
  # @example urlarray = ZapAttack::Core.urls.new()
  # @see http://zap:8080/JSON/core/view/urls/?zapapiformat=JSON
  #
  class Sites < Array
    attr_reader :json, :text, :sites

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
