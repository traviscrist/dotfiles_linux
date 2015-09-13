#!/usr/bin/ruby

def battery
	b = (`acpi 2>/dev/null`).strip
  return "" if b.length == 0
  return "\ue033 " + b
end

def time
	return ("\ue015 " + `date +"%a %b %d %r"`).strip
end

def song
  song = (`mpc -f %title%`).lines
  return "\ue04d ...       " if song[0] =~ /^\[/ or song[1] =~ /^\[paused\]/
  return "\ue04d %10s" % song[0].strip.slice(0,10)
end

def user
	return "\ue00e ben"
end

def bar
	return [song(), battery(), time(), user()].reject{|m| m.length == 0}.join("    ")
end

def run
	while (1)
		system("xsetroot -name " + "'" + bar() + "'")
    sleep 0.2
	end	
end

run()
