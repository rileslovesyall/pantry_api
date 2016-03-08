# Learn more: http://github.com/javan/whenever

set :output, "log/cron.log"

every 1.day, :at => '8:00 am' do
  rake 'cron:expiration_emails'
end

every 1.hour do
  rake 'cron:test'
end