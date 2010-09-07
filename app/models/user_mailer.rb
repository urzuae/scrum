class UserMailer < ActionMailer::Base
  
  def enrollment_notification(user)
    recipients  "#{user.email}"
    from        "noreply@scrum.com"
    subject     "Confirm account"
    body        :user => user, :register_url => register_url(:confirmation_token => user.confirmation_token)
  end

  def scrum_reminder(user)
    recipients  "#{user.email}"
    from        "noreply@scrum.com"
    subject     "Please add your today's scrum"
    body        :root => root_url
  end
  
  def daily_report
    projects = Project.all
    recipients    "navid@freshout.us"
    from          "noreply@scrum.app"
    subject       "SCRUM daily report"
    body          :projects => projects
  end
  
  def comment_notification(comment, user, commenters)
    recipients  "#{user.email}"
    cc          "#{commenters}"
    from        "noreply@scrum.app"
    subject     "Your task has been commented"
    body        :user => user, :comment => comment, :root => root_url
  end
  
end
