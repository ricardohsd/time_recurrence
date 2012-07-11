require 'spec_helper'

describe TimeRecurrence do
  context "initialize" do
    it "should require :starts option" do
      expect {
        described_class.new({})
      }.to raise_error(ArgumentError, ":starts option is required")
    end

    it "should require valid :starts option" do
      expect {
        described_class.new(:starts => "invalid")
      }.to raise_error(ArgumentError, "invalid :starts option")
    end

    it "should require :interval option" do
      expect {
        described_class.new(:starts => Time.new(2012, 9, 6, 10, 0, 0))
      }.to raise_error(ArgumentError, ":interval option is required")
    end

    it "should require :interval to be greater than zero when provided" do
      expect {
        described_class.new(:starts => Time.new(2012, 9, 6, 10, 0, 0), :interval => 0)
      }.to raise_error(ArgumentError, "invalid :interval option")
    end

    it "should require :repeat option" do
      expect {
        described_class.new(:starts => Time.new(2012, 9, 6, 10, 0, 0), :interval => 60)
      }.to raise_error(ArgumentError, ":repeat option is required")
    end

    it "should require :repeat to be greater than zero when provided" do
      expect {
        described_class.new(:starts => Time.new(2012, 9, 6, 10, 0, 0), :interval => 60, :repeat => 0)
      }.to raise_error(ArgumentError, "invalid :repeat option")
    end
  end

  context "#each" do
    it "should return an enumerator" do
      described_class.new(:starts => Time.new(2012, 9, 6, 10, 0, 0), :interval => 60, :repeat => 5).each.should be_instance_of(Enumerator)
    end
  end

  context "overlaping day" do
    it "repeating 5 times with 10 minutes as interval" do
      time_recurrence = described_class.new(:starts => Time.new(2012, 9, 6, 23, 30, 0), :interval => 600, :repeat => 5)
      time_recurrence.events[0].should eq Time.new(2012, 9, 6, 23, 30, 0)
      time_recurrence.events[1].should eq Time.new(2012, 9, 6, 23, 40, 0)
      time_recurrence.events[2].should eq Time.new(2012, 9, 6, 23, 50, 0)
      time_recurrence.events[3].should eq Time.new(2012, 9, 7, 0, 0, 0)
      time_recurrence.events[4].should eq Time.new(2012, 9, 7, 0, 10, 0)

      time_recurrence.events.should have(5).items
    end

    it "repeating 5 times with 20 minutes as interval" do
      time_recurrence = described_class.new(:starts => Time.new(2012, 9, 6, 23, 30, 0), :interval => 1200, :repeat => 5)
      time_recurrence.events[0].should eq Time.new(2012, 9, 6, 23, 30, 0)
      time_recurrence.events[1].should eq Time.new(2012, 9, 6, 23, 50, 0)
      time_recurrence.events[2].should eq Time.new(2012, 9, 7, 0, 10, 0)
      time_recurrence.events[3].should eq Time.new(2012, 9, 7, 0, 30, 0)
      time_recurrence.events[4].should eq Time.new(2012, 9, 7, 0, 50, 0)

      time_recurrence.events.should have(5).items
    end
  end

  context "not overlaping day" do
    it "repeating 5 times with 10 minutes as interval" do
      time_recurrence = described_class.new(:starts => Time.new(2012, 9, 6, 10, 0, 0), :interval => 600, :repeat => 5, :overlap_day => false)
      time_recurrence.events[0].should eq Time.new(2012, 9, 6, 10, 0, 0)
      time_recurrence.events[1].should eq Time.new(2012, 9, 6, 10, 10, 0)
      time_recurrence.events[2].should eq Time.new(2012, 9, 6, 10, 20, 0)
      time_recurrence.events[3].should eq Time.new(2012, 9, 6, 10, 30, 0)
      time_recurrence.events[4].should eq Time.new(2012, 9, 6, 10, 40, 0)

      time_recurrence.events.should have(5).items
    end

    it "repeating 5 times with 20 minutes as interval" do
      time_recurrence = described_class.new(:starts => Time.new(2012, 9, 6, 23, 30, 0), :interval => 1200, :repeat => 5, :overlap_day => false)
      time_recurrence.events[0].should eq Time.new(2012, 9, 6, 23, 30, 0)
      time_recurrence.events[1].should eq Time.new(2012, 9, 6, 23, 50, 0)

      time_recurrence.events.should have(2).items
    end
  end
end
