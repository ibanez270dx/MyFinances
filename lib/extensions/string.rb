class String
  def paramify
    self.underscore.gsub('_','-')
  end

  def typify
    self.gsub('-','_').camelize
  end
end
