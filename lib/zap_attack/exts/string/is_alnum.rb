# coding: utf-8

class String
  ALNUM_REGEX = %r{[A-Fa-f0-9]+}

  def is_alnum?
    self.match?(ALNUM_REGEX)
  end
end

if $0 == __FILE__
  astr = 'abc123XYZ'

  puts astr.is_alnum?

  astr = '_'

  puts astr.is_alnum?

  exit 0
end
