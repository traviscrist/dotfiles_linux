#!/usr/bin/ruby

class Command
  def initialize(delay, &cmd)
    @last_run = Time.new(0)
    @delay = delay
    @cmd = cmd 
    @cache = run()
  end
  def run()
    time = Time.now
    if time > (@last_run + @delay)
      @last_run = time
      @cache = @cmd.call
    end
    return @cache 
  end
end

Bcmd = Command.new(5.0){(`acpi 2>/dev/null`).strip}
Tcmd = Command.new(1.0){("\ue015 " + `date +"%a %b %d %r"`).strip}
Scmd = Command.new(0.1){(`mpc -f %title%`).lines}
Ucmd = Command.new(3.0){(`snotify unread 2>/dev/null`).strip}
Pcmd = Command.new(1.0){(`pgrep pacman`).strip}

def unread
  u = Ucmd.run()
  return "\ue19f " + u if u.length > 0
  return ""
end

def battery
	b = Bcmd.run()
  return "" if b.length == 0
  return "\ue033 " + b
end

def time
	return Tcmd.run()
end

def song
  song = Scmd.run()
  return "\ue04d N/A" if song[0] =~ /^\[/ or song[1] =~ /^\[paused\]/
  return "\ue04d " + song[0].strip
end

def user
  p = Pcmd.run()
	return "\ue00e ben" if p.length == 0
	return "\ue00f ben"
end

def bar
	return [
    song(),
    unread(),
    battery(),
    time(),
    user()
  ].reject{|m| m.length == 0}.join("    ")
end

def run
	while (1)
		system("xsetroot -name " + "'" + bar() + "'")
    sleep 0.1
	end	
end

run()
