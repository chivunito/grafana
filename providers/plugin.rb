use_inline_resources if defined?(use_inline_resources)

def whyrun_supported?
  true
end

action :install do
  plugin_name = new_resource.name
  plugin_url = new_resource.plugin_url
  binary = new_resource.grafana_cli_bin
  raise "#{plugin_name} is not available" unless ::GrafanaCookbook::Plugin.available?(plugin_name, plugin_url, binary)
  execute "Installing plugin #{plugin_name}" do
    command ::GrafanaCookbook::Plugin.build_cli_cmd(plugin_name, 'install', binary, plugin_url)
    not_if { current_resource.installed }
  end
end

action :update do
  plugin_name = new_resource.name
  plugin_url = new_resource.plugin_url
  binary = new_resource.grafana_cli_bin
  if current_resource.installed
    execute "Updating plugin #{plugin_name}" do
      if plugin_url
        # Force installation when url is provided, as grafana-cli won't update using an url. It will fail silently.
        command ::GrafanaCookbook::Plugin.build_cli_cmd(plugin_name, 'remove', binary)
        command ::GrafanaCookbook::Plugin.build_cli_cmd(plugin_name, 'install', binary, plugin_url)
      else
        command ::GrafanaCookbook::Plugin.build_cli_cmd(plugin_name, 'update', binary)
      end
    end
  else
    Chef::Log.warn "Impossible to upgrade plugin #{plugin_name} because it is not installed. We will install it."
    run_action(:install)
  end
end

action :remove do
  plugin_name = new_resource.name
  binary = new_resource.grafana_cli_bin
  execute "Removing plugin #{name}" do
    command ::GrafanaCookbook::Plugin.build_cli_cmd(plugin_name, 'remove', binary)
    only_if { current_resource.installed }
  end
end

def load_current_resource
  @current_resource = Chef::Resource::GrafanaPlugin.new(@new_resource.name)
  @current_resource.installed = GrafanaCookbook::Plugin.installed?(new_resource.name, new_resource.grafana_cli_bin)
end
