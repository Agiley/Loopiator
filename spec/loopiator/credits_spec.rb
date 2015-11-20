# encoding: UTF-8

require File.expand_path('../../spec_helper', __FILE__)

describe "Credits Management -"  do
  
  before(:each) do
    @client = Loopiator::Client.new
  end
  
  context "When managing my credits:" do
    it "I should be able to check how many credits I currently have (with VAT)" do
    	expect(@client).to receive(:get_credits_amount).with(include_vat: true).and_return(125)
      expect(@client.get_credits_amount(include_vat: true)).to be == 125
    end
    
    it "I should be able to check how many credits I currently have (without VAT)" do
    	expect(@client).to receive(:get_credits_amount).with(include_vat: false).and_return(100)
      expect(@client.get_credits_amount(include_vat: false)).to be == 100
    end
  end
  
end