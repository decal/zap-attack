# encoding: utf-8

require 'json'
require 'open-uri'
require 'openssl'
require 'uri'

module ZapAttack
end

module ZapAttack::API
  #
  # URL to access params via ZAP API
  #
  PARAMS_JSON = 'https://zap:8080/JSON/params/view/params'

  class Params < Array
    attr_reader :json, :text, :params

    private def make_hash(**keys)
    end

    #
    # Instantiate Ruby Params Array Object by parsing JSON from ZAP API
    # 
    # @param [String] asite
    #   only retrieve params associated with the given site "host:port" tuple
    #
    # @raise [ArgumentError] 
    #   asite cannot be nil
    #
    # @raise [TypeError]
    #   asite must be a kind of String or URI
    #
    # @return [Array#Hash] 
    #   a Hash Array consisting of pairs describing the parameters
    #
    # @yield [Hash]
    #   Hash object encapsulates param member variable names/values as String's
    #
    # @example 
    #   params = ZapAttack::API.Params.new('snippets.cdn.mozilla.net:443')
    #
    # @see 
    #   ZapAttack::Data::Param
    #   https://zap:8080/JSON/params/view/params
    #
    def initialize(asite = '')
      raise(ArgumentError, 'asite cannot be nil!') if !asite
      raise(TypeError, 'asite must be a kind of String or URI!') if !(asite.kind_of?(String) or asite.kind_of?(URI))

      asite = "#{asite.host}:#{asite.port}" if asite.kind_of?(URI)

      params_json, @text, @params, @json = PARAMS_JSON.dup, '', [], []
      params_json << asite if !asite.empty?

      # open(params_json, OPEN_URI_OPTS) do |x|
      open(params_json, { :proxy => URI('http://127.0.0.1:8080/'), :redirect => false, :read_timeout => 10, :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE } ) do |x|
        if x.content_type.include?('/json') and x.status.first.to_i.eql?(200)
          x.each_line do |l|
            @text << l
          end
        end
      end

      @json = JSON.parse(@text)

      return [] if !@json.key?('Parameters')

      @params = @json['Parameters']

      return [] if !@params or @params.size.zero?

      @params = @params.first

      return [] if !@params.key?('Parameter')

      ahash, anarr, index, @params = {}, [], 0, @params['Parameter']

      ahash = @params[0].merge(@params[1])

      while index < params.size
        ahash = @params[index].merge(@params[index + 1])

        index += 2

        yield ahash if block_given?

        self.concat( [ ahash ] )
      end

      self
    end
  end
end

if $0 == __FILE__
  params = ZapAttack::API::Params.new

  p params
end
