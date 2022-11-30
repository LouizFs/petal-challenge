server 'ec2-44-204-92-120.compute-1.amazonaws.com', user: 'ubuntu', roles: %w{web app db}
set :ssh_options, {
forward_agent: true,
auth_methods: %w[publickey],
keys: %w[/home/petal.pem]
}