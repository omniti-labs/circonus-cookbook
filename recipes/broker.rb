#
# Cookbook Name:: circonus
# Recipe:: broker
#

# Note that this recipe requires java to be installed. The 'java' cookbook is recommended
# for this.

install_cmd = value_for_platform(
    "smartos" => {
        "default" => "curl http://updates.circonus.com/joyent/smartos/smartos-update.sh | sh"
    }
)
noit_dir = value_for_platform(
    "smartos" => {
        "default" => "/opt/noit"
    }
)
napp_conf = value_for_platform(
    "smartos" => {
        "default" => "/opt/napp/etc/httpd.conf"
    }
)

execute "Install Circonus broker" do
  command install_cmd
  cwd "/root"
  not_if { ::File.directory?(noit_dir) }
end

service "napp" do
  supports :start => true, :stop => true, :restart => true
end

execute "Update napp httpd port (for configuration)" do
  command "sed -i -e's/Listen [0-9]\\+/Listen #{node["circonus"]["napp"]["port"]}/' #{napp_conf}"
  notifies :restart, "service[napp]"
  not_if "grep 'Listen #{node["circonus"]["napp"]["port"]}' #{napp_conf}"
end
