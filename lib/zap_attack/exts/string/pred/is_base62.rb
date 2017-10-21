# coding: utf-8

class String
  BASE62_CHAR_REGEX = %r{[A-Za-z0-9]}

  #
  # @return [Boolean] if this string resembles Base62 encoding
  #
  def is_base62?
    anarr = self.split(//)

    anarr.each do |c|
      return false if !c.match?(BASE62_CHAR_REGEX)
    end

    true
  end
end

if $0 == __FILE__
  astr = 'abc'

  puts astr.is_base62?

  astr = 'notbase62@(*#$&)@!(_#!@'

  puts astr.is_base62?

  exit 0
end
