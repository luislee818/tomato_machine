require_relative 'tomato'
require_relative 'tomato_presenter'
require_relative 'tomato_storage'

tomato = Tomato.new
presenter = TomatoPresenter.new

tomato.add_start_listener do
	presenter.start
end

tomato.add_tick_listener do |elapsed_seconds, total_seconds|
	presenter.show elapsed_seconds, total_seconds
end

tomato.add_complete_listener do
	presenter.complete
	TomatoStorage.save tomato
	exit
end

tomato.add_abort_listener do
	presenter.abort
	TomatoStorage.save tomato
	exit
end

Signal.trap("SIGINT") do
	tomato.abort
end

tomato.start
