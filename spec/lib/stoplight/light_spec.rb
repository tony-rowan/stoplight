# coding: utf-8

require 'spec_helper'

describe Stoplight::Light do
  subject(:light) { described_class.new }

  describe '.data_store' do
    subject(:result) { described_class.data_store }

    context 'without a data store' do
      it 'returns the default' do
        expect(result).to be_a(Stoplight::DataStore::Memory)
      end
    end

    context 'with a data store' do
      let(:data_store) { double }

      before { described_class.data_store(data_store) }

      it 'returns the data store' do
        expect(result).to eql(data_store)
      end
    end
  end

  describe '#initialize' do
    it 'assigns @name' do
      expect(light.instance_variable_get(:@name)).to start_with(__FILE__)
    end
  end

  describe '#with_code' do
    let(:code) { proc {} }

    subject(:result) { light.with_code(&code) }

    it 'returns self' do
      expect(result).to equal(light)
    end

    it 'assigns @code' do
      expect(result.instance_variable_get(:@code)).to eql(code)
    end
  end

  describe '#with_fallback' do
    let(:fallback) { proc {} }

    subject(:result) { light.with_fallback(&fallback) }

    it 'returns self' do
      expect(result).to equal(light)
    end

    it 'assigns @fallback' do
      expect(result.instance_variable_get(:@fallback)).to eql(fallback)
    end
  end

  describe '#with_name' do
    let(:name) { SecureRandom.hex }

    subject(:result) { light.with_name(name) }

    it 'returns self' do
      expect(result).to equal(light)
    end

    it 'assigns @name' do
      expect(result.instance_variable_get(:@name)).to eql(name)
    end
  end

  describe '#code' do
    subject(:result) { light.code }

    context 'without code' do
      it 'raises an error' do
        expect { result }.to raise_error(Stoplight::Errors::NoCode)
      end
    end

    context 'with code' do
      let(:code) { proc {} }

      before { light.with_code(&code) }

      it 'returns the code' do
        expect(result).to eql(code)
      end
    end
  end

  describe '#fallback' do
    subject(:result) { light.fallback }

    context 'without a fallback' do
      it 'raises an error' do
        expect { result }.to raise_error(Stoplight::Errors::NoFallback)
      end
    end

    context 'with a fallback' do
      let(:fallback) { proc {} }

      before { light.with_fallback(&fallback) }

      it 'returns the fallback' do
        expect(result).to eql(fallback)
      end
    end
  end

  describe '#name' do
    subject(:result) { light.name }

    context 'without a name' do
      it 'returns the default' do
        expect(result).to start_with(__FILE__)
      end
    end

    context 'with a name' do
      let(:name) { SecureRandom.hex }

      before { light.with_name(name) }

      it 'returns the name' do
        expect(result).to eql(name)
      end
    end
  end
end
