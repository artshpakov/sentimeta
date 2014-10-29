require 'spec_helper'

describe Sentimeta::Model do

  subject(:client) { Sentimeta::Client }
  subject { model = Sentimeta::Model; model.endpoint :spheres; model }

  it { should respond_to :fetch }


  describe :fetch do

    it "should return an array" do
      expect(subject.send :fetch).to be_kind_of Array
    end

    it "should call client_fetch once" do
      expect(client).to receive(:fetch).and_call_original.once
      subject.send :fetch
    end

  end
end
