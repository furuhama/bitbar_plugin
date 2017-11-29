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
puts '****************  PRIVATE  ****************'

# set list_id
private_list_id = ENV['PRIVATE_LIST_ID']

# send api & get json type response
private_json = client.get('rtm.tasks.getList', { list_id: private_list_id, filter: "status: incomplete" })

# parse response (returns "list of hash")
private_tasks = private_json['rsp']['tasks']['list'][0]['taskseries']

private_tasks.each do |task|
  begin
    puts "[#{task['tags']['tag']}]  #{task['name']}| color=pink"
    # show note of each task
    unless task['notes'].empty?
      puts "--#{task['notes']['note']['$t']}| color=pink"
    end
  rescue
    # rescue if task['tags'] does not have 'tag' value
    puts "#{task['name']}| color=pink" rescue nil
  end
end

##################
# work tasks
##################
puts '****************    WORK    ****************'

# set list_id
work_list_id = ENV['WORK_LIST_ID']

# send api & get json type response
work_json = client.get('rtm.tasks.getList', { list_id: work_list_id, filter: "status: incomplete" })

# parse response (returns "list of hash")
work_tasks = work_json['rsp']['tasks']['list'][0]['taskseries']

work_tasks.each do |task|
  puts "[#{task['tags']['tag']}]  #{task['name']}| color=green" rescue nil
end
