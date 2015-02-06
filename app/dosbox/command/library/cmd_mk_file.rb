module DOSBox
  module Command
    module Library
			include BaseCommand

      class CmdMkFile

        def initialize(command_name, drive)
          init(command_name, drive)
        end

        def check_number_of_params(num_of_params)
          num_of_params > 1
        end

        def check_param_values(outputter)
          !parameter_contains_backlashes?(@params.first, outputter)
        end

        def execute(outputter)
          file_name = @params[0]
          file_content = @params[1..-1].join(' ').to_s
          file_item = FileItem.new(file_name, file_content)
          @drive.current_dir.add(file_item)
        end

        private

        def parameter_contains_backlashes?(param, outputter)
          if /[\\\/]/.match(param)
            outputter.println(PARAMETER_CONTAINS_BACKLASH)
            true
          end
          false
        end

      end
    end
  end
end
