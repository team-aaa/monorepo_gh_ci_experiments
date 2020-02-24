require 'bundler/setup'
require 'airbrake-ruby'
require 'logger'
require './handler'

LOG = Logger.new(STDOUT)
LOG.info('Cold Start')

airbrake_enabled = ENV['AIRBRAKE_PROJECT_ID'] && ENV['AIRBRAKE_PROJECT_KEY']

if airbrake_enabled
  Airbrake.configure do |c|
    c.project_id = ENV['AIRBRAKE_PROJECT_ID']
    c.project_key = ENV['AIRBRAKE_PROJECT_KEY']
    c.root_directory = nil
    c.environment = ENV['AIRBRAKE_ENV'] || 'development'
    c.ignore_environments = %w[test development]
  end
end

# main.lambda_handler
def lambda_handler(event:, context:)
  Handler.new(event, context).execute
rescue StandardError => error
  if airbrake_enabled
    Airbrake.notify_sync(error, event: event) do |notice|
      notice[:context][:component] = ENV['AIRBRAKE_COMPONENT']
    end
  end
  raise(error)
end
