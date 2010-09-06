Factory.define :user do |user|
  user.name                   "Enrique Urzua"
  user.email                  "urzua@enrique.com"
end
Factory.define :project do |user|
  user.name                   "Scrum application"
  user.description            "Application that is able to store daily tasks"
end

Factory.define :task do |task|
  task.content                "I need to do somethig"
  task.project_id             "1"
  task.user_id                "1"
end
Factory.sequence :email do |n|
  "person-#{n}@example.com"
end

Factory.sequence :content do |n|
  "Task #-#{n} in this project"
end

Factory.sequence :name do |n|
  "Project #-#{n}"
end

