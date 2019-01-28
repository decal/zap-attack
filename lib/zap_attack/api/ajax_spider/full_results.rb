# coding: utf-8

module ZapAttack::API
  module AjaxSpider
    FULL_RESULTS_JSON = 'http://zap:8080/JSON/ajaxSpider/view/fullResults'

    attr_reader :reason, :method, :message_id, :url, :status_code

    #
    # Show results created by `AjaxSpider` `scan` method.
    #
    # @return [Boolean]
    #
    def self.full_results
      results_json, text, json = FULL_RESULTS_JSON.dup, '', []
      results_json << asite if !asite.empty?

      open(results_json, OPEN_URI_OPTS) do |x|
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

=begin
{"Reason":"OK","method":"GET","messageId":"29237","url":"https://www.google.com/","statusCode":"200"}
=end
