# coding: utf-8

require 'spec_helper'
require 'zap_attack/config'

include ZapAttack::Config

describe OPEN_URI_OPTS do
  it 'OPEN_URI_OPTS should not be nil' do
    expect(OPEN_URI_OPTS).to_not be_nil
  end

  it 'OPEN_URI_OPTS should be a kind of Hash' do
    expect(OPEN_URI_OPTS).to be_instance_of(Hash)
  end

  it 'OPEN_URI_OPTS should not be empty' do
    expect(OPEN_URI_OPTS).to_not be_empty
  end
end
