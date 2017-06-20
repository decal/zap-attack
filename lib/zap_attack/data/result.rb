# coding: utf-8

require 'uri'

module ZapAttack::Data
  class Result
    attr_reader :reason, :method, :message_id, :url, :status_code

    #
    # Allocate and initialize individual result item from full AJAX Spider scan.
    #
    # @param [String] reason
    #   HTTP status string, i.e. "OK" for response with numeric status code 200  
    #
    # @param [String] method
    #   HTTP request action that was made to spider sub-section of web site
    #   
    # @see ZapAttack::HTTP::METHODS
    #
    # @param [Integer] message_id
    #   Sequential numeric value that acts as a unique identifier of this result
    #
    # @param [String] url
    #   Location of document that was accessed during AJAX Spider scan
    #
    # @param [Integer] status_code
    #   HTTP code representing web server context within response processing
    #
    # @see ZapAttack::AjaxSpider.scan
    # @see ZapAttack::AjaxSpider.full_results
    #
    # @example
    #   r = Result.new(reason: 'OK', method: 'GET', message_id: 29237, url: 'https://www.google.com/', status_code: 200)
    #
    def initialize(reason: '', method: '', message_id: '', url: '', status_code: '')
      raise(ArgumentError, 'reason must not be nil!') unless reason
      raise(TypeError, 'reason must be a kind of String!') if !reason.kind_of?(String)
      raise(ArgumentError, 'reason must not be nil!') if reason.empty?

      raise(ArgumentError, 'method must not be nil!') unless method
      raise(TypeError, 'method must be a kind of String!') if !method.kind_of?(String)
      raise(ArgumentError, 'method must not be nil!') if method.empty?

      method.upcase!

      raise(RangeError, 'method must be an HTTP verb!') if !(method.eql?('GET') or method.eql?('POST') or method.eql?('PUT') or method.eql?('HEAD') or method.eql?('OPTIONS'))

      raise(ArgumentError, 'message_id must not be nil!') unless message_id
      raise(TypeError, 'message_id must be a kind of String!') if !message_id.kind_of?(String)
      raise(ArgumentError, 'message_id must not be nil!') if message_id.empty?

      raise(ArgumentError, 'url must not be nil!') unless url
      raise(TypeError, 'url must be a kind of String!') if !(url.kind_of?(String) or url.kind_of?(URI))
      raise(ArgumentError, 'url must not be nil!') if url.kind_of?(String) and url.empty?
      
      raise(ArgumentError, 'status_code must not be nil!') unless status_code
      raise(TypeError, 'status_code must be a kind of Integer!') if !status_code.kind_of?(Integer)
      raise(RangeError, 'status_code must be non-negative!') if status_code < 0
      raise(RangeError, 'status_code must be less than one thousand!') if status_code >= 1000

      @reason, @method, @message_id, @url, @status_code = reason, method, message_id, url, status_code
    end

    def to_s
      "#{@reason} #{@method} #{@message_id} #{@url} #{@status_code}"
    end
  end
end

=begin
{"Reason":"OK","method":"GET","messageId":"29237","url":"https://www.google.com/","statusCode":"200"}
=end
