module DOSBox
  module Command
    include BaseCommand

    module Library
      class CmdTime
        SYSTEM_REJECTED_WITH_ERROR_MESSAGE_DISPLAYED = "Command rejected: Input is not time"
        SYSTEM_REJECTED_WITH_WRONG_HOUR = "Command rejected: Wrong hour"
        SYSTEM_REJECTED_WITH_WRONG_MIN = "Command rejected: Wrong minute"
        SYSTEM_REJECTED_WITH_WRONG_SEC = "Command rejected: Wrong second"

        def initialize(command_name, drive)
          init(command_name, drive)
        end

        def check_number_of_params(num_of_params)
          num_of_params.eql? 0 or num_of_params.eql? 1
        end

        def check_param_values(outputter)
          if @params.length > 0
            @time_to_print = self.check_time_parameter(@params[0], outputter)
          else
            @time_to_print = current_time
            true
          end
        end

        def execute(outputter)
          if @params.length.eql? 0
            self.print_current_directory_path(outputter)
          end
        end

        def print_current_directory_path(outputter)
          outputter.println(@time_to_print)
        end

        def current_time
          time = Time.new
          time.strftime("%H:%M:%S")
        end

        def check_time_parameter(time, outputter)
          if /^\d{2}:\d{2}:\d{2}/.match(time)
            time_str = time.strip.match(/^(?<hour>\d+):(?<min>\d+):(?<sec>\d+)$/)
            hour = time_str['hour'].to_i
            min = time_str['min'].to_i
            sec = time_str['sec'].to_i
            if (hour < 0 || hour > 23)
              outputter.println(SYSTEM_REJECTED_WITH_WRONG_HOUR)
            elsif (min < 0 || min > 59)
              outputter.println(SYSTEM_REJECTED_WITH_WRONG_MIN)
            elsif (sec < 0 || sec > 59)
              outputter.println(SYSTEM_REJECTED_WITH_WRONG_SEC)
            else
              return true
            end
          else
            outputter.println(SYSTEM_REJECTED_WITH_ERROR_MESSAGE_DISPLAYED)
          end
        end
      end
    end
  end
end