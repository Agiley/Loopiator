# encoding: UTF-8

require File.expand_path('../../spec_helper', __FILE__)

describe "Credits Management -"  do
  
  before(:each) do
    @client = Loopiator::Client.new
  end
  
  describe "When managing my credits:" do
    
    it "I should be able to check how many credits I currently have (with VAT)" do
    	@client.expects(:get_credits_amount).with(true).once.returns(125)
    	remaining_credits = @client.get_credits_amount(true)
    	remaining_credits.should == 125
    end
    
    it "I should be able to check how many credits I currently have (without VAT)" do
    	@client.expects(:get_credits_amount).with(false).once.returns(100)
    	remaining_credits = @client.get_credits_amount(false)
    	remaining_credits.should == 100
    end

  end
  
end

