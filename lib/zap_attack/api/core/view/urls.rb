# coding: utf-8

module ZapAttack::API
  URLS_JSON = 'https://zap:8080/JSON/core/view/urls'

  class Urls < Array
    attr_reader :json, :text, :urls

    #
    # Instantiate custom Ruby Array Object by parsing URL's from ZAP API JSON
    #
    # @param [Regexp] regex 
    #   pattern that URL's must match to become part of the new Urls object
    #
    # @return [Array] 
    #   an Array of URI String's or an empty Array
    #
    # @example 
    #   urlarray = ZapAttack::Core.urls.new()
    #
    # @see 
    #   https://zap:8080/JSON/core/view/urls/?zapapiformat=JSON
    #
    def initialize(regex = nil)
      raise(TypeError, 'regex must be a kind of Regexp!') if regex and !regex.kind_of?(Regexp)

      @urls, @json, @text = [], [], ''

      open(URLS_JSON, OPEN_URI_OPTS) do |x|
        if x.content_type.include?('/json') and x.status.first.to_i.eql?(200)
          x.each_line do |l|
            @text << l
          end
        end
      end

      @json = JSON.parse(@text)

      return [] if !@json.key?('urls')

      @urls = @json['urls']

      if block_given?
        if regex
          @urls.each do |u|
            if u =~ regex
              yield u

              self << u
            end
          end
        else
          @urls.each do |u|
            yield u

            self << u
          end
        end
      end

      if regex
        @urls.each do |u|
          self << u if u =~ regex
        end
      else
        self.concat(@urls)
      end

      self
    end
  end
end
