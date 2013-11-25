
git node[:wp][:cli][:install_path] do
	repository node[:wp][:cli][:git_repository]
	reference node[:wp][:cli][:git_revision]
	group 'admin'
	action :sync
	notifies :run, "execute[update-wp-cli]"
end

execute "update-wp-cli" do
	cwd node[:wp][:cli][:install_path]
	command "composer update"
	user 'root'
	action :nothing
end

template "/etc/profile.d/wp-cli.sh" do
	source 'wp-cli.sh.erb'
	owner 'root'
	mode '0755'
end