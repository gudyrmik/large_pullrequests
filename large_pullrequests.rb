#!/usr/bin/ruby

require 'octokit'

if ARGV.length < 2
  puts 'Provide at repo and token arguments'
  exit
end

repo = ARGV[0]
token = ARGV[1]

client = Octokit::Client.new(access_token: token)
client.auto_paginate = true

pulls = client.pull_requests(repo, :state => 'opened')
pulls.each do |pull|
  commits_number = client.pull_request_commits(repo, pull.number).size
  commit_url = pull.url
  puts "#{pull.url.to_s} has #{commits_number} commits" if commits_number > 1
end
