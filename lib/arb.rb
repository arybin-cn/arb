require "arb/version"

module Arb
	class << self
		attr_accessor :default_load		
	end

	#gems to be autoloaded
	self.default_load=[:sqlite3]

	Kernel.send :define_method,:arb_init do |*args,&block|
		tmp=''
		(Arb.default_load||[]).each { |item| tmp.tap{|x| p 'loading'} <<item.to_s<<',' if require item.to_s }
		tmp.empty? ? 'nothing imported!': tmp.chop<<' imported!'
	end
end
