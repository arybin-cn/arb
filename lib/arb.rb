module Kernel
  def arb_use(*modules)
    [].tap do |imported|
      modules.each do |mod|
        tmp=nil
        imported<<tmp if require(tmp="arb/#{mod}")
      end
    end
  end
  alias_method :use,:arb_use
end
