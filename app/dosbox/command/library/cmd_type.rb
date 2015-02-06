module DOSBox
  module Command
    module Library
			include BaseCommand

      class CmdType

        attr_accessor :num_of_params, :num_of_params_ret_value, :param_values_ret_value, :executed

        SYSTEM_CANNOT_FIND_THE_PATH_SPECIFIED = "The system cannot find the file specified"
        ACCESS_DENIED = "Access is denied"

        def initialize(command_name, drive)
          init(command_name, drive)
          @command_name = command_name
          @num_of_params_ret_value = true
          @param_values_ret_value = true
        end

        def check_number_of_params(num_of_params)
          @num_of_params = num_of_params
          @num_of_params_ret_value = (@num_of_params == 1)
        end

        def check_param_values(outputter)
          @file_system_item = @drive.item_from_path("#{@drive.current_dir.path}\\#{@params[0]}")

          # filename is invalid
          if @file_system_item.nil?
            outputter.println(SYSTEM_CANNOT_FIND_THE_PATH_SPECIFIED)
            return nil
          end

          # is not a file
          if @file_system_item.is_directory?
            outputter.println(ACCESS_DENIED)
            return nil
          end

          @file_system_item
        end

        def execute(outputter)
          outputter.println(@file_system_item.content)
        end
      end
    end
  end
end