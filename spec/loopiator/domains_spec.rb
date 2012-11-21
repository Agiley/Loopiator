# encoding: UTF-8

require File.expand_path('../../spec_helper', __FILE__)

describe "Domain Management -"  do
  
  before(:each) do
    @client = Loopiator::Client.new
  end
  
  describe "When managing domains I currently do not own:" do
    
    it "I should be able to check that a domain is available" do
    	@client.domain_is_free('dsadsadsadsadsadsadasdas.se').should == true
    end
    
    it "I should be able to check if a domain is not available" do
    	@client.domain_is_free('aftonbladet.se').should == false
    end
    
    it "I should be able to check if an IDN-domain is available" do
    	@client.domain_is_free('såhärtestarmanenidndomänkanske.se').should == true
    end

  end
end

