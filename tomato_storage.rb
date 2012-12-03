require_relative 'tomato'
FILE_NAME = "tomatoes.txt"

module TomatoStorage
	def self.save(tomato)
		File.open(FILE_NAME, 'a+') do |tomatoes_file|
			tomatoes_file.puts [tomato.state, tomato.start_time, tomato.end_time].join(',')
		end
	end
end
