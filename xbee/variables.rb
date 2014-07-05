module Variables
  extend Macro

  command dh: 'ATDH', set: true
  command dl: 'ATDL', set: true

  command sh: 'ATSH'
  command sl: 'ATSL'

  command network: 'ATID', set: true
  command channel: 'ATCH', set: true

  command power_level: 'ATPL'
  command power_mode: 'ATPM', set: true
  command voltage: 'AT%V'

  command device_type: 'ATDD'
  command firmware: 'ATVR'
  command hardware: 'ATHV'
  command id: 'ATMY'

  command sample_rate: 'ATIR', set: true
  command sample_size: 'ATIT', set: true
  command remote_output_from: 'ATIA', set: true

  def destination
    dh + dl
  end

  def serial
    sh + sl
  end
end
