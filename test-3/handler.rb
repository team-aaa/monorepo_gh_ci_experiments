class Handler
  def initialize(event, context)
    LOG.info('Starting Execution')

    @event = event
    @context = context

    LOG.debug("Event: #{event.inspect}")
    LOG.debug("Context: #{context.inspect}")
  end

  def execute
  end
end
