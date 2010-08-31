# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
every :weekday, :at => "10:00am" do
  runner "User.scrum_reminder"
end

every :weekday, :at => "11:00pm" do
  runner "UserMailer.daily_report"
end

every :weekday, :at => "0:01am" do
  runner "User.reset_scrum"
end


# Learn more: http://github.com/javan/whenever
