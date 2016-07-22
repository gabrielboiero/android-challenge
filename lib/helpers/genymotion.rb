module Android

  # Genymotion module uses shell commands to interact with the emulator
  # No API available for Ruby language (should be ported from Java API)
  module Genymotion

    # should be set as system environment variable
    PATH = '/opt/genymotion'

    module Battery

      module_function

      def set_charge(percent)
        `#{PATH}/genyshell -c "battery setlevel #{percent}"`
        sleep(5)  # Forced sleep to wait update from shell to emulator
      end

    end


    module GPS

      module_function

      def set_latitude(value)
        `#{PATH}/genyshell -c "gps setlatitude #{value}"`
        sleep(5)  # Forced sleep to wait update from shell to emulator
      end

      def set_longitude(value)
        `#{PATH}/genyshell -c "gps setlongitude #{value}"`
        sleep(5)  # Forced sleep to wait update from shell to emulator
      end

      def enable
        `#{PATH}/genyshell -c "gps setstatus enabled"`
        sleep(5)  # Forced sleep to wait update from shell to emulator
      end

      def disable
        `#{PATH}/genyshell -c "gps setstatus disabled"`
        sleep(15)  # Disable needs few extra seconds to update emulator
      end

      # 'getlatitude' from Genymotion truncate values with 4 decimals
      def latitude
        output = `#{PATH}/genyshell -c "gps getlatitude"`
        output.split("\n").last.split(": ").last
      end

      # 'getlongitude' from Genymotion truncate values with 5 decimals
      def longitude
        output = `#{PATH}/genyshell -c "gps getlongitude"`
        output.split("\n").last.split(": ").last
      end

    end

  end

end

