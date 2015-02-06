module DOSBox
  module Command
    include BaseCommand

    module Library
      class CmdVer
        SYSTEM_VERSION = "Microsoft Windows XP [Version 5.1.2600]"
        DEVELOPER_INFO = [
                            "Ning Chu         <ning.chu@outlook.com>",
                            "Chan Meng        <chan.meng@outlook.com>",
                            "Jian Tsui        <jian.tsui@outlook.com>",
                            "Melissa Siska    <melissa.siska@outlook.com>",
                            "Krisna Hartanto  <krisna.hartanto@outlook.com>"
                         ]

        def initialize(command_name, drive)
          init(command_name, drive)
        end

        def check_number_of_params(num_of_params)
          num_of_params.eql? 0 or num_of_params.eql? 1
        end

        def check_param_values(outputter)
          if @params.length > 0
            @ver_to_print = self.check_ver_parameter(@params[0], outputter)
          else
            @ver_to_print = SYSTEM_VERSION
          end
        end

        def execute(outputter)
          if @params.length.eql? 0
            self.print_ver(outputter)
          end
        end

        def print_ver(outputter)
          outputter.println(@ver_to_print)
        end

        def check_ver_parameter(opt, outputter)
          if opt == '/w'
            outputter.println(SYSTEM_VERSION)
            DEVELOPER_INFO.each do |info|
              outputter.println(info)
            end
          end
        end
      end
    end
  end
end