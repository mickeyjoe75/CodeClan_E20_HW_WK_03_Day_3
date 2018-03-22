require("pry")
require_relative('./model/albums.rb')
require_relative('./model/artists.rb')

Album.delete_all()
Artist.delete_all()

artist1 = Artist.new({ 'name' => 'Santana' } )
artist1.save()

album1 = Album.new({
  'artist_id' => artist1.id,
  'title' => 'Hotel California',
  'genre' => 'metal'
})
album1.save()

puts album1
puts album1.artists
# # puts album1.artists.albums
# puts album1.artists.albums[0]
# puts album1.artists.albums[0].artists



binding.pry
nil
