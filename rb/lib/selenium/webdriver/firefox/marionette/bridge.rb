# encoding: utf-8
#
# Licensed to the Software Freedom Conservancy (SFC) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The SFC licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

module Selenium
  module WebDriver
    module Firefox
      module Marionette

        #
        # Extension for the usual Remote::W3C::Bridge
        # @api private
        #

        module Bridge

          # Support for geckodriver < 0.15
          def resize_window(width, height, handle = :current)
            super
          rescue Error::UnknownCommandError
            execute :set_window_size, {}, {width: width, height: height}
          end

          def window_size(handle = :current)
            data = super
          rescue Error::UnknownCommandError
            data = execute :get_window_size
          ensure
            return Dimension.new data['width'], data['height']
          end

          def reposition_window(x, y)
            super
          rescue Error::UnknownCommandError
            execute :set_window_position, {}, {x: x, y: y}
          end

          def window_position
            data = super
          rescue Error::UnknownCommandError
            data = execute :get_window_position
          ensure
            return Point.new data['x'], data['y']
          end

        end # Bridge
      end # Marionette
    end # Firefox
  end # WebDriver
end # Selenium
