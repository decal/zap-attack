# coding: utf-8

require 'uri'

module ZapAttack::Data
  class Alert
    attr_reader :cwe, :name, :url, :method, :description, :reference, :solution, :risk, :attack

    alias :threat :description
    alias :vuln   :description
    alias :desc   :description

    alias :recommendation :solution
    alias :mitigation     :solution
    alias :patch          :solution

    alias :information :reference
    alias :more_info   :reference
    alias :info        :reference

    alias :webdav :method
    alias :action :method
    alias :verb   :method

    alias :location :url
    alias :href     :url
    alias :link     :url

    alias :impact   :risk
    alias :severity :risk
    alias :danger   :risk

    alias :exploit :attack
    alias :poc     :attack
    alias :example :attack

    #
    # Allocate and initialize a new Alert detected by OWASP ZAP.
    #
    # @param [Integer] cwe
    #   Common Weakness Enumeration identifier assigned by MITRE corporation
    #
    # @see https://cwe.mitre.org
    #
    # @param [String] name
    #   Terse title that describes the vulnerability described by the ZAP alert
    #
    # @param [String] url
    #   Location corresponding to where the weakness was detected 
    #
    # @param [String] method
    #   HTTP protocol verb such as "GET" or "POST" in use when issue was found
    #
    # @param [String] description
    #   Verbose definition that describes specifics of the vulnerability 
    #
    # @param [String] reference 
    #   Documentation one may refer to for more information about the issue
    #
    # @param [String] solution
    #   Patches, mitigations or workarounds to implement as prevention
    #
    # @param [String] risk
    #   Rating that specifies the severity of the detected vulnerability
    #
    # @param [String] attack
    #   Steps that a malicious attacker would take to exploit the issue
    #
    def initialize(name: '', url: '', method: '', description:  '', reference: '', solution: '', risk: '', attack: '', cwe: 0)
      raise(ArgumentError, 'name must not be nil!') unless name
      raise(TypeError, 'name must be a kind of String!') if !name.kind_of?(String)
      raise(ArgumentError, 'name must not be empty!') if name.empty?

      raise(ArgumentError, 'url must not be nil!') unless url 
      raise(TypeError, 'url must be a kind of String or URI!') if !(url.kind_of?(String) or url.kind_of?(URI))
      raise(ArgumentError, 'url must not be empty!') if url.kind_of?(String) and url.empty? 

      raise(ArgumentError, 'method must not be nil!') unless method 
      raise(TypeError, 'method must be a kind of String!') if !method.kind_of?(String)
      raise(ArgumentError, 'method must not be empty!') if method.empty?

      raise(ArgumentError, 'description must not be nil!') unless description 
      raise(TypeError, 'description must be a kind of String!') if !description.kind_of?(String)
      raise(ArgumentError, 'description must not be empty!') if description.empty?

      raise(ArgumentError, 'reference must not be nil or empty!') if !reference or reference.empty?
      raise(TypeError, 'reference must be a kind of String!') if !reference.kind_of?(String)

      raise(ArgumentError, 'solution must not be nil or empty!') if !solution or solution.empty?
      raise(TypeError, 'solution must be a kind of String!') if !solution.kind_of?(String)

      raise(ArgumentError, 'risk must not be nil!') if !risk
      raise(ArgumentError, 'risk must not be empty!') if risk.empty?
      raise(TypeError, 'risk must be a kind of String!') if !risk.kind_of?(String)

      raise(ArgumentError, 'attack must not be nil or empty!') if !attack or attack.empty?
      raise(TypeError, 'attack must be a kind of String!') if !attack.kind_of?(String)

      raise(ArgumentError, 'cwe must not be nil!') if !cwe
      raise(TypeError, 'cwe must be a kind of Integer!') if !cwe.kind_of?(Integer)
      raise(RangeError, 'cwe must be non-negative!') if cwe < 0

      @cwe, @name, @url, @method, @description, @reference, @solution, @risk, @attack = cwe, name, url, method, description, reference, solution, risk, attack 

      self
    end

    def to_s
      "#{@name} #{@url} #{@risk} #{@description} #{@solution} #{@reference}"
    end
  end
end

=begin
{"sourceid"=>"3", "other"=>"", "method"=>"GET", "evidence"=>"", "pluginId"=>"10015", "cweid"=>"525", "confidence"=>"Medium", "wascid"=>"13", "description"=>"The cache-co
ntrol and pragma HTTP header have not been set properly or are missing allowing the browser and proxies to cache content.", "messageId"=>"1724", "url"=>"https://secure.i
nformaction.com/ipecho/", "reference"=>"https://www.owasp.org/index.php/Session_Management_Cheat_Sheet#Web_Content_Caching", "solution"=>"Whenever possible ensure the ca
che-control HTTP header is set with no-cache, no-store, must-revalidate; and that the pragma HTTP header is set with no-cache.", "alert"=>"Incomplete or No Cache-control
 and Pragma HTTP Header Set", "param"=>"Cache-Control", "attack"=>"", "name"=>"Incomplete or No Cache-control and Pragma HTTP Header Set", "risk"=>"Low", "id"=>"637"}
=end
