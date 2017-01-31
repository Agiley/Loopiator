module Loopiator
  module Credits
    
    # https://www.loopia.se/api/getcreditsamount/
    def get_credits_amount(include_vat: true, customer_number: "")      
      call("getCreditsAmount", customer_number, with_vat).to_f
    end
    
    # https://www.loopia.se/api/payinvoiceusingcredits/
    def pay_invoice_using_credits(reference_number, customer_number: "")      
      parse_status_response(call("payInvoiceUsingCredits", customer_number, reference_number.to_s))
    end
    
  end
end
