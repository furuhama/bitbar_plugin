#!/bin/sh
echo ':cow:'
echo ---

shopt -s expand_aliases
source ~/workspace/bitbar_plugin/.env

exec ruby -S -x "$0" "$@"

#!/usr/bin/env ruby

# this plugin uses Milkman gem
# https://github.com/kevintuhumury/milkman
require 'milkman'

# load ENV variables
api_key = ENV['RTM_API_KEY']
shared_secret = ENV['RTM_SHARED_SECRET']
auth_token = ENV['RTM_AUTH_TOKEN']

# set Milkman instance
client = Milkman::Client.new(api_key: api_key,
                             shared_secret: shared_secret,
                             auth_token: auth_token)

##################
# private tasks
##################
puts '******  private tasks  ******'

# set list_id
private_list_id = ENV['PRIVATE_LIST_ID']

# send api & get json type response
private_json = client.get('rtm.tasks.getList', { list_id: private_list_id, filter: "status: incomplete" })

# parse response (returns "list of hash")
private_tasks = private_json['rsp']['tasks']['list'][0]['taskseries']

private_tasks.each do |task|
  begin
    puts "#{task['name']}  [#{task['tags']['tag']}]| color=blue"
  rescue
    # rescue if task['tags'] does not have 'tag' value
    puts "#{task['name']}| color=blue"
  end
end

##################
# work tasks
##################
puts '******  work tasks  ******'

# set list_id
work_list_id = ENV['WORK_LIST_ID']

# send api & get json type response
work_json = client.get('rtm.tasks.getList', { list_id: work_list_id, filter: "status: incomplete" })

# parse response (returns "list of hash")
work_tasks = work_json['rsp']['tasks']['list'][0]['taskseries']

work_tasks.each do |task|
  puts "#{task['name']}  [#{task['tags']['tag']}]| color=green"
end

