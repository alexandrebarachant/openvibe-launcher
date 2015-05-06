# This file is part of Openvibe launcher.
#
#    Openvibe launcher is free software: you can redistribute it and/or 
#    modify it under the terms of the GNU LESSER General Public License 
#    as published by the Free Software Foundation, either version 3 of 
#    the License, or (at your option) any later version.
#
#    Openvibe launcher is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU LESSER General Public License for more details.
#
#    You should have received a copy of the GNU LESSER General Public License
#    along with Openvibe launcher.  If not, see <http://www.gnu.org/licenses/>

module Openvibe
  attr_reader :mode, :scenario, :options
  class Launcher
    
    def initialize(designer_path, scenario_ , mode_ = "--open", options_ = [""])
      
      # check if designer script exists
      if File.exists?(designer_path)
        @path = designer_path
      else
        Error.critical("Designer script #{designer_path} not found")
      end
      
      @options = Array.new
      @prefix = nil
      # add scenario, mode and options
      self.scenario= scenario_
      self.mode= mode_
      self.options= options_  
      
    end

    def start
      self.start!
      Process.waitpid(@pid)
    end
    
    def start!
      dir = File.dirname(@path)
      command = "#{@prefix} #{@path} #{@mode} #{@scenario} #{@options.join(' ')}"    
      @pid = spawn(@env || {},command,:out=> @out || STDOUT,:chdir => dir )
      Process.detach(@pid)
    end
    
    def play
      @mode = "--play"
      self.start
    end
    
    def playfast
      @mode = "--play-fast"
      self.start
    end
    
    def setEnv(hash)
      @env = hash
    end
    
    def setOutput(str)
      @out = str
    end

    def setPrefix(str)
      @prefix = str
    end
        
    # scenario accessor
    def scenario=(sc)
      if File.exists?(sc)
        @scenario = sc
      else
        Error.critical("Scenario File #{sc} not found")
      end
    end
    
    #mode accessor
    def mode=(mode)
      allowedmode = ["--open","--play","--play-fast"]
      if allowedmode.include?(mode)
        @mode = mode
      else
        Error.critical("mode #{mode} not allowed ! Choose one of the following : #{allowedmode.join(' , ')}.")
      end
    end
    
    #options accessor
    def options=(opt)
      allowedopt = ["--no-gui","--no-session-management",""]
      opt.each do |o|
        if allowedopt.include?(o)
          @options.push(o)
        else
          Error.critical("Option #{o} not allowed ! Choose one of the following : #{allowedopt.join(' , ')}.")
        end
      end
    end
    
  end
  
  class Error
    def self.critical(msg)
      puts msg
      Process.exit(0)
    end
  end

end
