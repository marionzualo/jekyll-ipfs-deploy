require 'rake/remote_task'

set :domain, ENV['REMOTE_NODE_DOMAIN']


task default: %w(ipfs:remote_node)

namespace :ipfs do
  site_hash = ''

  task :local_node do
    # build jekyll site
    sh 'bundle exec jekyll build'

    # add site to IPFS and extract hash
    # this assumes that the ipfs daemon is already running locally
    site_hash = `ipfs add -r _site | awk '/_site$/ {print $2;}'`
  end

  remote_task :remote_node => :local_node do
    # this assumes that the ipfs daemon is already running remotely through a docker container
    # pin site so it stays online
    run "docker exec ipfs_host ipfs pin add #{site_hash}"

    # add site hash to updatable pointer based on the node
    run "docker exec ipfs_host ipfs name publish #{site_hash}"
  end
end
