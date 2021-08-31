#
# Cookbook:: grafana
# Resource:: config_security
#
# Copyright:: 2018, Sous Chefs
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# Configures the installed grafana instance

unified_mode true

use 'partial/_config_file'

property :admin_user, String,
          default: 'admin'

property :admin_password, String,
          default: 'admin'

property :secret_key, String,
          default: 'SW2YcwTIb9zpOOhoPsMm'

property :login_remember_days, Integer,
          default: 7

property :cookie_username, String,
          default: 'grafana_user'

property :cookie_remember_name, String,
          default: 'grafana_remember'

property :disable_gravatar, [true, false],
          default: false

property :data_source_proxy_whitelist, String,
          default: ''

property :disable_brute_force_login_protection, [true, false],
          default: false

property :allow_embedding, [true, false],
          default: false

property :cookie_secure, [true, false],
          default: false

property :cookie_samesite, String,
          default: 'lax'

property :disable_initial_admin_creation, [true, false],
          default: false

property :strict_transport_security, [true, false],
          default: false

property :strict_transport_security_max_age_seconds, Integer

property :strict_transport_security_preload, [true, false],
          default: false

property :strict_transport_security_subdomains, [true, false],
          default: false

property :x_content_type_options, [true, false],
          default: false

property :x_xss_protection, [true, false],
          default: false

property :content_security_policy, [true, false],
          default: false

property :content_security_policy_template, String

action :install do
  resource_properties.each do |rp|
    next if nil_or_empty?(new_resource.send(rp))

    accumulator_config_set(rp.to_s, new_resource.send(rp))
  end
end
