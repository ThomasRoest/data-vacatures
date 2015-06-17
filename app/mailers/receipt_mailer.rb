class ReceiptMailer < ActionMailer::Base
	default from: 'contact@datavacature.nl'

	def receipt(invoice)
		@invoice = invoice
		@subscription = Subscription.find_by!(stripe_id: @invoice.subscription)
		
		@user = User.find_by!(email: @subscription.email)
		
		html = render_to_string('receipt_mailer/receipt.html')

		pdf = Docverter::Conversion.run do |c| 
			c.from = 'html'
			c.to = 'pdf'
			c.content = html
		end

		attachments["Datavacature.nl:factuur ##{@subscription.id}.pdf"] = pdf
	    mail(to: @subscription.email, subject: (t :receipt_mailer_title))
	end	
end