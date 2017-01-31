module Loopiator
  class Utilities
    
    def self.encode_domain(domain_name)
      SimpleIDN.to_ascii(domain_name)
    end
    
  end
end
