# Cookbook:: grafana
# Resource:: config_auth_proxy
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

property :header_name, String

property :header_property, String

property :auto_sign_up, [true, false]

property :ldap_sync_ttl, Integer

property :whitelist, String

property :headers, String

property :enable_login_token, [true, false]
