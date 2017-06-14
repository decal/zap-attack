# encoding: utf-8

require 'uri'

module ZapAttack::API
  module AjaxSpider

    AJAX_SPIDER_JSON = 'https://zap:8080/JSON/ajaxSpider/action/scan/?formMethod=GET&url='

    #
    # Start scanning with AJAX Spider.
    #
    # @param [String] aurl
    #   URL to spider against
    #
    # @return [Boolean] 
    #
    # @see ZapAttack::API::AjaxSpider.full_results
    #
    def self.scan(aurl = '')
      raise(ArgumentError, 'url cannot be nil or empty!') if !aurl or aurl.empty?
      raise(TypeError, 'url must be a kind of String or URI!') if !(aurl.kind_of?(String) or aurl.kind_of?(URI))

      aurl = aurl.to_s if aurl.kind_of?(URI)

      true
    end
  end
end
