module DOSBox
  module Command
    module Library
      include BaseCommand

      class CmdHelp
        PARAMETER_CONTAINS_BACKLASH = "Cannot execute help"

        def initialize(command_name, drive)
          init(command_name, drive)
        end

        def check_number_of_params(num_of_params)
          true if num_of_params == 1 || num_of_params == 0
        end

        def check_param_values(outputter)
          @params.each do |param|
            return false if parameter_contains_backlashes?(param, outputter)
          end
          true
        end

        def execute(outputter)
            self.print_help(@params[0], outputter)
        end


          def parameter_contains_backlashes?(param, outputter)
            if /[\\\/]/.match(param)
              outputter.println(PARAMETER_CONTAINS_BACKLASH)
              true
            end
            false
          end

          def print_help(param, outputter)
            # help = ['cd', 'dir', 'exit', 'format', 'help', 'label', 'mkdir', 'mkfile', 'move']
            hash = {
              cd: "cd Displays the name of or changes the current directory.",
              dir: "dir Displays a list of files and subdirectories in a directory.",
              exit: "exit Quits the CMD.EXE program (command interpreter).",
              format: "format Formats a disk for use with Windows.",
              help: "help Provides Help information for Windows commands.",
              label: "label Creates, changes, or deletes the volume label of a disk.",
              mkdir: "mkdir Creates a directory.",
              mkfile: "mkfile Created a file.",
              move: "move Moves one or more files from one directory to another directory.",
              type: "type show file content"
            }
            if param.nil?
              hash.each do |k, v|
              outputter.println(v)
              end
            else
              if hash[param.to_sym].nil?
                outputter.println("command not exist!!!")
              else
                outputter.println(hash[param.to_sym])
              end
            end

# outputter.println(help.detect(param))


            # outputter.println(l)

          end
      end

    end
  end
end
