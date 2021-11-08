  select distinct Age_of_Driver
  from Vehicles0515
  order by  Age_of_Driver asc

  select distinct Sex_of_Driver
    from Vehicles0515


select age_of_driver 
from dbo.Vehicles0515
where Age_of_Driver > 10 and Age_of_Driver < 20



update dbo.Vehicles0515
set young_adults = Age_of_Driver 
WHERE Age_of_Driver > 19 and Age_of_Driver < 30


ALTER TABLE dbo.Vehicles0515
ADD thrties INT 

update dbo.Vehicles0515
set thrties = Age_of_Driver 
WHERE Age_of_Driver > 29 and Age_of_Driver < 40



ALTER TABLE dbo.Vehicles0515
ADD fourties INT 

update dbo.Vehicles0515
set fourties = Age_of_Driver 
WHERE Age_of_Driver > 39 and Age_of_Driver < 50



ALTER TABLE dbo.Vehicles0515
ADD fifties INT 

update dbo.Vehicles0515
set fifties = Age_of_Driver 
WHERE Age_of_Driver > 49 and Age_of_Driver < 60



ALTER TABLE dbo.Vehicles0515
ADD seniors INT 

update dbo.Vehicles0515
set seniors = Age_of_Driver 
WHERE Age_of_Driver > 59
