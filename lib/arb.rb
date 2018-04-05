module Kernel
  def arb_use(*modules)
    [].tap do |imported|
      modules.each do |mod|
        tmp=nil
        imported<<tmp if require(tmp="arb/#{mod}")
      rescue LoadError=>e
        warn("Fail to load #{mod}")
      end
    end

  end
  alias_method :use,:arb_use
end
