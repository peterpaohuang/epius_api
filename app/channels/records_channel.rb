class RecordsChannel < ApplicationCable::Channel  
  def subscribed
    stream_from 'records'
  end

  def unsubscribed
  end

  def receive(data)
  	#record = Record.find(params[:id])
  	print(data)
  	#record.update!(transcription: data["transcription"])
  	#ActionCable.server.broadcast('record')	
  end
end  