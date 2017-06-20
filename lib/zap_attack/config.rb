# coding: utf-8

require 'openssl'
require 'uri'

module ZapAttack
  module Config
    include OpenSSL, OpenSSL::SSL

    OPEN_URI_OPTS = { :proxy => URI('http://127.0.0.1:8080/'), :redirect => false, :read_timeout => 10, :ssl_verify_mode => VERIFY_NONE }

    DEBUG_ZAPA = true
  end
end
