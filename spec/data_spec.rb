# coding: utf-8

require 'spec_helper'
require 'zap_attack/data'

include ZapAttack::Data

describe Alert do 
  it 'raises ArgumentError when there are no initializer arguments' do
    expect { Alert.new }.to raise_error(ArgumentError)
  end

  it 'raises ArgumentError when the name initializer argument is nil or empty' do
    expect { Alert.new(name: nil) }.to raise_error(ArgumentError)
    expect { Alert.new(name: '') }.to raise_error(ArgumentError)
  end

  it 'raises ArgumentError when the url initializer argument is nil or empty' do
    expect { Alert.new(name: 'aname', url: nil) }.to raise_error(ArgumentError)
    expect { Alert.new(name: 'aname', url: '') }.to raise_error(ArgumentError)
  end

  it 'raises TypeError when the url initializer argument is not a kind of String or URI' do
    expect { Alert.new(name: 'aname', url: 1) }.to raise_error(TypeError)
  end

  it 'raises ArgumentError when the method initializer argument is nil or empty' do
    expect { Alert.new(name: 'aname', url: URI('https://google.com'), method: nil) }.to raise_error(ArgumentError)
    expect { Alert.new(name: 'aname', url: URI('https://google.com'), method: '') }.to raise_error(ArgumentError)
  end

  it 'raises TypeError when the method initializer argument is not a kind of String or URI' do
    expect { Alert.new(name: 'aname', url: URI('https://google.com'), method: 1) }.to raise_error(TypeError)
  end

  # write spec to check method is in HTTP::METHODS

  it 'raises TypeError when the name initializer argument is not a kind of String' do
    expect { Alert.new(name: 0) }.to raise_error(TypeError)
  end

  it 'has many read-only attributes' do
    analert = Alert.new(name: 'heh', url: 'https://google.com/', method: 'GET', description: 'description', reference: 'refer', solution: 'solve', risk: 'risk', attack: 'exp', cwe: 200)

    expect(analert).to have_attributes(:cwe => 200, :name => 'heh', :url => 'https://google.com/')
    expect(analert).to have_attributes(:method => 'GET', :description => 'description')
    expect(analert).to have_attributes(:reference => 'refer', :solution => 'solve')
    expect(analert).to have_attributes(:risk => 'risk', :attack => 'exp')
  end
end

describe Param do
  it 'has various members' do
  end
end

describe Rule do
  it 'raises TypeError when there are no initializer arguments' do
    expect { Rule.new }.to raise_error(TypeError)
  end

  it 'raises ArgumentError when the matchType initializer argument is nil or zero' do
    expect { Rule.new(matchType: nil) }.to raise_error(ArgumentError)
    expect { Rule.new(matchType: 0) }.to raise_error(ArgumentError)
  end

  it 'raises TypeError when the matchType initializer argument is not a kind of Integer' do
    expect { Rule.new(matchType: 'string') }.to raise_error(TypeError)
  end

  it 'raises ArgumentError when the description initializer argument is nil or empty' do
    expect { Rule.new(matchType: 1, description: nil) }.to raise_error(ArgumentError)
    expect { Rule.new(matchType: 1, description: '') }.to raise_error(ArgumentError)
  end

  it 'raises TypeError when the description initializer argument is not a kind of String' do
    expect { Rule.new(matchType: 1, description: 0) }.to raise_error(TypeError)
  end

  it 'raises ArgumentError when the matchString initializer argument is nil or empty' do
    expect { Rule.new(matchType: 1, description: 'description', matchString: nil) }.to raise_error(ArgumentError)
    expect { Rule.new(matchType: 1, description: 'description', matchString: '') }.to raise_error(ArgumentError)
  end

  it 'raises TypeError when the matchString initializer argument is not a kind of String' do
    expect { Rule.new(matchType: 1, description: 'description', matchString: 0) }.to raise_error(TypeError)
  end

  it 'raises ArgumentError when the initiators initializer argument is nil or empty' do
    expect { Rule.new(matchType: 1, description: 'description', matchString: 'matchString', initiators: nil) }.to raise_error(ArgumentError)
    expect { Rule.new(matchType: 1, description: 'description', matchString: 'matchString', initiators: '') }.to raise_error(ArgumentError)
  end

  it 'raises TypeError when the initiators initializer argument is not a kind of String' do
    expect { Rule.new(matchType: 1, description: 'description', matchString: 'matchString', initiators: 0) }.to raise_error(TypeError)
  end

  it 'raises ArgumentError when the matchRegex initializer argument is nil' do
    expect { Rule.new(matchType: 1, description: 'description', matchString: 'matchString', initiators: '1,2', matchRegex: nil) }.to raise_error(ArgumentError)
  end

  it 'raises TypeError when the matchRegex initializer is not a kind of TrueClass or FalseClass' do
    expect { Rule.new(matchType: 1, description: 'description', matchString: 'matchString', initiators: '1,2', matchRegex: 0) }.to raise_error(TypeError) 
  end

  it 'raises ArgumentError when the replacement initializer argument is nil or empty' do
    expect { Rule.new(matchType: 1, description: 'description', matchString: 'matchString', initiators: '1,2', matchRegex: true, replacement: nil) }.to raise_error(ArgumentError)
    expect { Rule.new(matchType: 1, description: 'description', matchString: 'matchString', initiators: '1,2', matchRegex: true, replacement: '') }.to raise_error(ArgumentError)
  end

  it 'raises TypeError when the replacement initializer argument is not a kind of String' do
    expect { Rule.new(matchType: 1, description: 'description', matchString: 'matchString', initiators: '1,2', matchRegex: true, replacement: 0) }.to raise_error(TypeError)
  end

  it 'raises ArgumentError when the enabled initializer is nil' do
    expect { Rule.new(matchType: 1, description: 'description', matchString: 'matchString', initiators: '1,2', matchRegex: true, replacement: 'replacement', enabled: nil) }.to raise_error(TypeError) 
  end

  it 'raises TypeError when the enabled initializer is not a kind of TrueClass or FalseClass' do
    expect { Rule.new(matchType: 1, description: 'description', matchString: 'matchString', initiators: '1,2', matchRegex: true, replacement: 'replacement', enabled: 0) }.to raise_error(TypeError) 
  end
end
