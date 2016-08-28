# jekyll-ipfs-deploy
A set of rake tasks (present in `ipfs_deploy.rake`) that deploys a Jekyll site to IPFS.

I was inspired to create this script after reading:
- [Serving a website over IPFS](http://www.atnnn.com/p/ipfs-hosting/)
- [Publishing to IPFS](https://sevdev.hu/ipns/sevdev.hu/posts/2016-06-26-publishing-to-ipfs.html)

The overview of how this deployment workflow:
- I have a VPS running a [docker container with IPFS](https://github.com/ipfs/go-ipfs)
- The script builds the site on my local machine and adds the site to IPFS. This assumes that the IPFS daemon is already running on my machine when the script runs.
- The script SSHs to my VPS, caches the site locally using `IPFS  pin`, and updates the IPFS pointer to the new version of the site.

Some other practicalities:
- I add this script to my `/_plugins` directory inside my Jekyll site
- I run this script with `REMOTE_NODE_DOMAIN="<IP_ADDR>" rake -f _plugins/ipfs_deploy.rake`
- `rake` and `rake-remote_task` are needed in order to run this

[More details on how I this is used in my site](https://github.com/marionzualo/www/commit/54ee4b6f0716709bfee5784ee6c18b561c1c1ba0)
