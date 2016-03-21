USE MusicStore;
GO

--Shows all albums, which are available to buy now.
CREATE PROCEDURE spDistributorAlbums_noFilters
AS
BEGIN
	SELECT tblAlbum.Id, tblAlbum.NAME, tblArtist.Name, tblDistributor.Name, tblDistributorAlbums.Price, tblAlbum.LiquidRate FROM tblAlbum
	LEFT JOIN tblArtist
	ON tblArtist.Id = tblAlbum.ArtistId
	INNER JOIN tblDistributorAlbums
	ON tblDistributorAlbums.AlbumId = tblAlbum.Id
	INNER JOIN tblDistributor
	ON tblDistributorAlbums.DistributorId = tblDistributor.Id;
	--ORDER BY tblAlbum.NAME
END
GO

--Shows all albums in select genre, which are available to buy now.
CREATE PROCEDURE spDistributorAlbums_Filters
	@GenreId INT
AS
BEGIN
	SELECT tblAlbum.Id, tblAlbum.NAME, tblArtist.Name, tblGenre.Name, tblDistributor.Name, tblDistributorAlbums.Price, tblAlbum.LiquidRate FROM tblAlbum
	LEFT JOIN tblAlbumGenre
	ON tblAlbum.Id = tblAlbumGenre.AlbumId
	LEFT JOIN tblArtist
	ON tblArtist.Id = tblAlbum.ArtistId
	INNER JOIN tblGenre
	ON tblAlbumGenre.GenreID = tblGenre.Id
	INNER JOIN tblDistributorAlbums
	ON tblDistributorAlbums.AlbumId = tblAlbum.Id
	INNER JOIN tblDistributor
	ON tblDistributorAlbums.DistributorId = tblDistributor.Id
	WHERE tblGenre.Id = @GenreId
	--ORDER BY tblAlbum.NAME
END
GO

--Shows all albums in music shop storage, no filters
CREATE PROCEDURE spAlbumsInMusicStore_noFilters
AS
BEGIN
	SELECT tblAlbum.Id as id, tblAlbum.Name as albName, tblArtist.Name as artName, tblAlbumsInShopStorage.PriceRealisation as price,
	tblAlbum.RatingAllMusicCom as rateAllMusic, tblAlbumsInShopStorage.Amount as amount, tblAlbum.LiquidRate as liquidity FROM tblAlbum
	LEFT JOIN tblArtist
	ON tblArtist.Id = tblAlbum.ArtistId
	INNER JOIN tblAlbumsInShopStorage ON
	tblAlbumsInShopStorage.AlbumID = tblAlbum.Id
END
GO

--Shows all albums of selected genre in music shop storage, no filters
CREATE PROCEDURE spAlbumsInMusicStore_Filters
	@GenreId INT
AS
BEGIN
	SELECT tblAlbum.Id as id, tblAlbum.Name as albName, tblArtist.Name as artName, tblGenre.Name as genre, tblAlbumsInShopStorage.PriceRealisation as price,
	tblAlbum.RatingAllMusicCom as rateAllmusic, tblAlbum.LiquidRate as liquidity, tblAlbumsInShopStorage.Amount as amount FROM tblAlbum
	LEFT JOIN tblArtist
	ON tblArtist.Id = tblAlbum.ArtistId
	INNER JOIN tblAlbumsInShopStorage ON
	tblAlbumsInShopStorage.AlbumID = tblAlbum.Id
	LEFT JOIN tblAlbumGenre
	ON tblAlbum.Id = tblAlbumGenre.AlbumId
	INNER JOIN tblGenre
	ON tblAlbumGenre.GenreID = tblGenre.Id
	WHERE tblGenre.Id = @GenreId
END
GO


CREATE PROCEDURE spSelectAllFromGenre
AS
BEGIN
	SELECT Id, Name FROM tblGenre
END
GO

CREATE PROCEDURE spCreateCheck
	@SellerId INT,
	@TotalSum DECIMAL(19, 2)
AS
BEGIN
	INSERT INTO tblCheck (SellerId, SumOverall, DateStatement)
	VALUES (@SellerId, @TotalSum, GETDATE())
END
GO

CREATE PROCEDURE spCreateSoldItem
	@AlbumId INT,
	@Amount INT,
	@Price DECIMAL(19, 2)
AS
BEGIN
	DECLARE @CheckID INT;
	DECLARE	@CheckDate DATETIME;
	SET @CheckID = (SELECT TOP 1 Id FROM tblCheck ORDER BY Id DESC);
	SET @CheckDate = (SELECT TOP 1 DateStatement FROM tblCheck ORDER BY DateStatement DESC)
	INSERT INTO tblSoldItem (AlbumId, CheckId, SellDate, Amount, SumItems)
	VALUES (@AlbumId, @CheckID, @CheckDate, @Amount, @Price);
END
GO