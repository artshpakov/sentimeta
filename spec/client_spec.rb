require 'spec_helper'

describe Sentimeta::Client do

  subject { Sentimeta::Client }

  let(:valid_url) { subject.generate_uri(:spheres) }
  before do
    # subject.stubs(:fetch).with(:spheres).returns(spheres: [])
    # %i(criteria spheres objects catalog).each do |endpoint|
    #   subject.stubs(:fetch).with(endpoint, optionally({})).returns(endpoint => [])
    # end
  end

  
  describe :fetch do
    it { should respond_to :fetch }
  end


  describe :generate_uri do
    it "should return an instance of URI" do
      expect(valid_url).to be_kind_of URI
    end
  end


  describe :send_request do
    it "should be fine for a valid uri" do
      expect { subject.send_request valid_url }.not_to raise_error
    end

    it "should raise an error for invalid uri" do
      expect { subject.send_request "invalid" }.to raise_error Sentimeta::Error::Unreachable
    end
  end


  describe :endpoints do
    %i(criteria spheres objects catalog).each do |endpoint|
      it { should respond_to endpoint }

      # it "##{endpoint} should call fetch once" do
      #   expect(subject).to(receive :fetch).once
      #   # subject.should_receive(:fetch).once
      #   # p subject.generate_uri(endpoint, p: { subcriteria: true }).to_s
      #   subject.public_send endpoint
      # end

      it "##{endpoint} should return an array" do
        subject.stubs(:fetch).with(endpoint, optionally({})).returns(endpoint => [])
        expect(subject.public_send endpoint).to be_kind_of Array
      end
    end
  end

end
