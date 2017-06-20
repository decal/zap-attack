# coding: utf-8

require 'uri'

module ZapAttack::Data
  class Param
    attr_reader :site, :name, :timesused, :type, :values, :flags

    #
    # Param data object parsed from OWASP API JSON.
    #
    # @param [String] site
    #   DNS host name and port where parameter originated from
    #
    # @param [String] name
    #   Name of HTTP header
    #
    # @param [String] type
    #   Type of parameter: header, cookie or url
    #
    # @param [Integer] ntimesused
    #   Number of times parameter was repeated in responses from site
    #
    # @param [Array] values
    #   String parameter was assigned to, i.e. an "rvalue"
    #
    # @param [Array] flags
    #   Optional attribute names and possibly values
    #
    def initialize(site: '', name: '', type: '', timesused: 0, values: [], flags: [])
      raise(ArgumentError, 'site must not be nil!') unless site
      raise(TypeError, 'site must be a kind of String or URI!') if !(site.kind_of?(String) or site.kind_of?(URI))
      raise(ArgumentError, 'site must not be empty!') if site.kind_of?(String) and site.empty?

      raise(ArgumentError, 'name must not be nil!') unless name
      raise(TypeError, 'name must be a kind of String!') if !aname.kind_of?(String)
      raise(ArgumentError, 'name must not be nil!') if !name.empty?

      raise(ArgumentError, 'type must not be nil!') unless atype
      raise(TypeError, 'atype must be a kind of String!') if !atype.kind_of?(String)
      raise(ArgumentError, 'type must not be empty!') if atype.empty?

      raise(ArgumentError, 'timesused must not be nil!') if !timesused
      raise(TypeError, 'timesused must be a kind of Integer!') if !timesused.kind_of?(Integer)
      raise(RangeError, 'timesused must be non-negative!') if timesused < 0

      raise(ArgumentError, 'values must not be nil!') if !values
      raise(TypeError, 'values must be a kind of Array!') if !values.kind_of?(Array)

      raise(ArgumentError, 'flags must not be nil!') if !flags
      raise(TypeError, 'flags must be a kind of Array!') if !flags.kind_of?(Array)
      raise(ArgumentError, 'flags must not be empty!') if flags.empty?

      @site, @name, @type, @timesused, @values, @flags = site, name, type, ntimesused, values, flags
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
