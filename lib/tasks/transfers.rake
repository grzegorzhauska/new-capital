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
end
