module DOSBox
	module Command
		class Factory
      attr_reader :commands

      # :nocov:
			def initialize(drive)
				@commands = Array.new

				@commands << CmdCd.new("cd", drive)
        @commands << CmdDir.new("dir", drive)
        @commands << CmdMkDir.new("mkdir", drive)
        @commands << CmdMkFile.new("mkfile", drive)
        @commands << CmdMkFile.new("mf", drive)
        @commands << CmdTime.new("time", drive)
        @commands << CmdVer.new("ver", drive)
        @commands << CmdMove.new("move", drive)
        # @commands << CmdCopy.new("copy", drive)
        @commands << CmdHelp.new("help", drive)
        @commands << CmdType.new("type", drive)
			end
      # :nocov:
		end
	end
end