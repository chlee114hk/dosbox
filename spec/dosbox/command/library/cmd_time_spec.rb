require 'spec_helper'
require 'command_helper'

describe CmdTime do
  include CommandHelper

  before :each do
    prepare_for_commands

    @cmd = CmdTime.new("time", @drive)
    @invoker.add_command(@cmd)
  end

  it "should output current time" do
    time = Time.new
    execute_command("TIME")
    expect(@outputter.output).to eq(time.strftime("%H:%M:%S"))
  end

  it "should output current time" do
    time = Time.new
    execute_command("TIME 21:13:45")
    expect(@outputter.output).to be_empty
  end
end