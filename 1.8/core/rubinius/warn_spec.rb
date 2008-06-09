require File.dirname(__FILE__) + '/../../spec_helper'
# require File.dirname(__FILE__) + '/fixtures/classes'

describe "Kernel.warn" do
  it "is a private method" do
    Kernel.private_instance_methods.should include("warn")
  end

  it "calls #write on $stderr if $VERBOSE is true" do
    lambda {
      v = $VERBOSE
      $VERBOSE = true

      Rubinius.warn("this is some simple text")

      $VERBOSE = v
    }.should output(nil, /warn_spec.rb:\d+: warning: this is some simple text\n/)
  end

  it "calls #write on $stderr if $VERBOSE is false" do
    lambda {
      v = $VERBOSE
      $VERBOSE = false

      Rubinius.warn("this is some simple text")

      $VERBOSE = v
    }.should output(nil, /warn_spec.rb:\d+: warning: this is some simple text\n/)
  end

  it "does not call #write on $stderr if $VERBOSE is nil" do
    lambda {
      v = $VERBOSE
      $VERBOSE = nil

      Rubinius.warn("this is some simple text")

      $VERBOSE = v
    }.should output(nil, "")
  end

  it "writes the default record seperator (\\n) and NOT $/ to $stderr after the warning message" do
    lambda {
      v = $VERBOSE
      rs = $/
      $VERBOSE = true
      $/ = 'rs'

      Rubinius.warn("")

      $VERBOSE = v
      $/ = rs
    }.should output(nil, /\n/)
  end
end

describe "Kernel#warn" do
  it "needs to be reviewed for spec completeness" do
  end
end
