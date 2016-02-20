module Arb
	class << self
		attr_accessor :required_gems
	end

	#params: prefix of gems that need to be required 
	#default will require the series of 'arb' gems whose prefix is 'arb_'
	Kernel.send :define_method, :arb_require do |*args, &block|
		Arb.required_gems||=[]
		args.unshift 'arb_'
		tmp=[]
		args.each { |arg| tmp << Gem::Specification.select { |gem| gem.author='arybin' && gem.name=~/^#{arg}/ }.map { |gem| gem.name }}	
		tmp.compact.uniq.flatten!.each { |gem| Arb.required_gems<< gem if require gem }
		Arb.required_gems.empty? ? 'Nothing required yet!' : 'Gems successfully required: ' <<Arb.required_gems.uniq.join(',') <<'!'
	end

	#prepare the arb_* methods depend on the series of 'arb' gems to 'using' the refinement in Arb namespace quickly.
	Kernel.send :define_method, :arb_init_using do |*args, &block|
		Arb.constants.map{|const| const=~/(.*)refine$/i && ['arb_'<<$1.downcase,const] }.compact.each do |map|
			Kernel.send :define_method,map[0] do |*args,&block|
				self.class.send :using,Arb.const_get(map[1])
			end
		end
	end


	arb_require
	arb_init_using
end
