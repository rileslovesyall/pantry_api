# Learn more: http://github.com/javan/whenever

set :output, "log/cron.log"

every :monday, :at => '6:00 am' do
  rake 'cron:expiration_emails'
end