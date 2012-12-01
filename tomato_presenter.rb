require 'rainbow'

class TomatoPresenter
	BAR_WIDTH = 60  # [progress_bar]
	TIMER_WIDTH = 7  # 00:00 (and surrounding spaces)
	# TOTAL_WIDTH = BAR_WIDTH + TIMER_WIDTH

	def initialize
		# terminal_info = detect_terminal_size()
		# @terminal_width = terminal_info[0] unless terminal_info.nil?
		# puts @terminal_width
		@terminal_width = 80
	end

	def start
		puts "tomato started"
	end

	def complete
		words = "tomato completed"
		STDOUT.write "\r" + words + " " * (@terminal_width - words.length)
	end

	def abort
		words = "tomato aborted"
		STDOUT.write "\r" + words + " " * (@terminal_width - words.length)
	end

	def show(elapsed_seconds, total_seconds)
		ratio = elapsed_seconds / total_seconds
		bar = " " * (ratio * (BAR_WIDTH - 2)).ceil +
					"|" * ((1 - ratio) * (BAR_WIDTH - 2)).floor
		bar_color = get_bar_color ratio

		time = format_time((total_seconds - elapsed_seconds).ceil)

		remainder_spaces = " " * (@terminal_width - BAR_WIDTH - TIMER_WIDTH - 1)

		STDOUT.write "\r["
		STDOUT.write bar.color(bar_color)
		STDOUT.write "] #{time}#{remainder_spaces}"
	end

	def get_bar_color(ratio)
		case
		when ratio <= 0.5 then :green
		when ratio <= 0.75 then :yellow
		else :red
		end
	end

	def format_time (time)
		@time = time

		#find the seconds
		seconds = @time % 60

		#find the minutes
		minutes = (@time / 60) % 60

		#format the time
		return format("%02d",minutes.to_s) + ":" + format("%02d",seconds.to_s)
	end

	# Stolen from https://github.com/cldwalker/hirb/blob/master/lib/hirb/util.rb#L61-71
	# Returns [width, height] of terminal when detected, nil if not detected.
	# Think of this as a simpler version of Highline's Highline::SystemExtensions.terminal_size()
	def detect_terminal_size
		if (ENV['COLUMNS'] =~ /^\d+$/) && (ENV['LINES'] =~ /^\d+$/)
			[ENV['COLUMNS'].to_i, ENV['LINES'].to_i]
		elsif (RUBY_PLATFORM =~ /java/ || (!STDIN.tty? && ENV['TERM'])) && command_exists?('tput')
			[`tput cols`.to_i, `tput lines`.to_i]
		elsif STDIN.tty? && command_exists?('stty')
			`stty size`.scan(/\d+/).map { |s| s.to_i }.reverse
		else
			nil
		end
	rescue
		nil
	end
end
