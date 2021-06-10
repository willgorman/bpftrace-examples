#!/usr/bin/env ruby

class MyError < StandardError
end


while true
begin
  raise MyError
rescue
  sleep 2
end
end
