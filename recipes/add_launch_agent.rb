launch_agents_path = File.expand_path(File.join('~','Library', 'LaunchAgents'))
directory launch_agents_path do
  action :create
  recursive true
  owner node['current_user']
end

plist_filename = node['sprout']['postgresql']['plist_filename'];
homebrew_root = '/usr/local'
postgresql_install_path = File.join(homebrew_root, 'opt', 'postgresql')
source_plist_filename = File.join(postgresql_install_path, plist_filename)
launch_agent_plist_filename = File.join(launch_agents_path, plist_filename)

link launch_agent_plist_filename do
  to source_plist_filename
end

execute 'start the daemon' do
  command "launchctl load -w #{launch_agent_plist_filename}"
  user node['current_user']
end