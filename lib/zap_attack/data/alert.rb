# encoding: utf-8

require 'uri'

module ZapAttack::Data
  class Alert
    attr_reader :messageid, :cweid, :name, :url, :method, :description, :reference, :solution, :risk, :attack

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

    # @param [Integer] ncwe
    # @param [String] aname
    # @param [String] anurl
    # @param [String] ameth
    # @param [String] adesc
    # @param [String] refer
    # @param [String] solve
    # @param [String] arisk
    # @param [String] anexp
    def initialize(aname = '', anurl = '', ameth = '', adesc = '', refer = '', solve = '', arisk = '', anexp = '', ncwe = 0)
      raise EmptyError.new('anurl must not be nil or empty!') if !anurl or anurl.empty?
      raise TypeError.new('anurl must be a kind of String or URI!') if !anurl.kind_of?(String) and !anurl.kind_of?(URI)

      raise EmptyError.new('ameth must not be nil or empty!') if !ameth or ameth.empty?
      raise TypeError.new('ameth must be a kind of String!') if !ameth.kind_of?(String)

      raise EmptyError.new('ameth must not be nil or empty!') if !adesc or adesc.empty?
      raise TypeError.new('ameth must be a kind of String!') if !adesc.kind_of?(String)

      raise EmptyError.new('refer must not be nil or empty!') if !refer or refer.empty?
      raise TypeError.new('refer must be a kind of String!') if !refer.kind_of?(String)

      raise EmptyError.new('solve must not be nil or empty!') if !solve or solve.empty?
      raise TypeError.new('solve must be a kind of String!') if !solve.kind_of?(String)

      raise ArgumentError.new('arisk must not be nil!') if !arisk
      raise EmptyError.new('arisk must not be empty!') if arisk.empty?
      raise TypeError.new('arisk must be a kind of String!') if !arisk.kind_of?(String)

      raise EmptyError.new('anexp must not be nil or empty!') if !anexp or anexp.empty?
      raise TypeError.new('anexp must be a kind of String!') if !anexp.kind_of?(String)

      raise EmptyError.new('ncwe must not be nil!') if !ncwe
      raise TypeError.new('ncwe must be a kind of Integer!') if !ncwe.kind_of?(Integer)
      raise RangeError.new('ncwe must be non-negative!') if ncwe < 0

      @cweid, @name, @url, @method, @description, @reference, @solution, @risk, @attack = ncwe, aname, anurl, ameth, adesc, refer, solve, arisk, anexp 
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
