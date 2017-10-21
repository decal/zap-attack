# coding: utf-8

class String
  UPPER_REGEX = %r{[A-Z]+}

  # 
  # @return [Boolean] if this string is only composed of capital letters
  #
  def is_upper?
    self.match?(UPPER_REGEX)
  end
end

if $0 == __FILE__
  astr = 'ABCD'

  puts astr.is_upper?

  astr = '1234'

  puts astr.is_upper?

  exit 0
end
