class JobMailer < ActionMailer::Base
  default from: "admin@testdomain5769.com"

  def jobapplication_notification(application)
    #require 'open-uri'
    @jobapplication = application

    
    mail(to: @jobapplication.job.user.email, from: 'contact@datavacature.nl', :subject => [(t :jobapplication_email_title)])
  end
end


# cv = open(@jobapplication.cv.url)
    # attachments[@jobapplication.cv.original_filename] = File.read(cv)
    
    # letter = open(@jobapplication.letter.url)
    # attachments[@jobapplication.letter.original_filename] = File.read(letter)
    #found original_filename method available(s3)  via cv.url methods in rails console