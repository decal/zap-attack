# coding: utf-8

class String
  DIGIT_REGEX = %r{[0-9]+}

  def is_digit?
    self.match?(DIGIT_REGEX)    
  end
end

if $0 == __FILE__
  astr = '41414141'

  puts astr.is_digit?

  astr = 'QWERTY'

  puts astr.is_digit?

  exit 0
end
