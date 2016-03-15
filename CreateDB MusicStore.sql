--CREATE DATABASE MusicStore;

USE MusicStore;

CREATE TABLE tblArtist
(
Id INT NOT NULL IDENTITY (1, 1),
Name NVARCHAR(50) NOT NULL,
DESCRIPTION NVARCHAR NULL
CONSTRAINT PK_tblArtist_ID PRIMARY KEY (Id)
);

CREATE TABLE tblAlbum
(
Id INT NOT NULL IDENTITY (1, 1),
ArtistId INT NULL,
NAME NVARCHAR(50) NOT NULL,
YearPublication DATETIME NULL,
RatingAllMusicCom INT NULL,
LiquidRate FLOAT NULL
CONSTRAINT PK_tblAlbum_ID PRIMARY KEY (Id)
CONSTRAINT FK_tblAlbum_tblArtist FOREIGN KEY (ArtistId)
REFERENCES tblArtist(Id)
);

CREATE TABLE tblGerne
(
Id INT NOT NULL IDENTITY (1, 1),
Name NVARCHAR(50) NOT NULL,
Description NVARCHAR NULL
CONSTRAINT PK_tblGerne_ID PRIMARY KEY(Id)
);

CREATE TABLE tblAlbumGerne
(
Id INT NOT NULL IDENTITY (1, 1),
AlbumId INT NOT NULL,
GerneID INT NOT NULL
CONSTRAINT PK_tblAlbumGerne_ID PRIMARY KEY (Id)
CONSTRAINT FK_tblAlbumGerne_tblAlbum FOREIGN KEY (AlbumID)
REFERENCES tblAlbum(Id),
CONSTRAINT FK_tblAlbumGerne_tblGerne FOREIGN KEY (GerneID)
REFERENCES tblGerne(Id)
); 

CREATE TABLE tblMusicShop
(
Id INT NOT NULL IDENTITY (1, 1),
Name NVARCHAR(50) NOT NULL,
ShopOwner NVARCHAR(50) NOT NULL,
Balance FLOAT NOT NULL
CONSTRAINT PK_tblMusicShop_ID PRIMARY KEY (Id)
);

CREATE TABLE tblSeller
(
Id INT NOT NULL IDENTITY (1, 1),
ShopId INT NOT NULL,
Name NVARCHAR(50) NOT NULL,
Surname NVARCHAR(50) NOT NULL,
PassportID NVARCHAR(50) NOT NULL,
Birthday DATETIME NULL,
Rating INT NULL
CONSTRAINT PK_tblSeller_ID PRIMARY KEY (Id)
CONSTRAINT FK_tblSeller_tblMusicShop FOREIGN KEY (ShopID)
REFERENCES tblMusicShop(Id)
);

CREATE TABLE tblSoldItem
(
Id INT NOT NULL IDENTITY (1, 1),
AlbumId INT NOT NULL,
SellerId INT NOT NULL,
SellDate DATETIME NOT NULL
CONSTRAINT PK_tblSoldItem_ID PRIMARY KEY (Id)
CONSTRAINT FK_tblSoldItem_tblSeller FOREIGN KEY (SellerID)
REFERENCES tblSeller(Id),
CONSTRAINT FK_tblSoldItem_tblAlbum FOREIGN KEY (AlbumID)
REFERENCES tblAlbum(Id)
);

CREATE TABLE tblDistributor
(
Id INT NOT NULL IDENTITY (1, 1),
Name NVARCHAR(50) NOT NULL,
Rating INT NULL
CONSTRAINT PK_tblDistributor_ID PRIMARY KEY (Id)
);

CREATE TABLE tblShopDistributor
(
Id INT NOT NULL IDENTITY (1, 1),
DistributorId INT NOT NULL,
MusicShopId INT NOT NULL
CONSTRAINT PK_tblShopDistributor_ID PRIMARY KEY (Id)
CONSTRAINT FK_tblShopDistributor_tblDistributor FOREIGN KEY (DistributorId)
REFERENCES tblDistributor(Id),
CONSTRAINT FK_tblShopDistributor_tblMusicStore FOREIGN KEY (MusicShopID)
REFERENCES tblMusicShop(Id)
);

CREATE TABLE tblDistributorGoods
(
Id INT NOT NULL IDENTITY (1, 1),
DistributorId INT NOT NULL,
AlbumId INT NOT NULL,
Price FLOAT NOT NULL
CONSTRAINT PK_tblDistributorGoods_ID PRIMARY KEY (Id)
CONSTRAINT FK_tblDistributorGoods_tblAlbum FOREIGN KEY (AlbumId)
REFERENCES tblAlbum(Id),
CONSTRAINT FK_tblDistributorGoods_tblDistributor FOREIGN KEY (DistributorID)
REFERENCES tblDistributor(Id)
);

CREATE TABLE tblStorage
(
Id INT NOT NULL IDENTITY (1, 1)
CONSTRAINT PK_tblStorage_ID PRIMARY KEY (Id)
);

CREATE TABLE tblGoodsInStorage
(
Id INT NOT NULL IDENTITY (1, 1),
DistributorGoodsID INT NOT NULL,
StorageID INT NOT NULL
CONSTRAINT PK_tblGoodsInStorage_ID PRIMARY KEY (Id)
CONSTRAINT FK_tblGoodsInStorage_tblDistributorGoods FOREIGN KEY (DistributorGoodsID)
REFERENCES tblDistributorGoods(Id),
CONSTRAINT FK_tblGoodsInStorage_tblStorage FOREIGN KEY (StorageID)
REFERENCES tblStorage(Id)
);