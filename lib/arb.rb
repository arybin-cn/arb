module Arb
  class << self
    attr_accessor :required_gems
  end
  #param[0]: prefix of a gem
  Kernel.send :define_method, :arb_require do |*args, &block|
    Arb.required_gems||=[]
    tmp=[]
    $LOAD_PATH.each { |path| tmp<<Dir.tap { |dir| dir.chdir path }[(args[0] || 'arb_') +'*.rb'] }
    tmp.flatten!.map! { |item| item[0..-4] }.each { |gem| Arb.required_gems<< gem if require gem }
    Arb.required_gems.empty? ? 'Nothing required yet!' : 'Gems successfully required: ' << Arb.required_gems.uniq!.join(',')<<'!'
  end
end
