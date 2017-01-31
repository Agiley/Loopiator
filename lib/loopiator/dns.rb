module Loopiator
  module Dns
        
    def get_zone_records(domain, subdomain, customer_number: "")
      records       =   []
      response      =   call("getZoneRecords", customer_number, encode_domain(domain), subdomain)
      
      response.each do |item|
        records    <<   Loopiator::Models::DnsRecord.new(item)
      end if response && response.is_a?(Array)
      
      return records
    end
    
    def add_zone_record(domain, subdomain, record_obj, customer_number: "")
      response      =   parse_status_response(call("addZoneRecord", customer_number, encode_domain(domain), subdomain, record_obj))
      return response.eql?(:ok)
    end
    
    def remove_zone_record(domain, subdomain, record_id, customer_number: "")
      response      =   parse_status_response(call("removeZoneRecord", customer_number, encode_domain(domain), subdomain, record_id))
      return response.eql?(:ok)
    end
    
    private
      def encode_domain(domain_name)
        Loopiator::Utilities.encode_domain(domain_name)
      end
    
  end
end
