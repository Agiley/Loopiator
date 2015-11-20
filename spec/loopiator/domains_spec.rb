# encoding: UTF-8

require File.expand_path('../../spec_helper', __FILE__)

describe "Domain Management -"  do
  
  before(:each) do
    @client = Loopiator::Client.new
  end
  
  context "When checking domain availability" do
    it "I should be able to check that a domain is available" do
      expect(@client).to receive(:domain_is_free).with('dsadsadsadsadsadsadasdas.se').and_return(true)
      expect(@client.domain_is_free('dsadsadsadsadsadsadasdas.se')).to be == true
    end
    
    it "I should be able to check if a domain is not available" do
      expect(@client).to receive(:domain_is_free).with('aftonbladet.se').and_return(false)
      expect(@client.domain_is_free('aftonbladet.se')).to be == false
    end
    
    it "I should be able to check if an IDN-domain is available" do
      expect(@client).to receive(:domain_is_free).with('såhärtestarmanenidndomänkanske.se').and_return(true)
      expect(@client.domain_is_free('såhärtestarmanenidndomänkanske.se')).to be == true
    end
  end
  
  context "When managing domains" do
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
    	
      expect(@client).to receive(:get_domain).with('testdomain.se').and_return(mock)
      
    	domain      =   @client.get_domain('testdomain.se')
    	
    	expect(domain.paid?).to be              ==  true
      expect(domain.needs_to_be_paid?).to be  ==  false
    	expect(domain.registered?).to be        ==  true
      expect(domain.reference_number).to be   ==  "999999"
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
    	
      
      expect(@client).to receive(:get_domain).with('testdomain.se').and_return(mock)
      
    	domain      =   @client.get_domain('testdomain.se')
    	
    	expect(domain.paid?).to be              ==  false
      expect(domain.needs_to_be_paid?).to be  ==  true
    	expect(domain.unpaid_amount).to be      ==  99
      expect(domain.reference_number).to be   ==  "1111111"
    end
  end
  
end