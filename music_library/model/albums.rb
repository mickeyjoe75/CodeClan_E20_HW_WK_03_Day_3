require('pg')
require_relative('artists')
require_relative('../db/sql_runner')
class Album

  attr_reader :title, :genre, :artist_id

  def initialize(options)
    @title = options['title']
    @genre = options['genre']
    @id = options['id'].to_i if options['id']
    @artist_id = options['artist_id'].to_i
  end

  def save()
    sql = "INSERT INTO albums
    (
      title,
      genre,
      artist_id
    )
    VALUES
    (
      $1, $2, $3
    )
    RETURNING id"
    values = [@title, @genre, @artist_id]
  albums = SqlRunner.run( sql, values)
  end

  def update()
    sql = "
    UPDATE albums SET (
      title,
      genre,
    )
    (
      $1,$2
    )
    WHERE id = $3"
    values = [@title, @genre, @id]
    albums = SqlRunner.run( sql, values)
  end

  def delete()
    sql = "DELETE FROM albums where id = $1"
    values = [@id]
    albums = SqlRunner.run( sql, values)
  end

  def self.find(id)
    sql = "SELECT * FROM albums WHERE id = $1"
    values = [id]
    albums = SqlRunner.run( sql, values)
    album_hash = results.first
    album = Album.new(album_hash)
    return album
  end

  def self.delete_all()
    sql = "DELETE FROM albums"
    albums = SqlRunner.run( sql )
  end

  def self.all()
    sql = "SELECT * FROM albums"
    albums = SqlRunner.run( sql, values)
    return albums.map { |album| Album.new(album) }
  end

  def artists()
    sql = "SELECT * FROM artists
    WHERE id = $1"
    values = [@artist_id]
    results = SqlRunner.run(sql,values)
    artist_info = results[0]
    artists = Artist.new( artist_info )
    return artists
  end
end
