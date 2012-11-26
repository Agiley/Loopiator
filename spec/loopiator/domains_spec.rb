# encoding: UTF-8

require File.expand_path('../../spec_helper', __FILE__)

describe "Domain Management -"  do
  
  before(:each) do
    @client = Loopiator::Client.new
  end
  
  describe "When checking domain availability:" do
    
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
  
  describe "When managing my domains:" do
    
    it "I should be able to check the details for a domain that I own" do
    	hash        =   {"paid"             =>  1,
    	                 "unpaid_amount"    =>  0,
    	                 "registered"       =>  1,
    	                 "domain"           =>  "testdomain.se",
    	                 "renewal_status"   =>  "NOT_HANDLED_BY_LOOPIA",
    	                 "expiration_date"  =>  "UNKNOWN",
    	                 "reference_no"     =>  "999999"
    	                }
    	                
    	mock        =   Loopiator::Models::Domain.new(hash)
    	
    	@client.expects(:get_domain).with('testdomain.se').once.returns(mock)
    	
    	domain      =   @client.get_domain('testdomain.se')
    	
    	domain.paid?.should               ==  true
    	domain.needs_to_be_paid?.should   ==  false
    	domain.registered?.should         ==  true
    	domain.reference_number.should    ==  "999999"
    end
    
    it "I should be able to see that a domain hasn't been paid for yet." do
    	hash        =   {"paid"             =>  0,
    	                 "unpaid_amount"    =>  99,
    	                 "registered"       =>  1,
    	                 "domain"           =>  "testdomain.se",
    	                 "renewal_status"   =>  "NOT_HANDLED_BY_LOOPIA",
    	                 "expiration_date"  =>  "UNKNOWN",
    	                 "reference_no"     =>  "1111111"
    	                }
    	                
    	mock        =   Loopiator::Models::Domain.new(hash)
    	
    	@client.expects(:get_domain).with('testdomain.se').once.returns(mock)
    	
    	domain      =   @client.get_domain('testdomain.se')
    	
    	domain.paid?.should               ==  false
    	domain.needs_to_be_paid?.should   ==  true
    	domain.unpaid_amount.should       ==  99
    	domain.reference_number.should    ==  "1111111"
    end

  end
  
end