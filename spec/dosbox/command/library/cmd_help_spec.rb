require 'spec_helper'
require 'command_helper'

describe CmdHelp do
  include CommandHelper

  before :each do
    prepare_for_commands

    @cmd = CmdHelp.new("help", @drive)
    @invoker.add_command(@cmd)
  end


  it "should output all help" do
    execute_command("HELP")
    expect(@outputter.output).to eq(
        "cd Displays the name of or changes the current directory."+
        "dir Displays a list of files and subdirectories in a directory."+
        "exit Quits the CMD.EXE program (command interpreter)."+
        "format Formats a disk for use with Windows."+
        "help Provides Help information for Windows commands."+
        "label Creates, changes, or deletes the volume label of a disk."+
        "mkdir Creates a directory."+
        "mkfile Created a file."+
        "move Moves one or more files from one directory to another directory."+
        "type show file content"
      )
  end

  it "should output error for wrong parameter" do
    execute_command("HELP abc")
    expect(@outputter.output).to eq("command not exist!!!")
  end


  it "should output error for too many parameters" do
    execute_command("HELP CD MOVE")
    expect(@outputter.output).to eq("The syntax of the command is incorrect.Wrong parameter entered.")
  end

  it "should output help for command with CD parameter" do
    execute_command("HELP CD")
    expect(@outputter.output).to eq("cd Displays the name of or changes the current directory.")
  end

  it "should output help for command with DIR parameter" do
    execute_command("HELP DIR")
    expect(@outputter.output).to eq("dir Displays a list of files and subdirectories in a directory.")
  end

it "should output help for command with EXIT parameter" do
    execute_command("HELP EXIT")
    expect(@outputter.output).to eq("exit Quits the CMD.EXE program (command interpreter).")
  end

it "should output help for command with FORMAT parameter" do
    execute_command("HELP FORMAT")
    expect(@outputter.output).to eq("format Formats a disk for use with Windows.")
  end

it "should output help for command with HELP parameter" do
    execute_command("HELP HELP")
    expect(@outputter.output).to eq("help Provides Help information for Windows commands.")
  end

it "should output help for command with LABEL parameter" do
    execute_command("HELP LABEL")
    expect(@outputter.output).to eq("label Creates, changes, or deletes the volume label of a disk.")
  end

it "should output help for command with MKDIR parameter" do
    execute_command("HELP MKDIR")
    expect(@outputter.output).to eq("mkdir Creates a directory.")
  end


it "should output help for command with MKFILE parameter" do
    execute_command("HELP MKFILE")
    expect(@outputter.output).to eq("mkfile Created a file.")
  end


end
