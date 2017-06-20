# coding: utf-8

class String
  LOWER_REGEX = %r{[a-z]+}

  def is_lower?
    self.match?(LOWER_REGEX)
  end
end

if $0 == __FILE__
  astr = 'abcd'

  puts astr.is_lower?

  astr = '1234'

  puts astr.is_lower?

  exit 0
end
