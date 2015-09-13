#!/usr/bin/env ruby

require 'yaml'

class Config
  def do_dir(d)
    Dir.entries(d["src"]).each do |f|
      e = {
        "src" => d["src"] + f,
        "dest" => d["dest"] + f,
        "delim" => d["delim"]
      }
      do_file(e) unless File.directory?(f)
    end
  end
  def do_file(e)
    t = IO.read(e["src"]).split(e["delim"]).each.with_index
    .inject("") do |a, (p, i)|
        a + ((i % 2 == 1)? (@conf["vars"][p]):(p))
    end
    IO.write(e["dest"], t)
    printf("%#{@len}s -> #{e["dest"]}\n", e["src"]) if @verbose
  end
  def run()
    @conf["files"].each {|k,e| File.directory?(e["src"])? do_dir(e):do_file(e) }
    @conf["scripts"].each {|k,scr| `#{scr["cmd"]}` if @target == scr["target"]}
    puts("complete!") if @verbose
  end
  def initialize(filename, target)
    @conf = YAML.load(IO.read(filename))
    @target = target
    @verbose = false
    @len = @conf["files"].map{|k,f| f["src"]}.map{|d|
      File.directory?(d)? Dir.entries(d).reduce{|a,f|
        ((f + d).length > a.length)? (f + d):(a)
      }:d
    }.map{|s| s.length}.max.to_s
  end
end

if ARGV.length < 1
  puts "usage: #{$0} <config> [target]"
  exit 1
end
Config.new(ARGV[0], ARGV[1]).run() 
