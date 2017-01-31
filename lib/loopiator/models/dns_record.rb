module Loopiator
  module Models
    
    #https://www.loopia.se/api/record_obj/
    class DnsRecord
      attr_accessor :record_id, :type, :ttl, :priority, :rdata
      
      def initialize(hash = nil)
        if hash && hash.is_a?(Hash) && !hash.empty?
          hash.symbolize_keys! 
        
          self.record_id    =   hash.fetch(:record_id, nil)
          self.type         =   hash.fetch(:type, "").to_s
          self.ttl          =   hash.fetch(:ttl, 3_600).to_i
          self.priority     =   hash.fetch(:priority, 0).to_i
          self.rdata        =   hash.fetch(:rdata, "").to_s
        end
      end
      
      def to_h
        data                =   {
          type:       self.type,
          ttl:        self.ttl,
          priority:   self.priority,
          rdata:      self.rdata
        }
        
        data[:record_id]    =   self.record_id if self.record_id
        
        return data
      end
      
    end
    
  end
end
