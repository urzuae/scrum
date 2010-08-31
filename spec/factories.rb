Factory.define :user do |user|
  user.name                  "Michael Hartl"
  user.email                 "mhartl@example.com"
  user.password              "foobar"
  user.password_confirmation "foobar"
end
Factory.define :project do |user|
  user.name                  "Scrum application"
  user.description           "Application that is able to store daily tasks"
end

Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

