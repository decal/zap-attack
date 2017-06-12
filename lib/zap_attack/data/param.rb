# encoding: utf-8

require 'uri'

module ZapAttack::Data
  class Param
    attr_reader :site, :name, :timesused, :type, :values, :flags

    #
    # @param [String] asite
    #
    # @param [String] aname
    #
    # @param [String] atype
    #
    # @param [Integer] ntimesused
    #
    # @param [Array] xvalues
    #
    # @param [Array] xflags
    #
    def initialize(asite = '', aname = '', atype = '', ntimesused = 0, xvalues = [], xflags = [])
      raise(ArgumentError, 'asite must not be nil or empty!') if !asite or asite.empty?
      raise(TypeError, 'asite must be a kind of String or URI!') if !asite.kind_of?(String) and !asite.kind_of?(URI)

      raise(ArgumentError, 'aname must not be nil or empty!') if !aname or aname.empty?
      raise(TypeError, 'aname must be a kind of String!') if !aname.kind_of?(String)

      raise(ArgumentError, 'atype must not be nil or empty!') if !atype or atype.empty?
      raise(TypeError, 'atype must be a kind of String!') if !atype.kind_of?(String)

      raise(ArgumentError, 'ntimesused must not be nil!') if !ntimesused
      raise(TypeError, 'ntimesused must be a kind of Integer!') if !ntimesused.kind_of?(Integer)
      raise(RangeError, 'ntimesused must be non-negative!') if ntimesused < 0

      raise(ArgumentError, 'xvalues must not be nil!') if !xvalues
      raise(TypeError, 'xvalues must be a kind of Array!') if !xvalues.kind_of?(Array)

      raise(ArgumentError, 'xflags must not be nil!') if !xflags
      raise(TypeError, 'xflags must be a kind of Array!') if !xflags.kind_of?(Array)


      @site, @name, @type, @timesused, @values, @flags = asite, aname, atype, ntimesused, xvalues, xflags
    end

    def to_s
      "#{@site} #{@name} #{@type} #{@timesused} #{@values} #{@flags}"
    end
  end
end

=begin
{"site"=>"www.oracle.com:80", "name"=>"Connection", "timesUsed"=>"1", "type"=>"header", "Values"=>["keep-alive"]}


{"site"=>"versioncheck-bg.addons.mozilla.org:443", "name"=>"id", "timesUsed"=>"8", "type"=>"url", "Values"=>["firefox@getpocket.
com", "aushelper@mozilla.org", "screenshots@mozilla.org", "{972ce4c6-7e08-4474-a285-3208198ce6fd}", "webcompat@mozilla.org", "firefox-h
otfix@mozilla.org", "e10srollout@mozilla.org", "{73a6fe31-595d-460b-a920-fcc0f8843232}"]}

{"site"=>"tags.bluekai.com:443", "name"=>"bkdc", "timesUsed"=>"4", "type"=>"cookie", "Flags"=>["path=/", "domain=.bluekai.com",
"expires=Sat, 09-Dec-2017 01:36:16 GMT"], "Values"=>["phx", "wdc"]}
=end
