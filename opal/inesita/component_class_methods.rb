module Inesita::ComponentClassMethods
  def mount_to(element)
    new.mount_to(element)
  end

  def inject(clazz, opts = {})
    method_name = opts[:as] || clazz.to_s.downcase
    @injections ||= {}
    @injections[method_name] = clazz
  end

  def injections
    @injections || {}
  end
end
