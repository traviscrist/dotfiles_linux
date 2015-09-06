#!/usr/bin/ruby

def battery
	return (`acpi`).strip
end

def time
	return (`date +"%a %b %d %r"`).strip
end

def user
	return "ben"
end

def bar
	return battery() + " | " + time() + " | " + user()
end

def run
	while (1)
		system("xsetroot -name " + "'" + bar() + "'")
		`sleep 1`
	end	
end

run()
