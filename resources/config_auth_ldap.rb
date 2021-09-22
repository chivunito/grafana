# Cookbook:: grafana
# Resource:: config_auth_ldap
#
# Copyright:: 2021, Sous Chefs
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

unified_mode true

use 'partial/_config_file'

property :enabled, [true, false],
          default: false

property :ldap_config_file, String,
          default: '/etc/grafana/ldap.toml'

property :allow_sign_up, [true, false]

def resource_config_properties_translate
  {
    ldap_config_file: 'config_file',
  }.freeze
end
