-- answer for a)
create table songs(
	songid number(9) primary key,
	title varchar(20),
	release date
);

create table singers(
	singerid number(9) primary key,
	name varchar(20),
	city varchar(20),
	state varchar(20)
);

create table singsin(
	singerid number(9),
	songid number(9),
	primary key(singerid, songid),
	foreign key (singerid) references singers,
	foreign key (songid) references songs
);

-- answer for b)

select name from singers where state='MA' order by name desc;

-- answer for c)
select singers.name, songs.title, songs.release from singers, songs, singsin
where singers.singerid=singsin.singerid and songs.songid=singsin.songid;

-- answer for d)
select count(singerid) from singers where state like 'MA' and city like 'Boston';

-- answer for e)
select * from singers where name like 'A%' order by state;

-- answer for f)
select singers.name, singers.city, singers.state from singers, songs, singsin
where singers.singerid=singsin.singerid and songs.songid=singsin.songid
and lower(songs.title) like '%joy%';

-- answer for g)
select singers.name, singers.city, singers.state from singers, songs, singsin
where singers.singerid=singsin.singerid and songs.songid=singsin.songid and 
songs.release<TO_DATE('09/01/2021','mm,dd,yyyy');

-- answer for h)
select singers.name, singers.state from singers, songs, singsin
where singers.singerid=singsin.singerid and songs.songid=singsin.songid
and songs.release>=TO_DATE('01/01/2020','mm/dd/yyyy') and
songs.release<=TO_DATE('12/31/2020','mm/dd/yyyy');






