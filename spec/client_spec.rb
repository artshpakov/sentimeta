require 'spec_helper'

describe Sentimeta::Client, :vcr do

  subject { Sentimeta::Client }

  let(:valid_url) { subject.generate_uri(:spheres) }


  describe :fetch do
    it { should respond_to :fetch }
  end


  describe :generate_uri do
    it "should return an instance of String" do
      expect(valid_url).to be_kind_of String
    end
  end


  # describe :send_request do
  #   it "should be fine for a valid uri" do
  #     expect { subject.send_request valid_url }.not_to raise_error
  #   end

  #   it "should raise an error for invalid uri" do
  #     expect { subject.send_request "invalid" }.to raise_error Sentimeta::Error::Unreachable
  #   end
  # end


  describe :endpoints do
    %i(criteria spheres objects catalog).each do |endpoint|
      it { should respond_to endpoint }

      it "##{endpoint} should call fetch once" do
        expect(subject).to receive(:fetch).and_call_original.once
        subject.public_send endpoint
      end

      it "##{endpoint} should return an array" do
        expect(subject.public_send endpoint).to be_kind_of Array
      end
    end

    # it { should respond_to :prices }
    # it("#prices should call fetch once") { pending }
    # it("#prices should return an array") { pending }
  end

end
