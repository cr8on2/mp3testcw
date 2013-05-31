class SongsController < ApplicationController
  def index  
  	# raise AWS::S3::Bucket.objects('mp3testcw').inspect
  	# bucket = AWS::S3::Bucket.find('mp3testcw')
  	# puts bucket.class
  	# puts bucket.inspect
  	# puts bucket.methods
  	# puts bucket.objects.class
  	# puts bucket.objects.inspect
    @songs = AWS::S3::Bucket.find('mp3testcw').objects  
    # @songs = AWS::S3::Bucket.objects(Player::BUCKET)
  end

  def upload
  	# raise params[:mp3file].inspect
  	begin
  		AWS::S3::S3Object.store(sanitize_filename(params[:mp3file].original_filename), params[:mp3file].read, BUCKET, :access => :public_read)  
  		file = params[:mp3file].original_filename
		  # AWS::S3::S3Object.store(
		  #   file,
		  #   open(file),
		  #   Player::BUCKET,
		  #   :content_type => 'audio/mp3'
		  # )
  	rescue  
        render :text => "Couldn't complete the upload"  
    end  
 end

  def delete
  	if (params[:song])  
    	AWS::S3::S3Object.find(params[:song], BUCKET).delete  
    	redirect_to root_path  
	else  
    	render :text => "No song was found to delete!"  
	end  
  end

  private  
  
	def sanitize_filename(file_name)  
    	just_filename = File.basename(file_name)  
    	just_filename.sub(/[^\w\.\-]/,'_')  
	end  
end
