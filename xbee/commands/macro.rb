module Macro

  def command opts
    params = {
      expect: nil,
      pre_sleep: 0,
      sleep: 0,
      enter: true,
      set: false
    }

    names = opts.keys - params.keys

    if names.length > 1
      commands = names.map {|k| "\"#{k}\": #{opts[k]}" }.join(', ')
      raise "ambiguous command declaration: #{commands}"
    end

    name = names.first
    command = opts[name]

    params.merge! opts
    params.delete name

    getter name, command, params
    setter name, command, params if params[:set]

    true
  end

  private

  def getter name, command, params
    define_method name do
      sleep params[:pre_sleep] if params[:pre_sleep]

      send command, params[:enter]

      sleep params[:sleep] if params[:sleep]

      if params[:expect]
        value = expect params[:expect]
      else
        value = get
      end

      value
    end
  end

  def setter name, command, params
    name = name.to_s + '='

    define_method name do |value|

      send "#{command} #{value}"

      expect 'OK'
    end
  end
end
