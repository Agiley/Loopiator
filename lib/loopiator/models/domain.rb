module Loopiator
  module Models
    
    class Domain
      attr_accessor :paid, :unpaid_amount, :registered, :domain, :renewal_status, :expiration_date, :reference_number
      
      def initialize(hash)
        hash.symbolize_keys!
        
        self.paid               =   hash.fetch(:paid, 0).eql?(1)
        self.unpaid_amount      =   hash.fetch(:unpaid_amount, 0)
        self.registered         =   hash.fetch(:registered, 0).eql?(1)
        self.domain             =   hash.fetch(:domain, "")
        self.renewal_status     =   hash.fetch(:renewal_status, "")
        self.expiration_date    =   hash.fetch(:expiration_date, "")
        self.reference_number   =   hash.fetch(:reference_no, "").to_s
      end
      
      def paid?
        paid
      end
      
      def registered?
        registered
      end
      
      def needs_to_be_paid?
        (!paid? && unpaid_amount > 0)
      end
      
    end
    
  end
end