module Macro

  def command opts
    params = {
      expect: nil,
      pre_sleep: 0,
      sleep: 0,
      enter: true
    }

    names = opts.keys - params.keys

    if names.length > 1
      commands = names.map {|k| "\"#{k}\": #{opts[k]}" }.join(', ')
      raise "ambiguous command declaration: #{commands}"
    end

    name = names.first
    command = opts[name]

    params.merge! opts

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
end
