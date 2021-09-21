#
# Cookbook:: grafana
# Resource:: config_server
#
# Copyright:: 2021, Sous Chefs
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

unified_mode true

use 'partial/_config_file'

property :protocol, [Symbol, String],
          equal_to: [ :http, :https, :socket, 'http', 'https', 'socket' ]

property :http_addr, String,
          default: ''

property :http_port, Integer,
          default: 3000

property :domain, String

property :root_url, String,
          default: '%(protocol)s://%(domain)s:%(http_port)s/'

property :serve_from_sub_path, [true, false]

property :enforce_domain, [true, false]

property :router_logging, [true, false]

property :static_root_path, String,
          default: 'public'

property :enable_gzip, [true, false]

property :cert_file, String

property :cert_key, String

property :socket, String

property :cdn_url, String

property :read_timeout, String
