require 'actiontimer'

class Tomato
	attr_reader :state,
							:internal_interruptions,
							:external_interruptions,
							:start_time,
							:end_time,
							:abort_time

	TOTAL_SECONDS = 25.0

	def initialize
		@state = 'initialized'
		@internal_interruptions = 0
		@external_interruptions = 0
	end

	def start
		@state = 'started'
		@start_time = Time.now

		# prepare timer
		elapsed_seconds = 0
		@timer = ActionTimer::Timer.new(auto_start: false)
		@timer.add(period: 1) do
			elapsed_seconds += 1
			@tick_listener.call elapsed_seconds, TOTAL_SECONDS
		end

		# start timer
		@start_listener.call
		@timer.start
		sleep TOTAL_SECONDS

		# stop timer
		@timer.stop
		complete
	end

	def complete
		@state = 'completed'
		@end_time = Time.now
		@complete_listener.call
	end

	def abort
		@state = 'aborted'
		@abort_time = Time.now
		@timer.stop
		@abort_listener.call
	end

	def mark_internal_interruption
		@internal_interruptions += 1
	end

	def mark_external_interruption
		@external_interruptions += 1
	end

	def add_start_listener(&block)
		@start_listener = block
	end

	def add_tick_listener(&block)
		@tick_listener = block
	end

	def add_complete_listener(&block)
		@complete_listener = block
	end

	def add_abort_listener(&block)
		@abort_listener = block
	end
end
