# coding: utf-8

require 'spec_helper'
require 'zap_attack/exts'

include ZapAttack

describe String do
  it 'ALNUM_REGEX should not be nil' do
    expect(String::ALNUM_REGEX).to_not be_nil
  end

  it 'ALNUM_REGEX should be a kind of Regex' do
    expect(String::ALNUM_REGEX).to be_instance_of(Regexp)
  end
end
