module Openvibe
  attr_reader :mode, :scenario, :options
  class Launcher
    
    def initialize(designer_path, scenario_ , mode_ = "--open", options_ = [""])
      
      # check if designer script exists
      if File.exists?(designer_path)
        @path = designer_path
      else
        Error.critical("Designer script #{sc} not found")
      end
      
      @options = Array.new
      
      # add scenario, mode and options
      self.scenario= scenario_
      self.mode= mode_
      self.options= options_  
      
    end

    def start
      command = "#{@path} #{@mode} #{@scenario} #{@options.join(' ')}"    
      @pid = spawn(@env || {},command,:out=> @out || STDOUT )
      Process.waitpid(@pid)
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
