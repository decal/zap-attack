# coding: utf-8

require 'uri'

module ZapAttack::API
  module AjaxSpider

    AJAX_SPIDER_JSON = 'https://zap:8080/JSON/ajaxSpider/action/scan/?formMethod=GET&url='

    attr_reader :json, :text, :scan

    #
    # Initiate an AJAX Spider scan to continue in the background asynchronously.
    #
    # @param [String] aurl
    #   URL to spider against
    #
    # @return [Boolean] 
    #
    # @see ZapAttack::API::AjaxSpider.full_results
    #
    def self.scan(url:)
      raise(ArgumentError, 'url cannot be nil!') unless url
      raise(TypeError, 'url must be a kind of String or URI!') if !(aurl.kind_of?(String) or aurl.kind_of?(URI))
      raise(ArgumentError, 'url must not be empty!') if url.empty?

      aurl = aurl.to_s if aurl.kind_of?(URI)

      @scan, @text, @json = AJAX_SPIDER_JSON.dup, '', {}
      @scan << aurl 

      open(@scan, OPEN_URI_OPTS) do |x|
        if x.content_type.include?('/json') and x.status.first.to_i.eql?(200)
          x.each_line do |l|
            @text << l
          end
        end
      end

      @json = JSON.parse(@text)

      true
    end
  end
end
