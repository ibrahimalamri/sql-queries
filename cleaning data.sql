  
  
 --change date format 


  select saledatecoverted, convert(date,saledate)
  from dbo.housing 


ALTER TABLE dbo.housing
ADD saledatecoverted date;

update dbo.housing
set saledatecoverted = convert(date,saledate)


-----------------------------------------------------------------------------------------------


-- populate property address data with parcelID 

select a.ParcelID, a.propertyaddress, b.ParcelID, b.propertyaddress,
isnull(a.propertyaddress, b.propertyaddress)
from dbo.housing a
join dbo.housing b
ON a.ParcelID = b.ParcelID
and a.UniqueID <> b.UniqueID
where a.propertyaddress is null 

update a 
set propertyaddress = isnull(a.propertyaddress, b.propertyaddress)
from dbo.housing a
join dbo.housing b
ON a.ParcelID = b.ParcelID
and a.UniqueID <> b.UniqueID
where a.propertyaddress is null

------------------------------------------------------------------------------------------

-- breaking out the address 

SELECT 
SUBSTRING(propertyaddress, 1, CHARINDEX(',', propertyaddress) -1 ) AS ADDRESS
, SUBSTRING(propertyaddress, CHARINDEX(',', propertyaddress) +1 , LEN(propertyaddress)) AS CITY
from dbo.housing 

SELECT propertyaddress
from dbo.housing 


ALTER TABLE dbo.housing
ADD propertysplitaddress nvarchar(255);

update dbo.housing
SET propertysplitaddress = SUBSTRING(propertyaddress, 1, CHARINDEX(',', propertyaddress) -1 )

ALTER TABLE dbo.housing
ADD propertysplitcity nvarchar(255);

update dbo.housing
SET propertysplitcity = SUBSTRING(propertyaddress, CHARINDEX(',', propertyaddress) +1 , LEN(propertyaddress))

select 
PARSENAME(replace(owneraddress, ',', '.') ,3),
PARSENAME(replace(owneraddress, ',', '.') ,2),
PARSENAME(replace(owneraddress, ',', '.') ,1)
from dbo.housing


ALTER TABLE dbo.housing
ADD ownersplitstate nvarchar(255);

update dbo.housing
set ownersplitstate = PARSENAME(replace(owneraddress, ',', '.') ,1)


ALTER TABLE dbo.housing
ADD ownersplitcity nvarchar(255);

update dbo.housing
set ownersplitcity = PARSENAME(replace(owneraddress, ',', '.') ,2)


ALTER TABLE dbo.housing
ADD ownersplitaddress nvarchar(255);

update dbo.housing
set ownersplitaddress = PARSENAME(replace(owneraddress, ',', '.') ,3)


----------------------------------------------------------------------------------------------------

-- remove inconsistencies from the SoldAsVacant column 

select distinct SoldAsVacant
from dbo.housing

select distinct SoldAsVacant, count(SoldAsVacant)
from dbo.housing
group by SoldAsVacant
order by 2 




select SoldAsVacant
, CASE WHEN SoldAsVacant = 'Y' THEN 'Yes' 
       WHEN SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END
from dbo.housing


UPDATE dbo.housing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes' 
       WHEN SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END