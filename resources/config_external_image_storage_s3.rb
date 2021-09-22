#
# Cookbook:: grafana
# Resource:: config_external_image_storage_s3
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

property :endpoint, String

property :path_style_access, [true, false]

property :storage_provider, String,
          default: 's3'

property :region, String,
          required: true

property :bucket, String

property :bucket_url, String

property :path, String

property :access_key, String

property :secret_key, String

def resource_config_path_override
  %w(external_image_storage.s3)
end
