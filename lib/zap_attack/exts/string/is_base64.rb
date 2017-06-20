# coding: utf-8

class String
  BASE64_CHAR_REGEX = %r{[A-Za-z0-9/+=]}

  def is_base64?
    anarr = self.split(//)

    anarr.each do |c|
      return false if !c.match?(BASE64_CHAR_REGEX)
    end

    true
  end
end

if $0 == __FILE__
  astr = 'abc'

  puts astr.is_base64?

  astr = 'notbase64@(*#$&)@!(_#!@'

  puts astr.is_base64?

  exit 0
end
