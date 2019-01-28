require 'json'
require 'openssl'
require 'open-uri'
require 'uri'

include ZapAttack::Config

module ZapAttack::API
  #
  # URL to access params via ZAP API
  #
  PARAMS_JSON = 'http://zap:8080/JSON/params/view/params'

  class Params < Array
    attr_reader :json, :text, :params

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
    #   http://zap:8080/JSON/params/view/params
    #
    def initialize(asite = '')
      raise(ArgumentError, 'asite cannot be nil!') if !asite
      raise(TypeError, 'asite must be a kind of String or URI!') if !(asite.kind_of?(String) or asite.kind_of?(URI))

      asite = "#{asite.host}:#{asite.port}" if asite.kind_of?(URI)
      params_json, @text, @params, @json = PARAMS_JSON.dup, '', [], []
      params_json << asite if !asite.empty?

      open(params_json, OPEN_URI_OPTS) do |x|
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

      @params.each do |xparam|
        index, jparam = 0, xparam['Parameter']

        while index < jparam.size
          zparam = jparam[index]
          ahash, atype = zparam, zparam['type']

          if !atype or atype.empty?
            index += 1

            next
          end

          if atype.eql?('cookie')
            next_param = jparam[index + 1]

            if !next_param or next_param.empty? 
              index += 2

              next
            end

            last_param = jparam[index + 2]

            if !last_param or last_param.empty?
              index += 3

              next
            end

            ahash.merge!(next_param) if next_param.key?('Values') or next_param.key?('Flags')
            ahash.merge!(last_param) if last_param.key?('Values') or last_param.key?('Flags')

            yield ahash if block_given?

            self.concat( [ ahash ] )

            index += 3
          else
            if !(atype.eql?('url') or atype.eql?('header'))
              index += 1
              
              next
            end

            next_param = jparam[index + 1]

            if !next_param or next_param.empty?
              index += 2 

              next
            end

            ahash.merge!(next_param) if next_param.key?('Values')

            yield ahash if block_given?

            self.concat( [ ahash ] )

            index += 2
          end
        end
      end

      self
    end
  end
end
