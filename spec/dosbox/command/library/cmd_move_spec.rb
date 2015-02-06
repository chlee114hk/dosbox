require 'spec_helper'
require 'command_helper'

describe CmdMove do
  include CommandHelper

  before :each do
    prepare_for_commands

    @cmd = CmdMove.new("move", @drive)
    @invoker.add_command(@cmd)

    @cmd1 = CmdMkFile.new("mkfile", @drive)
    @invoker.add_command(@cmd1)

    @cmd2 = CmdMkDir.new("mkdir", @drive)
    @invoker.add_command(@cmd2)
  end

it "enter move: should output error" do
  execute_command("move")
  expect(@outputter.output).to eq("The syntax of the command is incorrect.Wrong parameter entered.")
end


it "move successful" do
    @drive.change_current_dir(@root_dir)
    test_dir1_name = "test1"

    execute_command("mkdir " + test_dir1_name)

    test_dir1 = @drive.item_from_path(test_dir1_name)

    expect(test_dir1.parent).to eq @root_dir

    file_name = "file.txt"
    new_file_name = "move_file.txt"
    file_content = "This is the content"

    execute_command("mkfile #{file_name} '#{file_content}'")
    expect(@outputter.output).to be_empty
    expect(@drive.current_dir.num_of_contained_files).to eq 1
    execute_command("move #{file_name} #{test_dir1_name}")

    expect(@outputter.output).to be_empty
    # expect(@outputter.output).to eq("sf")
end


it "enter move: should output error" do
    @drive.change_current_dir(@root_dir)
    test_dir1_name = "test1"

    execute_command("mkdir " + test_dir1_name)

    test_dir1 = @drive.item_from_path(test_dir1_name)

    expect(test_dir1.parent).to eq @root_dir

    file_name = "file.txt"
    new_file_name = "move_file.txt"
    file_content = "This is the content"

    execute_command("mkfile #{file_name} '#{file_content}'")
    execute_command("move #{file_name} #{test_dir1_name}")

    execute_command("mkfile #{file_name} '#{file_content}'")

    execute_command("move #{file_name} #{test_dir1_name}")

    expect(@outputter.output).to eq("Wrong parameter entered.Wrong parameter entered.")
    # expect(@outputter.output).to eq("sf")
end


end
