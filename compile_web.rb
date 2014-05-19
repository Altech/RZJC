require 'fssm'
require 'colorize'
require 'pry'
require 'fileutils'

Compilers = [%w[slimrb slim html], %w[scss scss css]]

def compile(base, relative, compiler)
  cmd, meta_ext, ext = compiler
  sans_ext = relative[/(^.+)\.[^\.]+$/,1]
  output = "#{sans_ext}.#{ext}"
  FileUtils.rm output
  if system "#{cmd} #{relative} > #{output}"
    puts "#{Time.now.strftime("%Y-%m-%d %H:%M")}  #{sans_ext} has compiled.".green
  else
    puts "#{Time.now.strftime("%Y-%m-%d %H:%M")}  #{sans_ext} has not compiled.".red
  end
end

if ARGV.include? '--batch'
  Compilers.each do |compiler|
    Dir.glob("web/**/*.#{compiler[1]}").each do |relative|
      compile(__dir__, relative, compiler)
    end
  end
else
  threads = []
  Compilers.each do |compiler|
    threads << Thread.new do
      FSSM.monitor(__dir__, "web/**/*.#{compiler[1]}") do
        %i[update create].each do |method|
          self.send(method) {|base, relative|
            compile(base, relative, compiler)
          }
        end
      end
    end
  end
  threads.each{|t| t.join}
end
