module DOSBox
  module Command
    module Library
			include BaseCommand

      class CmdMove

        attr_accessor :num_of_params, :num_of_params_ret_value, :param_values_ret_value, :executed

        SYSTEM_CANNOT_FIND_THE_PATH_SPECIFIED = "Path Not Found."

        def initialize(command_name, drive)
          init(command_name, drive)
          @command_name = command_name
          @num_of_params_ret_value = true
          @param_values_ret_value = true
        end

        def check_number_of_params(num_of_params)
          @num_of_params = num_of_params
          @num_of_params_ret_value = (@num_of_params == 2)
        end

        def check_param_values(outputter)
          # check format of file or folder name
          filename_valid = !parameter_contains_backlashes?(@params.first, outputter)
          return filename_valid unless filename_valid
          @file_or_folder_name = @params[0]


          # check original path
          @fi = check_original_path

          # check destination is a valid folder
          dest_valid = !destination_valid?(@params[1]).nil?
          return dest_valid unless dest_valid
          @dest = @drive.item_from_path(@params[1])

          # check same name not exists
          existance_valid = name_valid?(@params[1], @file_or_folder_name)
          return existance_valid unless existance_valid

          true
        end

        def execute(outputter)
          # pp "#{@drive.current_dir.path}\\#{@file_or_folder_name}"
          # fi = @drive.item_from_path("#{@drive.current_dir.path}\\#{@file_or_folder_name}")

          @dest.add @fi
          if @command_name.downcase == 'move'
pp 'sssss'
            @drive.current_dir.remove @fi
          end
        end

        private

        def check_original_path
          file_system_item = @drive.item_from_path("#{@drive.current_dir.path}\\#{@file_or_folder_name}")
          if file_system_item.nil?
            outputter.println(SYSTEM_CANNOT_FIND_THE_PATH_SPECIFIED)
            return nil
          end
          file_system_item
        end

        def name_valid?(path_name, filename)
          @dest.content.each do |item|
            pp 'item.name'
            return false if item.name == filename
          end
          true
        end

        def destination_valid?(path_name)
          file_system_item = @drive.item_from_path(path_name)

          if file_system_item.nil?
            outputter.println(SYSTEM_CANNOT_FIND_THE_PATH_SPECIFIED)
            return nil
          end

          unless file_system_item.is_directory?
            outputter.println(SYSTEM_CANNOT_FIND_THE_PATH_SPECIFIED)
            return nil
          end

          file_system_item
        end

        def original_exist?(filename)


        end

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