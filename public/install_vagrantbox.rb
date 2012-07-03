#!/System/Library/Frameworks/Ruby.framework/Versions/1.8/usr/bin/ruby

module Tty extend self
  def blue; bold 34; end
  def white; bold 39; end
  def red; underline 31; end
  def reset; escape 0; end
  def bold n; escape "1;#{n}" end
  def underline n; escape "4;#{n}" end
  def escape n; "\033[#{n}m" if STDOUT.tty? end
end

class Array
  def shell_s
    cp = dup
    first = cp.shift
    cp.map{ |arg| arg.gsub " ", "\\ " }.unshift(first) * " "
  end
end

def ohai *args
  puts "#{Tty.blue}==>#{Tty.white} #{args.shell_s}#{Tty.reset}"
end

def warn warning
  puts "#{Tty.red}Warning#{Tty.reset}: #{warning.chomp}"
end

def system *args
  abort "Failed during: #{args.shell_s}" unless Kernel.system *args
end

def sudo *args
  args = if args.length > 1
    args.unshift "/usr/bin/sudo"
  else
    "/usr/bin/sudo #{args.first}"
  end
  ohai *args
  system *args
end

def getc # NOTE only tested on OS X
  system "/bin/stty raw -echo"
  if RUBY_VERSION >= '1.8.7'
    STDIN.getbyte
  else
    STDIN.getc
  end
ensure
  system "/bin/stty -raw echo"
end

def macos_version
  @macos_version ||= /(10\.\d+)(\.\d+)?/.match(`/usr/bin/sw_vers -productVersion`).captures.first.to_f
end


####################################################################### script
abort "MacOS too old, see: https://gist.github.com/1144389" if macos_version < 10.5
abort "/usr/local/.git already exists!" unless Dir["/usr/local/.git/*"].empty?
abort "Don't run this as root!" if Process.uid == 0

ohai "This script will install:"
puts "./Vagrantconfig"
puts "~/.vagrant.d/boxes/[BOXNAME]"

if STDIN.tty?
  puts
  puts "Press enter to continue"
  c = getc
  # we test for \r and \n because some stuff does \r instead
  abort unless c == 13 or c == 10
end

#todo from here!

if File.directory? "/usr/local"
  sudo "/bin/chmod", "g+rwx", *chmods unless chmods.empty?
  sudo "/usr/bin/chgrp", "admin", *chgrps unless chgrps.empty?
else
  sudo "/bin/mkdir /usr/local"
  sudo "/bin/chmod g+rwx /usr/local"
  # the group is set to wheel by default for some reason
  sudo "/usr/bin/chgrp admin /usr/local"
end

Dir.chdir "/usr/local" do
  ohai "Downloading and Installing Homebrew..."
  # -m to stop tar erroring out if it can't modify the mtime for root owned directories
  # pipefail to cause the exit status from curl to propogate if it fails
  # we use -k because OS X curl has a bunch of bad SSL certificates
  # you may want to remove the -k flag from your fork!
  system "/bin/bash -o pipefail -c '/usr/bin/curl -skSfL https://github.com/mxcl/homebrew/tarball/master | /usr/bin/tar xz -m --strip 1'"
end

warn "/usr/local/bin is not in your PATH." unless ENV['PATH'].split(':').include? '/usr/local/bin'

if macos_version < 10.7
  warn "Now install Xcode: https://developer.apple.com/xcode/" unless File.exist? "/usr/bin/cc"
else
  warn "Now install the \"Command Line Tools for Xcode\": http://connect.apple.com" unless File.file? "/usr/bin/xcrun"
end

ohai "Installation successful!"
puts "You should run `brew doctor' *before* you install anything."
puts "Now type: brew help"