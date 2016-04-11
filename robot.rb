require_relative 'lib/application'

input = ARGV[0]

if input
  app = Application.new(input)
  app.run
else
  "File name does't exist"
end
