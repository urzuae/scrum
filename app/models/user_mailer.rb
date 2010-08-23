class UserMailer < ActionMailer::Base
  
  def enrollment_notification(user)
    @recipient = "#{user.email}"
    @from = "noreply@scrum.com"
    @subject = "Confirm account"
    @body = "Activate you account.\nClick on the following link #{register_url(:confirmation_token => user.confirmation_token)}
             to activate your account.\nEmail: #{user.password}\nPassword: #{user.password}"
  end

  def scrum_reminder(user_id)
    user = User.find(user_id)
    @recipient = "#{user.email}"
    @from = "noreply@scrum.com"
    @subject = "Please add your today's scrum"
    @body = "You have forgotten to add your tasks for today.\nGo now #{root_url} and fill out your tasks."
  end
  
  def report_for_project(project_id)
    
  end
  
end
