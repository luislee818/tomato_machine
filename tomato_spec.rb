require_relative 'tomato'

describe Tomato do
	let(:tomato) { Tomato.new }

	it "should have state of 'initialized' when created" do
		tomato.state.should be == 'initialized'
	end

	it "should have state of 'started' when start() was invoked" do
		tomato.start
		tomato.state.should be == 'started'
	end

	it "should have start_time when start() was invoked" do
		tomato.start
		tomato.start_time.should_not be_nil
	end

	it "should have state of 'completed' when complete() was invoked" do
		tomato.complete
		tomato.state.should be == 'completed'
	end

	it "should have end_time when complete() was invoked" do
		tomato.complete
		tomato.end_time.should_not be_nil
	end

	it "should have state of 'aborted' when abort() was invoked" do
		tomato.abort
		tomato.state.should be == 'aborted'
	end

	it "should have abort_time when abort() was invoked" do
		tomato.abort
		tomato.abort_time.should_not be_nil
	end

	it "should increase internal_interruptions when mark_internal_interruption() was invoked" do
		tomato.start
		expect { tomato.mark_internal_interruption }.to change(tomato, :internal_interruptions).by(1)
	end

	it "should increase external_interruptions when mark_external_interruptions() was invoked" do
		tomato.start
		expect { tomato.mark_external_interruption }.to change(tomato, :external_interruptions).by(1)
	end
end
