require 'spec_helper'
require 'command_helper'

describe CmdType do
  include CommandHelper

  before :each do
    prepare_for_commands

    @drive = Drive.new("C")
    @root_dir = @drive.root_dir

    @sub_dir1 = Directory.new("subdir1")
    @root_dir.add(@sub_dir1)

    @sub_sub_dir1 = Directory.new("subsubdir1")
    @sub_dir1.add(@sub_sub_dir1)

    file_name = "file.txt"
    @file_content = "this is content"
    @file = FileItem.new(file_name, @file_content)
    @root_dir.add(@file)

    @cmd = CmdType.new("type", @drive)
    @cmd_cd = CmdDir.new("cd", @drive)
    @invoker.add_command(@cmd)
    @invoker.add_command(@cmd_cd)
  end

  it "should output 'The system cannot find the file specified' when file is not found" do
    execute_command("TYPE abc")
    expect(@outputter.output).to include("The system cannot find the file specifie")
  end

  it "should output 'Access is denied' when it is a directory" do
    @drive.change_current_dir(@sub_dir1)
    execute_command("type subsubdir1")
    expect(@outputter.output).to include("Access is denied")
  end

  it "should output content when it is a file" do
    execute_command("cd C:")
    execute_command("type file.txt")
    expect(@outputter.output).to include(@file_content)
  end
end