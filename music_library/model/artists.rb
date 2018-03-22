require( 'pg' )
require_relative('../db/sql_runner')
require_relative('albums')

class Artist

  attr_reader :id, :name

  def initialize(  options )
    @id = options['id'].to_i
    @name = options['name']
  end

  def save()
    sql = "INSERT INTO artists ( name ) VALUES ( $1 )
    RETURNING id"
    values = [@name]
    artists = SqlRunner.run( sql, values )
    @id = artists[0]['id'].to_i
  end

  def self.delete_all()
    sql = "DELETE FROM artists"
    artists = SqlRunner.run( sql )
  end

  def self.all()
    sql = "SELECT * FROM artists;"
    artists = SqlRunner.run( sql )
    return artists.map { |artist| Artist.new( artist ) }
  end

  def albums()
    sql = "SELECT * FROM albums
    WHERE album_id = $1"
    values = [@id]
    results = SqlRunner.run(sql,values)
    titles = results.map { |title| Album.new(title) }
    return titles
  end


end
