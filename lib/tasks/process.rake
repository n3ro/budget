 namespace :process do
  desc 'Runs the scrapping process. Define scrapper_debug in config/application.rb'
  task :scrapper => :environment do
    ctl = ScrapperControl.find :last
    logger = Rails.logger
    # Validate scrapper control settings
    unless ctl.esActivo
      logger.info("******   Scrapper is not active   ******")
      return
    end

    if ctl.enProceso
      logger.info("******   Scrapper is already running   ******")
      return
    end

    begin
      ctl.start_processing()
      s = Scrapper.new
      s.start Rails.configuration.scrapper_debug
    rescue Exception => ex
      puts ex.inspect
      logger.error(ex.to_s)
    ensure
      ctl.stop_processing()
    end
  end

  desc 'Runs the apuesta process'
  task :apuestas do
    puts "Running..."
  end

  desc 'Runs the wallreader process'
  task :wallreader do
    puts "Runnning..."
  end
end
