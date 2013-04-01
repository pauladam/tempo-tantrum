#!/usr/bin/env ruby

require 'cgi'
require 'yaml'
require 'date'

config = YAML.load(File.open(File.expand_path("~/.tempo-tantrum")).read)

if ARGV.length < 1
  puts "Usage: tempo-tantrum work-log"
  exit
end

work_log_fn = ARGV.shift
work_log = YAML.load(File.open(work_log_fn).read)

user = config['user']
pass = config['pass']
jira_url = config['jira location']
schemeless_jira_url = jira_url.split(/https?:\/\//).last
login_url = "%s/login.jsp" % jira_url

def login login_url, jira_url, schemeless_jira_url, user, pass
  curl_login = <<-HERE
  curl \
  -c ~/.tempo-tantrum-cookies \
  -b ~/.tempo-tantrum-cookies \
  --compressed \
  -L \
  "#{login_url}" \
  -H "Origin: #{jira_url}" \
  -H "Accept-Encoding: gzip,deflate,sdch" \
  -H "Host: #{schemeless_jira_url}" \
  -H "Accept-Language: en-US,en;q=0.8" \
  -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.43 Safari/537.31" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -H "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" \
  -H "Cache-Control: max-age=0" \
  -H "Referer: #{login_url}" \
  -H "Connection: keep-alive" \
  -H "DNT: 1" \
  -H "Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.3" \
  --data "os_username=#{user}&os_password=#{pass}&os_destination=&atl_token=&login=Log+In"
  HERE
  p curl_login
  # p `#{curl_login}`
end

def post_log user, pass, jira_url, schemeless_jira_url, work_date, log

  hours = log['hours']
  project = log['project']
  comments = CGI::escape(log['comments'])
  dt = DateTime.strptime(work_date, '%m/%d/%Y')
  date_str = CGI::escape(dt.strftime('%d/%b/%y'))

  p work_date
  p log

  p date_str
  p comments

  curl_update_tempo = <<-HERE
    curl \
    -c ~/.tempo-tantrum-cookies \
    -b ~/.tempo-tantrum-cookies \
    --compressed \
    "#{jira_url}/rest/tempo-rest/1.0/worklogs/#{project}" \
    -H "Origin: #{jira_url}" \
    -H "Accept-Encoding: gzip,deflate,sdch" \
    -H "Host: #{schemeless_jira_url}" \
    -H "Accept-Language: en-US,en;q=0.8" \
    -H "User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10_7_5) AppleWebKit/537.31 (KHTML, like Gecko) Chrome/26.0.1410.43 Safari/537.31" \
    -H "Content-Type: application/x-www-form-urlencoded" \
    -H "Accept: application/xml, text/xml, */*; q=0.01" \
    -H "Referer: #{jira_url}/secure/TempoUserBoard\!timesheet.jspa?v=1&period=28032013&periodType=BILLING&periodView=DAY" \
    -H "X-Requested-With: XMLHttpRequest" \
    -H "Connection: keep-alive" \
    -H "DNT: 1" \
    -H "Accept-Charset: ISO-8859-1,utf-8;q=0.7,*;q=0.3" \
    --data "user=#{user}&id=&type=&selected-panel=0&startTimeEnabled=false&tracker=false&planning=false&issue=#{project}&date=#{date_str}&enddate=#{date_str}&time=#{hours}&remainingEstimate=0&comment=#{comments}"
  HERE

  puts curl_update_tempo
  # p `#{curl_update_tempo}`

end

if __FILE__ == $0

  login login_url, jira_url, schemeless_jira_url, user, pass

  work_log.each do |work_date, log|
    post_log user, pass, jira_url, schemeless_jira_url, work_date, log
  end

  puts "All done, go get a cup of coffee"
  puts " ... "

end
