drop table if exists Serials cascade;
create table Serials (
    s_id serial not null primary key,
    s_idProducer int not null,
	s_img text not null,
    s_name text not null,
    s_description text not null,
    s_year int not null check (s_year > 1800),
    s_genre text not null,
    s_rating float not null check (s_rating between 0 and 10),
    s_seasons int not null check (s_seasons >= 0),
    s_state text not null check (s_state = 'завершен' or s_state = 'продолжается'),
	s_duration interval not null
);
alter table Serials add foreign key (s_idProducer) references Producers(p_id);

drop table if exists Actors cascade;
create table Actors (
    a_id serial not null primary key,
    a_name text not null,
    a_surname text not null,
    a_gender text not null check (a_gender = 'мужской' or a_gender = 'женский'),
    a_bdate date not null
);

drop table if exists Producers cascade;
create table Producers (
    p_id serial not null primary key,
    p_name text not null,
    p_surname text not null
);

drop table if exists Seasons cascade;
create table Seasons (
    ss_id serial not null primary key,
    ss_idSerial int not null,
    ss_name text not null,
    ss_num int not null check (ss_num > 0),
    ss_cntEpisodes int not null check (ss_cntEpisodes > 0),
    ss_date date not null
);
alter table Seasons add foreign key (ss_idSerial) references Serials(s_id);

drop table if exists Episodes cascade;
create table Episodes (
    e_id serial not null primary key,
    e_idSeason int not null,
    e_name text not null,
    e_num int not null check (e_num > 0),
    e_duration interval not null,
    e_date date not null
);
alter table Episodes add foreign key (e_idSeason) references Seasons(ss_id);

drop table if exists Users cascade;
create table Users (
    u_id serial not null primary key,
    u_idFavourites int not null,
    u_login text not null,
    u_password text not null,
    u_role text not null check (u_role = 'user' or u_role = 'admin'),
    u_name text not null,
    u_surname text not null,
    u_gender text not null check (u_gender = 'мужской' or u_gender = 'женский'),
    u_bdate date not null
);

drop table if exists Favourites cascade;
create table Favourites (
    f_id serial not null primary key,
    f_cntSerials int not null check (f_cntSerials >= 0)
);
alter table Users add foreign key (u_idFavourites) references Favourites(f_id);

drop table if exists Comments cascade;
create table Comments (
    c_id serial not null primary key,
    c_idUser int not null,
	c_idSerial int not null,
    c_text text not null,
    c_date date not null
);
alter table Comments add foreign key (c_idUser) references Users(u_id);

drop table if exists Serials_Users cascade;
create table Serials_Users (
    su_id serial not null primary key,
    su_idSerial int not null,
    su_idUser int not null,
    su_lastSeen date not null
);
alter table Serials_Users add foreign key (su_idSerial) references Serials(s_id);
alter table Serials_Users add foreign key (su_idUser) references Users(u_id);

drop table if exists Serials_Actors cascade;
create table Serials_Actors (
    sa_id serial not null primary key,
    sa_idSerial int not null,
    sa_idActor int not null
);
alter table Serials_Actors add foreign key (sa_idSerial) references Serials(s_id);
alter table Serials_Actors add foreign key (sa_idActor) references Actors(a_id);

drop table if exists Serials_Favourites cascade;
create table Serials_Favourites (
    sf_id serial not null primary key,
    sf_idSerial int not null,
    sf_idFavourite int not null
);
alter table Serials_Favourites add foreign key (sf_idSerial) references Serials(s_id);
alter table Serials_Favourites add foreign key (sf_idFavourite) references Favourites(f_id);

ALTER DATABASE serials SET datestyle TO "ISO, DMY";
