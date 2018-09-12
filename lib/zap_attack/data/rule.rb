# coding: utf-8

require 'uri'

module ZapAttack::Data
  class Rule
    #
    # Constants representing the various matchType values
    #

    # request header name
    REQ_HEADER = 1
    # request header string (value)
    REQ_HEADER_STR = 2
    # request body string
    REQ_BODY_STR = 3

    # response header name
    RESP_HEADER = 4
    # response header string 
    RESP_HEADER_STR = 5
    # response body string
    RESP_BODY_STR = 6

    private_constant :REQ_HEADER, :REQ_HEADER_STR, :REQ_BODY_STR, :RESP_HEADER, :RESP_HEADER_STR, :RESP_BODY_STR

    #
    # @attr_reader [Integer] matchType
    #   number above zero representing the area of HTTP protocol data unit to compare against
    #
    # @attr_reader [String] description
    #   detailed summary of the pattern matching rule
    #
    # @attr_reader [String, Regexp] matchString
    #   string or regular expression to use during comparison
    #
    # @attr_reader [String] initiators
    #   which ZAP user interface component initiated the replacer rule
    #
    # @attr_reader [Boolean] matchRegex 
    #   if set to true then treat matchString as a regular expression
    #
    # @attr_reader [String] replacement
    #   character sequence to overwrite matched data
    #
    # @attr_reader [Boolean] enabled
    #   set to true if this rule is to be treated as active
    #
    attr_reader :matchType, :description, :matchString, :initiators, :matchRegex, :replacement, :enabled

    alias :type :matchType

    alias :desc     :description
    alias :describe :description

    alias :string :matchString

    alias :initiates :initiators
    alias :inits     :initiators

    alias :regex       :matchRegex
    alias :regexp      :matchRegex
    alias :pattern     :matchRegex
    alias :matchRegexp :matchRegex

    alias :replacer :replacement
    alias :replace  :replacement

    alias :enabler :enabled
    alias :enable  :enabled

    #
    # @method initializer
    #   Allocate and initialize a new replacer Rule for OWASP ZAP.
    #
    # @param [Integer] matchType 
    #   Which part of the HTTP protocol data to match 
    #
    # @param [String] description
    #   Terse title that describes the rule 
    #
    # @param [String] matchString
    #   The string to match a piece of HTTP protocol data against
    #
    # @param [String] initiators
    #   Blank or a comma separated list of integers
    #
    # @param [Boolean] matchRegex
    #   Set to true if matchString is to be treated as a regular expression
    #
    # @param [String] replacement
    #   The string to replace the matched string with
    #
    # @param [String] enabled
    #   Set to true if the rule is activated
    #
    # @see ZapAttack::Replacer::Rules
    # @see https://zap/json/replacer/view/rules/
    # @see https://github.com/zaproxy/zaproxy/blob/develop/src/org/parosproxy/paros/network/HttpSender.java
    #
    # @example Initialize a new rule object
    #   r = Rule.new(REQ_BODY_STR, 'this is a rule', 'HTTP/1.1', '', false, "HTTP/1.#{bof}", true) 
    #   #=> 
    #   Rule
    #
    def initialize(matchType: REQ_BODY_STR, description: 'default rule description', matchString: '', initiators: '', matchRegex: false, replacement: '', enabled: true)
      raise(ArgumentError, 'matchType must not be nil!') unless matchType
      raise(TypeError, 'matchType must be a kind of Integer!') if !matchType.kind_of?(Integer)
      raise(ArgumentError, 'matchType must not be zero!') if matchType.zero?

      raise(ArgumentError, 'description must not be nil or empty!') unless description
      raise(TypeError, 'description must be a kind of String!') if !description.kind_of?(String)
      raise(ArgumentError, 'description must not be nil or empty!') if description.empty?

      raise(ArgumentError, 'matchString must not be nil or empty!') unless matchString
      raise(TypeError, 'matchString must be a kind of String!') if !matchString.kind_of?(String)
      raise(ArgumentError, 'matchString must not be empty!') if matchString.empty?

      raise(ArgumentError, 'initiators must not be nil or empty!') unless initiators
      raise(TypeError, 'initiators must be a kind of String!') if !initiators.kind_of?(String)
      raise(ArgumentError, 'initiators must not be nil or empty!') if initiators.empty?

      raise(ArgumentError, 'matchRegex must not be nil!') unless matchRegex
      raise(TypeError, 'matchRegex must be a kind of TrueClass or FalseClass!') if !(matchRegex.kind_of?(TrueClass) or matchRegex.kind_of?(FalseClass))

      raise(ArgumentError, 'replacement must not be nil!') unless replacement
      raise(TypeError, 'replacement must be a kind of String!') if !replacement.kind_of?(String)
      raise(ArgumentError, 'replacement must not be empty!') if replacement.empty?

      raise(ArgumentError, 'enabled must not be nil!') unless enabled
      raise(TypeError, 'enabled must be a kind of TrueClass or FalseClass!') if !(enabled.kind_of?(TrueClass) or enabled.kind_of?(FalseClass))

      @matchType, @description, @matchString, @initiators, @matchRegex, @replacement, @enabled = matchType, description, matchString, initiators, matchRegex, replacement, enabled

      self
    end

    # 
    # @method to_s 
    #   Returns a string representation of this rule
    #
    # @see Object
    # @see String
    #
    def to_s
      "#{@matchType} #{@description} #{@matchString} #{@initiators} #{@matchRegex} #{@replacement} #{@enabled}"
    end
  end
end

=begin
{"rules":[{"matchType":"RESP_HEADER","description":"Remove CSP","matchString":"Content-Security-Policy","initiators":"","matchRegex":"false","replacement":"","enabled":"false"},{"matchType":"RESP_HEADER","description":"Remove HSTS","matchString":"Strict-Transport-Security","initiators":"","matchRegex":"false","replacement":"","enabled":"true"},{"matchType":"REQ_HEADER","description":"Replace User-Agent with shellshock attack","matchString":"User-Agent","initiators":"","matchRegex":"false","replacement":"() {:;}; /bin/cat /etc/passwd","enabled":"false"}]}
=end
