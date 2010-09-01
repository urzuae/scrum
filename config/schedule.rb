every :weekday, :at => "10:00 am " do
  runner "User.scrum_reminder"
end

every :weekday, :at => "11:00 am" do
  runner "UserMailer.deliver_daily_report"
end

every :weekday, :at => "12:00 am" do
  runner "User.reset_scrum"
end
