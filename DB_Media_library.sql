create database Media_library
go
use Media_library
/*create table Users(
id int identity primary key not null,
name nvarchar(max) not null,
login varchar(10) not null,
password varchar(32) not null,
is_admin bit not null default(0)
)*/
CREATE TABLE Genres (
id int identity primary key not null,
name varchar(60) NOT NULL
)
CREATE TABLE Singer (
id  int identity primary key not null,
name NVARCHAR(max) NOT NULL
)
CREATE TABLE Album (
id  int identity primary key not null,
name NVARCHAR(max) NOT NULL,
release_year smallint
)
CREATE TABLE Music_Tracks (
id  int identity primary key not null,
name VARCHAR(60) NOT NULL,
album_id INTEGER REFERENCES Album(id),
duration TIME not null,
likes int not null default(0)
)
CREATE TABLE My_Music (
user_id nvarchar(450) REFERENCES AspNetUsers(id),
music_tracks_id  INTEGER REFERENCES Music_Tracks(id)
)
CREATE TABLE singer_genres (
genres_id INTEGER REFERENCES Genres(id),
singer_id INTEGER REFERENCES Singer(id),
CONSTRAINT genres_singer_pkey PRIMARY KEY (genres_id, singer_id) -- связь между жанрами и исполнителями
)

CREATE TABLE album_singer (
singer_id INTEGER REFERENCES Singer(id),
album_id INTEGER REFERENCES Album(id),
CONSTRAINT pk_singer_album PRIMARY KEY (singer_id, album_id) -- связь между исполнителями и альбомами
)
/*
Для разрешения отношение многие-ко-многим между 
сущностями «USERS» и «TRACK_LIST» 
была создана таблица «SUBSCRIPTION VALIDITY»,
которая включает в себя дату начала подписки и её конец.
*/

CREATE TABLE TRACK_LIST (
id  int identity primary key not null,
name NVARCHAR(max) NOT NULL,
music_tracks_id  INTEGER REFERENCES Music_Tracks(id)
)
CREATE TABLE SUBSCRIPTION_VALIDITY(
id  int identity primary key not null,
track_list_id  INTEGER REFERENCES TRACK_LIST(id),
user_id nvarchar(450) REFERENCES AspNetUsers(id),
start_date datetime not null,
end_date datetime not null,
--CONSTRAINT pk_track_list_id_user_id PRIMARY KEY (track_list_id, user_id) 
)
