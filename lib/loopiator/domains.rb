module Loopiator
  module Domains
    
    def domain_is_free(domain_name)
      response      =   parse_status_response(call("domainIsFree", encode_domain(domain_name)))
      
      return response.eql?(:ok)
    end
    
    def get_domain(domain_name, customer_number: "")
      domain        =   nil
      response      =   call("getDomain", customer_number, encode_domain(domain_name))
      
      if (response && response.is_a?(Hash))
        domain      =   Loopiator::Models::Domain.new(response)
      end
      
      return domain
    end
    
    def get_domains(customer_number: "")
      domains       =   []
      response      =   call("getDomains", customer_number)
      
      response.each do |item|
        domains    <<   Loopiator::Models::Domain.new(item)
      end if (response && response.is_a?(Array))
      
      return domains
    end
    
    def order_domain(domain_name, accept_terms: true, customer_number: "", raise_exception_on_occupied: false)
      response      =   parse_status_response(call("orderDomain", customer_number, encode_domain(domain_name), accept_terms))
      
      raise Loopiator::DomainOccupiedError if (response.eql?(:domain_occupied) && raise_exception_on_occupied)
      
      return response.eql?(:ok)
    end
    
    def purchase_domain(domain_name, customer_number: "", raise_exception_on_occupied: false)
      success       =   false
      
      order_domain(domain_name, accept_terms: true, customer_number: customer_number, raise_exception_on_occupied: raise_exception_on_occupied)
      
      domain        =   get_domain(domain_name, customer_number: customer_number)
      
      if (domain && domain.needs_to_be_paid? && !domain.reference_number.nil? && !domain.reference_number.empty?)
        success     =   pay_invoice_using_credits(domain.reference_number, customer_number: customer_number)
      end
      
      return success
    end
    
    private
    def encode_domain(domain_name)
      Loopiator::Utilities.encode_domain(domain_name)
    end
    
  end
end