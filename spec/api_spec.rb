# encoding: utf-8

require 'spec_helper'
require 'zap_attack/api'

include ZapAttack::API

describe Alerts do
  it 'Alerts should be derived from Array' do
    expect(Alerts).to be < Array
  end
end

describe Sites do
  it 'Sites should be derived from Array' do
    expect(Sites).to be < Array
  end
end

describe Urls do
  it 'Urls should be derived from Array' do
    expect(Urls).to be < Array
  end
end

describe ALERTS_JSON do
  it 'ALERTS_JSON should not be nil' do
    expect(ALERTS_JSON).to_not be_nil
  end

  it 'ALERTS_JSON should be a kind of String' do
    expect(ALERTS_JSON).to be_instance_of(String)
  end

  it 'ALERTS_JSON should not be empty' do
    expect(ALERTS_JSON).to_not be_empty
  end

  it 'ALERTS_JSON should be able to instantiate as a URI' do
    expect(ALERTS_JSON).to satisfy { |u| URI(u) }
  end
end

describe SITES_JSON do
  it 'SITES_JSON should not be nil' do
    expect(SITES_JSON).to_not be_nil
  end

  it 'SITES_JSON should be a kind of String' do
    expect(SITES_JSON).to be_instance_of(String)
  end

  it 'SITES_JSON should not be empty' do
    expect(SITES_JSON).to_not be_empty
  end

  it 'SITES_JSON should be able to instantiate as a URI' do
    expect(SITES_JSON).to satisfy { |u| URI(u) }
  end
end

describe URLS_JSON do
  it 'URLS_JSON should not be nil' do
    expect(URLS_JSON).to_not be_nil
  end

  it 'URLS_JSON should be a kind of String' do
    expect(URLS_JSON).to be_instance_of(String)
  end

  it 'URLS_JSON should not be empty' do
    expect(URLS_JSON).to_not be_empty
  end

  it 'URLS_JSON should be able to instantiate as a URI' do
    expect(URLS_JSON).to satisfy { |u| URI(u) }
  end
end
