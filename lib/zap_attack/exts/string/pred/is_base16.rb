# coding: utf-8

class String
  BASE16_CHAR_REGEX = %r{[A-Fa-f0-9]+}
  BASE16_CHAR_REGEX_UPPER = %r{[A-F0-9]+}
  BASE16_CHAR_REGEX_LOWER = %r{[a-f0-9]+}

  #
  # @return [Boolean] if this string resembles Base16 encoding
  # @see {https://tools.ietf.org/html/rfc4648 The Base16, Base32, and Base64 Data Encodings}
  #
  def is_base16?
    anarr = self.split(//)

    anarr.each do |c|
      return false if !c.match?(BASE16_CHAR_REGEX)
    end

    true
  end
end

if $0 == __FILE__
  astr = '41414141'

  puts astr.is_base16?

  astr = 'blahabcxyz123'

  puts astr.is_base16?

  exit 0
end
