require 'date'

def recurringDates(date = Date.today, times)
      raise "Date must be a Date object " unless date.is_a? Date
      raise "Number of times must be between 1 to 12" unless (1..12).include? times
      
      a = []
      times.times do |t|
      	a << (date >> t)
      end
      a
end

# recurringDates Date.new(2013, 6, 15), 1

