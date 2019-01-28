# coding: utf-8

module ZapAttack
end

module ZapAttack::API
  AXISURL_JSON = 'http://zap:8080/JSON/core/action/accessUrl?formMethod=%s&followRedirects=%d&url=%s'
  ACCESSURL_JSON = AXISURL_JSON
  DEFAULT_OPTN = { :method => 'GET', :redirs => 1 }.freeze

  #
  # Access a Given URL With ZAP Proxy Through its API.
  #
  # @return [Array#Hash#String,String] Parsed JSON keys/values representing request/response headers/body/etc.
  # @example http_hash = ZapAttack::API.AccessUrl.new('https://google.com')
  # @see http://zap:8080/JSON/core/action/accessUrl
  #
  class AccessUrl < Array
    attr_reader :json, :text, :http

    def initialize(anurl = nil, aopts = { } )
      @http, @json, @text, @opts = {}, [], '', DEFAULT_OPTN.dup

      raise(ArgumentError, 'anurl cannot be nil!') if !anurl
      raise(TypeError, 'anurl must be a kind of String!') if !anurl.kind_of?(String)
      raise(ArgumentError, 'anurl cannot be empty!') if anurl.empty?

      if aopts.empty?
        aopts = @opts
      else
        aopts.merge!(@opts)
      end

      urlj = sprintf(ACCESSURL_JSON, aopts[:method], aopts[:redirs], anurl)

      open(urlj, OPEN_URI_OPTS) do |x|
        if x.content_type.include?('/json') and x.status.first.to_i.eql?(200)
          x.each_line do |l|
            @text << l
          end
        end
      end

      @json = JSON.parse(@text)

      return '' if !@json.key?('accessUrl')

      @http = @json['accessUrl']

      if block_given?
        yield @http
      end

      self << @http
    end
  end
end

if $0 == __FILE__
  require 'zap_attack'

  include ZapAttack, ZapAttack::API

  AccessUrl.new('https://www.google.com/') do |x|
    puts x
  end

  exit 0
end
