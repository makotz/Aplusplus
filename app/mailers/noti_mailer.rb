class NotiMailer < ApplicationMailer

  def notify_user(assessment)
    ass   = assessment
    course = ass.course
    @owner    = course.user
    mail(to: @owner.email, subject: "You got a new answer!")
  end

end
