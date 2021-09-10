#
# Cookbook:: grafana
# Resource:: config_alerting
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
# Configures the installed grafana instance

unified_mode true

use 'partial/_config_file'

property :enabled, [true, false],
          default: false

property :execute_alerts, [true, false]

property :error_or_timeout, String

property :nodata_or_nullvalues, String

property :concurrent_render_limit, Integer

property :evaluation_timeout_seconds, Integer

property :notification_timeout_seconds, Integer

property :max_attempts, Integer

property :min_interval_seconds, Integer

property :max_annotation_age, String

property :max_annotations_to_keep, String

action :create do
  converge_if_changed {}

  resource_properties.each do |rp|
    next if nil_or_empty?(new_resource.send(rp))

    accumulator_config(:set, rp.to_s, new_resource.send(rp))
  end

  new_resource.extra_options.each { |key, value| accumulator_config(:set, key, value) } if property_is_set?(:extra_options)
end
