load './wordchainer.rb'

# a = Time.now
#   w = WordChainer.new('dictionary.txt')
#   w.run("chant", "pluck")
# puts Time.now - a

dictionary = File.readlines('dictionary.txt').map(&:chomp)
w = WordChainer.new('dictionary.txt')


def get_target(dictionary)
  dictionary.select { |item| item.length == 5 }.sample
end

1.times do
  path = []
  test_path = w.run("black", get_target(dictionary))

  until test_path.length > 7
    test_path = w.run("black", get_target(dictionary))
  end

  path << test_path
  puts path
  puts
end
