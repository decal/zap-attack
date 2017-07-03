# coding: utf-8

module ZapAttack::API
  HOSTS_JSON = 'https://zap:8080/JSON/core/view/hosts'

  class Hosts < Array
    attr_reader :json, :text, :hosts

    #
    # Instantiate custom Ruby Array Object by parsing hosts from ZAP API JSON
    #
    # @param [Regexp] regex 
    #   pattern that URL's must match to become part of the new Urls object
    #
    # @return [Array] 
    #   an Array of URI String's or an empty Array
    #
    # @example 
    #   urlarray = ZapAttack::Core.hosts.new()
    #
    # @see 
    #   https://zap:8080/JSON/core/view/hosts/?zapapiformat=JSON
    #
    def initialize(regex = nil)
      raise(TypeError, 'regex must be a kind of Regexp!') if !regex.kind_of?(Regexp)

      @hosts, @json, @text = [], [], ''

      open(HOSTS_JSON, OPEN_URI_OPTS) do |x|
        if x.content_type.include?('/json') and x.status.first.to_i.eql?(200)
          x.each_line do |l|
            @text << l
          end
        end
      end

      @json = JSON.parse(@text)

      return [] if !@json.key?('hosts')

      @hosts = @json['hosts']

      if block_given?
        if regex
          @hosts.each do |u|
            if u =~ regex
              yield u

              self << u
            end
          end
        else
          @hosts.each do |u|
            yield u

            self << u
          end
        end
      end

      if regex
        @hosts.each do |u|
          self << u if u =~ regex
        end
      else
        self.concat(@hosts)
      end

      self
    end
  end
end
