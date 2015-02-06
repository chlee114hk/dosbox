require 'spec_helper'
require 'command_helper'

describe CmdVer do
  include CommandHelper

  before :each do
    prepare_for_commands

    @cmd = CmdVer.new("ver", @drive)
    @invoker.add_command(@cmd)
  end

  it "should output version" do
    execute_command("VER")
    expect(@outputter.output).to eq("Microsoft Windows XP [Version 5.1.2600]")
  end

  it "should output version and develop info" do
    execute_command("VER /w")
    expect(@outputter.output).to eq(
      "Microsoft Windows XP [Version 5.1.2600]" +
      "Ning Chu         <ning.chu@outlook.com>" +
      "Chan Meng        <chan.meng@outlook.com>" +
      "Jian Tsui        <jian.tsui@outlook.com>" +
      "Melissa Siska    <melissa.siska@outlook.com>" +
      "Krisna Hartanto  <krisna.hartanto@outlook.com>"
    )
  end
end