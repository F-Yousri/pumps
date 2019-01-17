Dir["#{Rails.root}/app/models/phasetwo/tables/*.rb"].each {|file| require file }
Dir["#{Rails.root}/app/models/phasethree/tables/*.rb"].each {|file| require file }