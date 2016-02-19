module Arb
  class << self
    attr_accessor :required_gems
  end
  #params: prefix of gems that need to be required 
  Kernel.send :define_method, :arb_require do |*args, &block|
    Arb.required_gems||=[]
    args.unshift 'arb_'
    tmp=[]
    $LOAD_PATH.each { |path| args.each { |arg| tmp<<Dir.tap { |dir| dir.chdir path }[arg.to_s+'*.rb'] } }
    tmp.flatten!.map! { |item| item[0..-4] }.each { |gem| Arb.required_gems<< gem if require gem }
    Arb.required_gems.empty? ? 'Nothing required yet!' : 'Gems successfully required: ' << Arb.required_gems.uniq.join(',')<<'!'
  end

  arb_require
end
