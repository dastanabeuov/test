class FeedbacksMailer < ApplicationMailer
  
  default to: -> { Admin.pluck(:email) },
          from: 'notification@testguru.com'

  def ready_feedback(feedback)
    @name = feedback.name
    @email = feedback.email
    @message = feedback.message
    mail(subject: "New User feedback:")
  end

end