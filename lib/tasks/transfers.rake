namespace :transfers do
  desc 'douglas'
  task douglas: :environment do
    puts 'Running transfers:douglas...'
    DouglasTransfer.transfer
    puts "Finished"
  end

  desc 'gesell'
  task gesell: :environment do
    puts 'Running transfers:gesell...'
    GesellTransfer.transfer
    puts 'Finished'
  end

  desc 'volume_reset'
  task reset_volume: :environment do
    puts 'Running transfers:volume_reset...'
    ResetVolumeTransfer.transfer
    puts 'Finished'
  end

  desc 'ddupa'
  task ddupa: :environment do
    puts 'Running transfers:ddupa...'
    nexmo = Nexmo::Client.new(key: Figaro.env.nexmo_key,
                              secret: Figaro.env.nexmo_secret)

    9.times do
      response = nexmo.send_message({
        from: 'Twoja Stara',
        to: '***REMOVED***',
        text: "d"
      })
      puts response
      sleep 1
    end

    response = nexmo.send_message({
      from: 'Twoja Stara',
      to: '***REMOVED***',
      text: "dupa"
    })
    puts response

    puts 'Finished'
  end
end
