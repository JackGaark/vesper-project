# Repeatable sample data for local development. Existing records are never deleted.
if Rails.env.development?
  [
    { name: 'The Lantern', address: '100 Main Street', music_genre: 'Electronic', description: 'A sample venue for planning a night out.' },
    { name: 'The Velvet Room', address: '200 Main Street', music_genre: 'Jazz', description: 'A sample venue for planning a night out.' },
    { name: 'The Atlas', address: '300 Main Street', music_genre: 'Dance', description: 'A sample venue for planning a night out.' }
  ].each do |attributes|
    venue = Venue.find_or_create_by!(name: attributes[:name]) { |record| record.assign_attributes(attributes) }
    venue.packages.find_or_create_by!(name: 'Sample package') do |package|
      package.assign_attributes(description: 'Sample package for local development', price: 90, available_per_night: 10)
    end
  end
end
