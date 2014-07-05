module Variables
  extend Macro

  command dh: 'ATDH'
  command dl: 'ATDL'

  command sh: 'ATSH'
  command sl: 'ATSL'

  command network: 'ATID'
  command channel: 'ATCH'

  command power_level: 'ATPL'
  command power_mode: 'ATPM'

  command device_type: 'ATDD'
  command firmware: 'ATVR'
  command hardware: 'ATHV'


  def destination
    dh + dl
  end

  def serial
    sh + sl
  end
end
