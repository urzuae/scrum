class UserMailer < ActionMailer::Base
  
  def enrollment_notification(user)
    @recipients = "#{user.email}"
    @from = "noreply@scrum.com"
    @subject = "Confirm account"
    @body = "Activate you account.\nClick on the following link #{register_url(:confirmation_token => user.confirmation_token)} to activate your account.\nEmail: #{user.email}\nPassword: #{user.password}"
  end

  def scrum_reminder(user)
    @recipients = "#{user.email}"
    @from = "noreply@scrum.com"
    @subject = "Please add your today's scrum"
    @body = "You have forgotten to add your tasks for today.\nGo now #{root_url} and fill out your tasks."
  end
  
  def daily_report
    projects = Project.all
    recipients    "urzuae@gmail.com"
    from          "noreply@scrum.app"
    subject       "SCRUM daily report"
    body          :projects => projects
  end
  
  def comment_notification(comment)
    user = comment.task.user
    @recipients = "#{user.email}"
    @from = "noreply@scrum.app"
    @subject = "Your task has been commented"
    @body = "Your task has just been commented.\n\"#{user.name}\" just left a comment on one of your tasks.\n\"#{comment.content}\"\nCheck it out now #{root_url}"
  end
  
end
