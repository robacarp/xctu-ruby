module Debug
  def debug *args
    print *args if @debug
  end

  def debug_enable
    @debug = true
  end
end
