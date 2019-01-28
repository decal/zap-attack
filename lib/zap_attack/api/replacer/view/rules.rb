# coding: utf-8

module ZapAttack::Replacer
  #
  # URL to access alerts via ZAP API with baseurl parameter to narrow results
  #
  RULES_JSON = 'http://zap:8080/JSON/replacer/view/rules'

  class Rules < Array
    attr_reader :json, :text, :alerts

    #
    # Instantiate Ruby Rules Array Object by parsing JSON from ZAP API
    # 
    # @return [Array#Hash] 
    #   a Hash Array consisting of pairs describing the threat
    #
    # @yield [Hash]
    #   Hash object encapsulates rules member variable names/values as String's
    #
    # @example 
    #   rules = ZapAttack::Replacer.Rules.new
    #
    # @see 
    #   ZapAttack::Data::Rule
    #   http://zap:8080/JSON/replacer/view/rules
    #
    def initialize(&block)
      rules_json, @text, @rules, @json = RULES_JSON.dup, '', [], []
      rules_json << abase if !abase.empty?

      open(rules_json, OPEN_URI_OPTS) do |x|
        if x.content_type.include?('/json') and x.status.first.to_i.eql?(200)
          x.each_line do |l|
            @text << l
          end
        end
      end

      @json = JSON.parse(@text)

      return [] if !@json.key?('rules')

      @alerts = @json['rules']

      if block_given? 
        @alerts.each do |a|
          yield a
        end
      end

      self.concat(@rules)
    end
  end
end
