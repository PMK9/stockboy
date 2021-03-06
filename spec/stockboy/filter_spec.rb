require 'spec_helper'
require 'stockboy/filter'

class FishFilter < Stockboy::Filter
  def filter(raw, translated)
    return true if raw.species =~ /ichtus/
    return true if translated.species =~ /fish/
    return nil
  end
end

class CoffeeFilter < Stockboy::Filter
end

module Stockboy
  describe Filter do

    describe "#call" do
      let(:empty_values) { double.as_null_object }
      subject(:filter) { FishFilter.new }

      context "matching raw value" do
        it "returns true for match" do
          expect(filter.call(double(species:"babylichtus"), empty_values)).to be true
        end

        it "returns false for no match" do
          expect(filter.call(double(species:"triceratops"), empty_values)).to be false
        end
      end

      context "matching translated value" do
        it "returns true for match" do
          expect(filter.call(empty_values, double(species:"babelfish"))).to be true
        end

        it "returns false for no match" do
          expect(filter.call(empty_values, double(species:"rhinoceros"))).to be false
        end
      end
    end

    it "warns of a missing subclass implementation" do
      expect { CoffeeFilter.new.call(double, double) }.to raise_error NoMethodError
    end

  end
end
