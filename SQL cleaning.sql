use SQLTUT;
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [S#]
      ,[Date]
      ,[Islamic Date]
      ,[Blast Day Type]
      ,[Holiday Type]
      ,[Time]
      ,[City]
      ,[Latitude]
      ,[Longitude]
      ,[Province]
      ,[Location]
      ,[Location Category]
      ,[Location Sensitivity]
      ,[Open/Closed Space]
      ,[Influencing Event/Event]
      ,[Target Type]
      ,[Targeted Sect if any]
      ,[Killed Min]
      ,[Killed Max]
      ,[Injured Min]
      ,[Injured Max]
      ,[No# of Suicide Blasts]
      ,[Explosive Weight (max)]
      ,[Hospital Names]
      ,[Temperature(C)]
      ,[Temperature(F)]
  FROM [SQLTUT].[dbo].[pakistan_stats]




  ----------------------------------- remove inconsistencies from city -----------------------------------



  select * 
  from pakistan_stats

    alter table pakistan_stats
  add cleanedcity nvarchar(255);

  update pakistan_stats
  set cleanedcity = replace
  (replace
  (replace
  (replace
  (replace(city, 'Kuram Agency', 'kurram agency'), 'Mosal Kor, Mohmand Agency', 'Mohmand Agency'), 
  'D. I Khan', 'D.I Khan'), 'ghallanai, mohmand agency', 'mohmand agency'), 
   'tangi, charsadda district', 'charsadda district')


  update pakistan_stats
set Province = replace(Province, 'Baluchistan', 'Balochistan')

select distinct Province
from pakistan_stats


------------------------------------ remove unnecessary spaces ------------------------------------



Select CleanedCity from pakistan_stats
where CleanedCity like '% '
or CleanedCity like ' %'

select trim(CleanedCity)
from pakistan_stats

update pakistan_stats
set CleanedCity = trim(CleanedCity)

Select Province from pakistan_stats
where Province like '% '
or Province like ' %'

------------------------------------------------------------------------------------------------------------------------------------------------


update pakistan_stats
set CleanedCity = lower(CleanedCity)

select cleanedcity from pakistan_stats

update pakistan_stats
set Province = lower(Province)


---------------------------------- fix inconsistencies from Holiday Type ---------------------------------- 





update pakistan_stats
set [Holiday Type] = 
replace
  (replace
  (replace
  (replace([Holiday Type], 'Ashura Holiday', 'Ashura')
  , 'Christmas/ birthday of Quaid-e-Azam', 'Christmas'), 
  'Christmas/birthday of Quaid-e-Azam', 'Christmas')
  , 'Eid ul Azha Holiday', 'Eid-ul-azha')

  select distinct [Holiday Type]
  from pakistan_stats

------------------------------------------- standardizing date ------------------------------------------- 

    update pakistan_stats
  set Date =  
replace
  (replace
  (replace
  (replace
  (replace
  (replace
  (replace
  (replace
  (replace
  (replace
  (replace
  (replace(date, 'january', 1), 'February', 2), 'March', 3), 'april', 4), 'may', 5), 'june', 6), 'july', 7)
  , 'August', 8), 'September', 9), 'october', 10), 'November', 11), 'December', 12)

  select date 
  from pakistan_stats


  select substring("DATE", CHARINDEX('-', "DATE"), 255)
  from pakistan_stats



  UPDATE pakistan_stats 
SET DATE = 
substring("DATE", CHARINDEX('-', "DATE"), 255)
from pakistan_stats


select substring("date", 2, 50)
from pakistan_stats

update pakistan_stats
set date = substring("date", 2, 255)

select date 
from pakistan_stats

select ltrim(date)
from pakistan_stats

update pakistan_stats
set date = ltrim(date)

select replace("date", ' ', '-')
from pakistan_stats

update pakistan_stats 
set date = replace("date", ' ', '-')

select date 
from pakistan_stats

select replace("date", '-', '/')
from pakistan_stats

update pakistan_stats
set date = replace("date", '-', '/')

select date 
from pakistan_stats

select * from pakistan_stats