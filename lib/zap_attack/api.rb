# encoding: utf-8

require 'zap_attack/config'

module ZapAttack
  module API

  include ZapAttack::Config
  end
end

require 'json'
require 'open-uri'
require 'resolv-replace'
require 'uri'

require 'zap_attack/api/core'
