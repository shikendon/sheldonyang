namespace :dev do
  desc 'Rebuild database'
  task rebuild: ['tmp:clear', 'log:clear', 'db:drop', 'db:create', 'db:migrate', 'db:seed']
end
