# encoding: utf-8

require 'spec_helper'
require 'zap_attack/version'

include ZapAttack

describe ZapAttack do
  it 'should have a VERSION constant' do
    expect(subject.const_defined?('VERSION')).to eq(true)
  end
end

describe VERSION do
  it 'VERSION should not be nil' do
    expect(VERSION).not_to be_nil
  end

  it 'VERSION should be a String' do
    expect(VERSION).to be_instance_of(String)
  end

  it 'VERSION should not be empty' do
    expect(VERSION).not_to be_empty
  end

  it 'VERSION should be numbers delimited by periods' do
    expect(VERSION).to satisfy do |v| 
      v.split('.').each do |n|
        n =~ %r{[0-9]}
      end
    end
  end
end
