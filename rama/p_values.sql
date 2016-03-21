drop table if exists pValues;

create table pValues (
AIS140656 boolean not null,
AIS140202 boolean not null,
AIS160214 boolean not null,
AIS140684 boolean not null,
AIS140678 boolean not null,
AIS140666 boolean not null,
AIS140650 boolean not null,
AIS442202 boolean not null,
AIS150206 boolean not null,
AIS140690 boolean not null,
AIS140629 boolean not null,
AIS140210 boolean not null,
AIS150200 boolean not null,
AIS140648 boolean not null,
p_1 float,
p_2 float,
p_3 float,
p_4 float,
p_5 float,
p_6 float,
p_7 float,
p_8 float,
p_9 float,
p_10 float,
p_11 float,
p_12 float,
p_13 float,
p_14 float,
primary key(AIS140656, AIS140202, AIS160214, AIS140684, AIS140678, AIS140666, AIS140650, AIS442202, AIS150206, AIS140690, AIS140629, AIS140210, AIS150200, AIS140648)
);

insert into pValues(AIS140656, AIS140202, AIS160214, AIS140684, AIS140678, AIS140666, AIS140650, AIS442202, AIS150206, AIS140690, AIS140629, AIS140210, AIS150200, AIS140648)

select distinct 
AIS140656,
AIS140202,
AIS160214,
AIS140684,
AIS140678,
AIS140666,
AIS140650,
AIS442202,
AIS150206,
AIS140690,
AIS140629,
AIS140210,
AIS150200,
AIS140648
from rawData where batch < 9;
