class FeedbacksMailer < ApplicationMailer
  
  default to: -> { Admin.pluck(:email) },
          from: 'notification@testguru.com'

  def ready_feedback(feedback)
    @feedback = feedback
    mail(subject: "New User feedback: #{@feedback.text}")
  end

end