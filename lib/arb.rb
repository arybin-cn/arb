require 'arb/version.rb'

module Kernel
  def arb_import(*modules)
    imported=[]
    tmp=nil
    begin 
      loop do 
        tmp=modules.shift
        break unless tmp
        if require("arb/#{tmp.downcase}")
          imported<<tmp 
        else
          #warn("Fail to require arb/#{tmp}, maybe it had already been required!")
        end
      end
    rescue LoadError=>e
      warn("Fail to load arb/#{tmp}!")
      retry
    end
    imported
  end

  def arb_use(arb_module_name,prefix=nil,forced=false)
    prefix="#{prefix}_" if prefix && !prefix.to_s.end_with?('_')
    arb_module_name=arb_module_name.to_s.capitalize.to_sym
    res={:succeed=>[],:failed=>[]}
    tried_arb_use=false
    #always try to import
    arb_import arb_module_name
    return nil unless Arb.constants.include?(arb_module_name)
    arb_module=Module.const_get(:Arb).const_get(arb_module_name)
    Kernel.class_eval do
      arb_module.singleton_methods.each do |m|
        mm=prefix.to_s+m.to_s
        if !forced && Kernel.instance_methods.include?(mm)
          warn("Conflict method: #{mm}")
          res[:failed] << mm
          next
        end
        define_method(mm) do |*args,&block|
          arb_module.send(m,*args,&block)
        end
        res[:succeed] << mm
      end
    end
    res
    #Note that NoMethodError is subclass of NameError, which means that
    #invoking nil.xxx(that throws NoMethodError) will also lead to the
    #Name Error, we have to make sure that e is the instance of NameError!!!
  end

  alias_method :import,:arb_import
  alias_method :use,:arb_use
end
