module Loopiator
  module Domains
    
    def domain_is_free(domain_name)
      response      =   parse_status_response(call("domainIsFree", encode_domain(domain_name)))
      
      return response.eql?(:ok)
    end
    
    def get_domain(domain_name, customer_number = "")
      domain        =   nil
      response      =   call("getDomain", customer_number, encode_domain(domain_name))
      
      if (response && response.is_a?(Hash))
        domain      =   Loopiator::Models::Domain.new(response)
      end
      
      return domain
    end
    
    def add_domain_to_account(domain_name, should_buy = false, customer_number = "")
      response      =   parse_status_response(call("addDomainToAccount", customer_number, encode_domain(domain_name), should_buy))
      
      return response.eql?(:ok)
    end
    
    def purchase_domain(domain_name, customer_number = "")
      success = false
      
      if (add_domain_to_account(domain_name, true, customer_number))
        domain = get_domain(domain_name, customer_number)
        
        if (domain && domain.needs_to_be_paid? && domain.reference_number != nil && domain.reference_number != "")
          success = pay_invoice_using_credits(domain.reference_number, customer_number)
        end
      end
      
      return success
    end
    
    private
    def encode_domain(domain_name)
      SimpleIDN.to_ascii(domain_name)
    end
    
  end
end