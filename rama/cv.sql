drop table if exists crossValidate;

create table crossValidate (
INC_KEY int unsigned not null primary key,
died boolean not null,
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
 key(AIS140656, AIS140202, AIS160214, AIS140684, AIS140678, AIS140666, AIS140650, AIS442202, AIS150206, AIS140690, AIS140629, AIS140210, AIS150200, AIS140648)
);

insert into crossValidate select 
INC_KEY,
died,
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
from rawData where batch>8;

alter table crossValidate add p_1 float, add p_2 float, add p_3 float, add p_4 float, add p_5 float, add p_6 float, add p_7 float, add p_8 float, add p_9 float, add p_10 float, add p_11 float, add p_12 float, add p_13 float, add p_14 float;

