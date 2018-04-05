module Kernel
  def arb_use(*modules)
    imported=[]
    tmp=nil
    begin 
      loop do 
        tmp=modules.shift
        break unless tmp
        if require("arb/#{tmp}")
          imported<<tmp 
        else
          #warn("Fail to require arb/#{tmp}, maybe it had already been required!")
        end
      end
    rescue LoadError=>e
      warn("Fail to load arb/#{tmp}")
      retry
    end
    imported
  end

  def arb_import(arb_module_name,forced=false)
    arb_module_name=arb_module_name.to_s.capitalize!
    res={:succeed=>[],:failed=>[]}
    tried_arb_use=false
    begin
      arb_module=Module.const_get(:Arb).const_get(arb_module_name)
      Kernel.class_eval do
        arb_module.singleton_methods.each do |m|
          if !forced && Kernel.instance_methods.include?(m)
            warn("Conflict method: #{m}")
            res[:failed] << m
            next
          end
          define_method(m) do |*args,&block|
            arb_module.send(m,*args,&block)
          end
          res[:succeed] << m
        end
      end
      res
    rescue NameError=>e
      unless tried_arb_use
        tried_arb_use=true
        arb_use(arb_module_name.downcase)
        retry
      end
      warn("Arb::#{arb_module_name} not found!")
    end
  end

  alias_method :use,:arb_use
  alias_method :import,:arb_import
end
