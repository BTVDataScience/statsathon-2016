update pValues set p_1 = (select sum(died) / count(*) from rawData where batch < 9 and pValues.AIS140656 = rawData.AIS140656);

update pValues set p_2 = (select sum(died) / count(*) from rawData where batch < 9 and pValues.AIS140656 = rawData.AIS140656 and pValues.AIS140202 = rawData.AIS140202);

update pValues set p_3 = (select sum(died) / count(*) from rawData where batch < 9 and pValues.AIS140656 = rawData.AIS140656 and pValues.AIS140202 = rawData.AIS140202 and pValues.AIS160214 = rawData.AIS160214);

update pValues set p_4 = (select sum(died) / count(*) from rawData where batch < 9 and pValues.AIS140656 = rawData.AIS140656 and pValues.AIS140202 = rawData.AIS140202 and pValues.AIS160214 = rawData.AIS160214 and pValues.AIS140684 = rawData.AIS140684);

update pValues set p_5 = (select sum(died) / count(*) from rawData where batch < 9 and pValues.AIS140656 = rawData.AIS140656 and pValues.AIS140202 = rawData.AIS140202 and pValues.AIS160214 = rawData.AIS160214 and pValues.AIS140684 = rawData.AIS140684 and pValues.AIS140678 = rawData.AIS140678);

update pValues set p_6 = (select sum(died) / count(*) from rawData where batch < 9 and pValues.AIS140656 = rawData.AIS140656 and pValues.AIS140202 = rawData.AIS140202 and pValues.AIS160214 = rawData.AIS160214 and pValues.AIS140684 = rawData.AIS140684 and pValues.AIS140678 = rawData.AIS140678 and pValues.AIS140666 = rawData.AIS140666);

update pValues set p_7 = (select sum(died) / count(*) from rawData where batch < 9 and pValues.AIS140656 = rawData.AIS140656 and pValues.AIS140202 = rawData.AIS140202 and pValues.AIS160214 = rawData.AIS160214 and pValues.AIS140684 = rawData.AIS140684 and pValues.AIS140678 = rawData.AIS140678 and pValues.AIS140666 = rawData.AIS140666 and pValues.AIS140650 = rawData.AIS140650);

update pValues set p_8 = (select sum(died) / count(*) from rawData where batch < 9 and pValues.AIS140656 = rawData.AIS140656 and pValues.AIS140202 = rawData.AIS140202 and pValues.AIS160214 = rawData.AIS160214 and pValues.AIS140684 = rawData.AIS140684 and pValues.AIS140678 = rawData.AIS140678 and pValues.AIS140666 = rawData.AIS140666 and pValues.AIS140650 = rawData.AIS140650 and pValues.AIS442202 = rawData.AIS442202);

update pValues set p_9 = (select sum(died) / count(*) from rawData where batch < 9 and pValues.AIS140656 = rawData.AIS140656 and pValues.AIS140202 = rawData.AIS140202 and pValues.AIS160214 = rawData.AIS160214 and pValues.AIS140684 = rawData.AIS140684 and pValues.AIS140678 = rawData.AIS140678 and pValues.AIS140666 = rawData.AIS140666 and pValues.AIS140650 = rawData.AIS140650 and pValues.AIS442202 = rawData.AIS442202 and pValues.AIS150206 = rawData.AIS150206);

update pValues set p_10 = (select sum(died) / count(*) from rawData where batch < 9 and pValues.AIS140656 = rawData.AIS140656 and pValues.AIS140202 = rawData.AIS140202 and pValues.AIS160214 = rawData.AIS160214 and pValues.AIS140684 = rawData.AIS140684 and pValues.AIS140678 = rawData.AIS140678 and pValues.AIS140666 = rawData.AIS140666 and pValues.AIS140650 = rawData.AIS140650 and pValues.AIS442202 = rawData.AIS442202 and pValues.AIS150206 = rawData.AIS150206 and pValues.AIS140690 = rawData.AIS140690);

update pValues set p_11 = (select sum(died) / count(*) from rawData where batch < 9 and pValues.AIS140656 = rawData.AIS140656 and pValues.AIS140202 = rawData.AIS140202 and pValues.AIS160214 = rawData.AIS160214 and pValues.AIS140684 = rawData.AIS140684 and pValues.AIS140678 = rawData.AIS140678 and pValues.AIS140666 = rawData.AIS140666 and pValues.AIS140650 = rawData.AIS140650 and pValues.AIS442202 = rawData.AIS442202 and pValues.AIS150206 = rawData.AIS150206 and pValues.AIS140690 = rawData.AIS140690 and pValues.AIS140629 = rawData.AIS140629);

update pValues set p_12 = (select sum(died) / count(*) from rawData where batch < 9 and pValues.AIS140656 = rawData.AIS140656 and pValues.AIS140202 = rawData.AIS140202 and pValues.AIS160214 = rawData.AIS160214 and pValues.AIS140684 = rawData.AIS140684 and pValues.AIS140678 = rawData.AIS140678 and pValues.AIS140666 = rawData.AIS140666 and pValues.AIS140650 = rawData.AIS140650 and pValues.AIS442202 = rawData.AIS442202 and pValues.AIS150206 = rawData.AIS150206 and pValues.AIS140690 = rawData.AIS140690 and pValues.AIS140629 = rawData.AIS140629 and pValues.AIS140210 = rawData.AIS140210);

update pValues set p_13 = (select sum(died) / count(*) from rawData where batch < 9 and pValues.AIS140656 = rawData.AIS140656 and pValues.AIS140202 = rawData.AIS140202 and pValues.AIS160214 = rawData.AIS160214 and pValues.AIS140684 = rawData.AIS140684 and pValues.AIS140678 = rawData.AIS140678 and pValues.AIS140666 = rawData.AIS140666 and pValues.AIS140650 = rawData.AIS140650 and pValues.AIS442202 = rawData.AIS442202 and pValues.AIS150206 = rawData.AIS150206 and pValues.AIS140690 = rawData.AIS140690 and pValues.AIS140629 = rawData.AIS140629 and pValues.AIS140210 = rawData.AIS140210 and pValues.AIS150200 = rawData.AIS150200);

update pValues set p_14 = (select sum(died) / count(*) from rawData where batch < 9 and pValues.AIS140656 = rawData.AIS140656 and pValues.AIS140202 = rawData.AIS140202 and pValues.AIS160214 = rawData.AIS160214 and pValues.AIS140684 = rawData.AIS140684 and pValues.AIS140678 = rawData.AIS140678 and pValues.AIS140666 = rawData.AIS140666 and pValues.AIS140650 = rawData.AIS140650 and pValues.AIS442202 = rawData.AIS442202 and pValues.AIS150206 = rawData.AIS150206 and pValues.AIS140690 = rawData.AIS140690 and pValues.AIS140629 = rawData.AIS140629 and pValues.AIS140210 = rawData.AIS140210 and pValues.AIS150200 = rawData.AIS150200 and pValues.AIS140648 = rawData.AIS140648);

