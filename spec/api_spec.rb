# encoding: utf-8

require 'spec_helper'
require 'zap_attack/api'

include ZapAttack, ZapAttack::API

describe Alerts do
  it 'Alerts should be derived from Array' do
    expect(Alerts).to be < Array
  end

  it 'Alerts raises a ArgumentError when initialize receives a nil argument' do
    lambda { Alerts.new(nil) }.should raise_error(ArgumentError)
  end

  it 'Alerts raises a TypeError when initialize receives a non-String and non-URI argument kind' do
    lambda { Alerts.new(1) }.should raise_error(TypeError)
  end

  subject { Alerts.new }

  it 'Alerts responds to json' do
    expect(subject).to respond_to(:json)
  end

  it 'Alerts responds to text' do
    expect(subject).to respond_to(:text)
  end

  it 'Alerts responds to alerts' do
    expect(subject).to respond_to(:alerts)
  end
end

describe Hosts do
  it 'Hosts should be derived from Array' do
    expect(Hosts).to be < Array
  end

  it 'Hosts raises a TypeError if regex is not a kind of Regexp!' do
    lambda { Hosts.new(nil) }.should raise_error(TypeError)
  end

  subject { Hosts.new(%r{^http[s]?[:][/]+}) }

  it 'Hosts responds to json' do
    expect(subject).to respond_to(:json)
  end

  it 'Hosts responds to text' do
    expect(subject).to respond_to(:text)
  end

  it 'Hosts responds to hosts' do
    expect(subject).to respond_to(:hosts)
  end
end

describe Message do
  it 'Message should be derived from Hash' do
    expect(Message).to be < Hash
  end

  it 'Message should raise a TypeError when initialize is invoked with an object which is not a kind of Integer' do
    lambda { Message.new(nil) }.should raise_error(TypeError)
  end

  it 'Message should raise a RangeError when idnum is equal to zero!' do
    lambda { Message.new(0) }.should raise_error(RangeError)
    # lambda { Message.new(-1) }.should raise_error(RangeError)
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

describe MESSAGE_JSON do
  it 'MESSAGE_JSON should not be nil' do
    expect(MESSAGE_JSON).to_not be_nil
  end

  it 'MESSAGE_JSON should be a kind of String' do
    expect(MESSAGE_JSON).to be_instance_of(String)
  end

  it 'MESSAGE_JSON should not be empty' do
    expect(MESSAGE_JSON).to_not be_empty
  end

  it 'MESSAGE_JSON should be able to instantiate as a URI' do
    expect(MESSAGE_JSON).to satisfy { |u| URI(u) }
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
