# coding: utf-8

module ZapAttack::API
  VERSION_JSON = 'http://zap:8080/JSON/core/view/version'

  #
  # Get the current version of the OWASP ZAP API as a string.
  #
  # @return [String] current version of the ZAP API
  # @example urlarray = ZapAttack::API.Version.new
  # @see http://zap:8080/JSON/core/view/version
  #
  class Version < String
    attr_reader :json, :text, :version

    def initialize
      @version, @json, @text = '', [], ''

      open(VERSION_JSON, OPEN_URI_OPTS) do |x|
        if x.content_type.include?('/json') and x.status.first.to_i.eql?(200)
          x.each_line do |l|
            @text << l
          end
        end
      end

      @json = JSON.parse(@text)

      return '' if !@json.key?('version')

      @version = @json['version']

      super(@version.clone)

      self
    end
  end
end
