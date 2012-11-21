module Loopiator
  module Domains
    
    def domain_is_free(domain)
      domain      =   SimpleIDN.to_ascii(domain)
      response    =   self.call("domainIsFree", domain)
      
      return response.downcase.eql?("ok")
    end
    
  end
end