require 'rest-client'
require 'json'

class Api::RecordsController < ApplicationController
	respond_to :json

	def index
		respond_with Record.all 
	end
	def show
	    record = Record.find(params[:id])
    	respond_with record
	end
	def filter_stop_words(record)
		stopwords = ['like', 'ha', 'ha', 'wow', 'okay', 'Ok', 'OK', 'ok', 'So', 'so', 'actually', 'basically', 'right', 'well', 'Well', 'Seriously', 'seriously', 'literally', 'totally', 'just']
	    filter = Stopwords::Filter.new stopwords

	    filtered_text = filter.filter record.transcription.split
	    record.transcription = filtered_text.join(" ")
	end
	def update 
		record = Record.find(params[:record_id])

	    if record.update(record_params)
	    	filter_stop_words(record)
	    	punctuated_text = RestClient.post("http://bark.phon.ioc.ee/punctuator", "text=#{record.transcription}", headers={})
	    	record.transcription = punctuated_text
	      render json: record, status: 200, location: [:api, record]
	    else
	      render json: { errors: user.errors }, status: 422
	    end
	end
	def create
	    record = Record.new(record_params)
	    if record.save
	      	render json: record, status: 201, location: [:api, record]
	    else
	      	render json: { errors: record.errors }, status: 422
	    end
	end
	def destroy
		record = Record.find(params[:id])
	  	record.destroy
	  	head 204
	end
	
	private
    def record_params
      	params.except(:format).permit(:title, :transcription, :summary, :user_id)
    end
end