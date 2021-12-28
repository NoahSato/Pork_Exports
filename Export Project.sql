CREATE DATABASE Project;
USE Project;

		-- Purpose: to determine the total weight (KG) of pork that has been exported from the USA to varying countries around the world, by year.
SELECT * 
FROM livestockmeat_exports;
		-- Original livestockmeat_exports table includes 10 total columns.
        -- SOURCE_ID, HS_CODE, COMMODITY_DESC, GEOGRAPHY_CODE, GEOGRAPHY_DESC, ATTRIBUTE_DESC, UNIT_DESC, YEAR_ID, AMOUNT.
        -- For the purpose of this project, only COMMODITY_DESC, GEOGRAPHY_DESC, UNIT_DESC, YEAR_ID and AMOUNT will be considered.

SELECT COMMODITY_DESC, GEOGRAPHY_DESC, UNIT_DESC,YEAR_ID, AMOUNT
FROM livestockmeat_exports
ORDER BY GEOGRAPHY_DESC, YEAR_ID,TIMEPERIOD_ID;
		-- This statements accquired all of the countires, type of meat, weight unit, year and amount for all countires.
        -- Countires should be tackled alphabetically to keep progress organized.
        -- There are two different types of weight units in this table (KG and CWE). Since we want the results in KG we will need to convert CWE to KG.

SELECT DISTINCT GEOGRAPHY_DESC
FROM livestockmeat_exports;
		-- This shows the list of all of the countries that the USA has exported to.
        
SELECT COUNT(DISTINCT GEOGRAPHY_DESC)
FROM livestockmeat_exports;
		-- Gives the numerical value for how many different countries the USA has exported to (105 countries).

SELECT DISTINCT GEOGRAPHY_DESC 
FROM livestockmeat_exports
ORDER BY GEOGRAPHY_DESC ASC;
		-- Here is our list of countries, alphabetised, without repettition.
        -- Lets narrow down further. 
        
SELECT COUNT(DISTINCT GEOGRAPHY_DESC)
FROM livestockmeat_exports
WHERE COMMODITY_DESC = 'Pork' AND AMOUNT>0;
		-- Here we can see that there are only 12 disparate countries that have recieved pork from the USA. 
        -- Knowing this information, it will be significantly easier to obtain the information we require.
        
SELECT DISTINCT GEOGRAPHY_DESC 
FROM livestockmeat_exports
WHERE  COMMODITY_DESC = 'Pork' AND AMOUNT>0
ORDER BY GEOGRAPHY_DESC ASC;
		-- This statement will allow us to view the entire list of countires that we need to obtain information from. 
        



		-- Stating with Afghanistan, lets determine the values that we are looking for.
SELECT COUNT(GEOGRAPHY_DESC) 
FROM livestockmeat_exports 
WHERE GEOGRAPHY_DESC = 'Afghanistan';
		-- Looks like there are 78 different entries for Afghanistan throughout the entire table.
        -- Lets narrow down the search further.

SELECT GEOGRAPHY_DESC, YEAR_ID
FROM livestockmeat_exports
ORDER BY GEOGRAPHY_DESC ASC, YEAR_ID ASC;
		-- Narrowed down to all of the entries for each country, and the corresponding year that there was an entry.
        -- Columns are alphabetized, and the year is seen in ascending order.
        -- This means that our first entry would be for Afghanistan, in the year 2004.
        -- Lets narrow down even further.

SELECT GEOGRAPHY_DESC, YEAR_ID
FROM livestockmeat_exports
WHERE COMMODITY_DESC = 'Pork' AND AMOUNT>0
ORDER BY GEOGRAPHY_DESC ASC, YEAR_ID ASC;
		-- From this statement, we can see that there are significantly less entries than the previous entry that accuired all of the countries. 
        -- This is because the search was narrowed down to countries that ONLY recieved "Pork" versus any commodity. 
        -- This will make our task easier as we do not have to obtain information from 78 disparate countries. 
SELECT  (GEOGRAPHY_DESC)
FROM livestockmeat_exports
WHERE COMMODITY_DESC = 'Pork' AND AMOUNT>0;
        
        -- We are seeking out the total amount of pork for each country, so lets start from the top.
SELECT AMOUNT, UNIT_DESC
FROM Livestockmeat_exports
WHERE GEOGRAPHY_DESC = 'Afghanistan' AND YEAR_ID = '2004' AND COMMODITY_DESC = 'Pork';
		-- This statement will accquire the AMOUNT and UNIT_DESC from the table where the location is Afghanistan, the year is 2004 and the type of meat is pork.
        -- The value reported states that the AMOUNT is equal to 2857.4105742 with the UNIT_DESC of CWE.
        -- Since CWE or carcass weight equivalent is weighed in pounds, lets convert to KG to obtain the value we desire.
SELECT AMOUNT /2.205
FROM livestockmeat_exports
WHERE GEOGRAPHY_DESC = 'Afghanistan' AND YEAR_ID = '2004' AND COMMODITY_DESC = 'Pork'; 
		-- This statement is nearly analogous as the one seen at line #48, however the AMOUNT is divided by 2.205, which is the approximate conversion from pound to KG.
		-- This will give us the value of the total pork exported to Afghanistan in the year 2004 in KG. 
        -- The value generated is 1295.8778114285715, however for the sake of simplicity, we will be reporting the value as 1295 KG.


		-- Now that we have an understanding the the process to obtain the information we are looking for, lets continue down the list.
SELECT AMOUNT, UNIT_DESC
FROM Livestockmeat_exports
WHERE GEOGRAPHY_DESC = 'Afghanistan' AND YEAR_ID = '2005' AND COMMODITY_DESC = 'Pork';
		-- This statement did not return any values despite the fact that there was an export of meat to Afghanistan in the year 2005 as seen in line #39.
		-- The same statement was used for the 2004 entry so the issue is not likely in the code.
        -- Lets try a new search to ascertain what else might be going on in this senario.
SELECT AMOUNT, UNIT_DESC
FROM livestockmeat_exports
WHERE GEOGRAPHY_DESC = 'Afghanistan' AND YEAR_ID = '2005';
		-- From this statement, we can cleary see that something has been exported into Afghanistan in the year 2005.
        -- Lets try something else to articulate further.
SELECT AMOUNT, UNIT_DESC, COMMODITY_DESC
FROM livestockmeat_exports
WHERE GEOGRAPHY_DESC = 'Afghanistan' AND YEAR_ID = '2005';
		-- This statement accounts for the "type" of meat that was exported, and we can clearly see that it was turkey.
        -- This would explain why we did not see a weight value for our previous search on line #63.
        -- We can now move forward with our searching for the following year.

        
        
SELECT AMOUNT, UNIT_DESC
FROM Livestockmeat_exports
WHERE GEOGRAPHY_DESC = 'Afghanistan' AND YEAR_ID = '2006' AND COMMODITY_DESC = 'Pork';
		-- This statement provides us with more information than previous statements.
        -- There are multiple values for both KG and CWE.
        -- This is likely due to the fact that the livestockmeat_exports table includes multiple separate months for each year.
        -- For our purposes, we are only seeking out the total amount for the entire year, therefore we can simply add the values together.
SELECT SUM(AMOUNT) /2.205
FROM Livestockmeat_exports
WHERE GEOGRAPHY_DESC = 'Afghanistan' AND YEAR_ID = '2006' AND COMMODITY_DESC = 'Pork' AND UNIT_DESC = 'CWE';
		-- Since there were separate entrys for both KG and CWE we will need to obtain them separately, and then add them for the yearly total.
        -- We can not forget that when we obtain the total CWE amount, we will need to apply the conversion calculation as well. 
        -- This will give us a value of 16456 KG
SELECT SUM(AMOUNT)
FROM Livestockmeat_exports
WHERE GEOGRAPHY_DESC = 'Afghanistan' AND YEAR_ID = '2006' AND COMMODITY_DESC = 'Pork' AND UNIT_DESC = 'KG';
		-- This statement is largely the same, except for the fact that we have removed the conversion calculation, and adjusted the UNIT_DESC to KG. 
        -- This will provide us with the total amount of pork exported to Afghanistan in 2006 in KG. 
        

		-- Keeping all of these senarios in mind, it should be straightforward to obtain the remainder of the information we desire. 
        -- We will pre-type statements that we can then simply adjust the year, and add the conversion to accquire our information we need. 
SELECT AMOUNT, UNIT_DESC
FROM Livestockmeat_exports
WHERE GEOGRAPHY_DESC = 'Afghanistan' AND YEAR_ID = '2004' AND COMMODITY_DESC = 'Pork';


SELECT SUM(AMOUNT) /2.205
FROM Livestockmeat_exports
WHERE GEOGRAPHY_DESC = 'Afghanistan' AND YEAR_ID = '2004' AND COMMODITY_DESC = 'Pork' AND UNIT_DESC = 'CWE';


SELECT SUM(AMOUNT)
FROM Livestockmeat_exports
WHERE GEOGRAPHY_DESC = 'Afghanistan' AND YEAR_ID = '2004' AND COMMODITY_DESC = 'Pork' AND UNIT_DESC = 'KG';



		-- Lets try something diffferent to ascertain if we can make our task easier. 
        -- Lets try writing new code to speed of the process of obtaining the total amount for each year. 
SELECT GEOGRAPHY_DESC, YEAR_ID, AMOUNT / 2.205, UNIT_DESC
FROM livestockmeat_exports
WHERE GEOGRAPHY_DESC = 'Bahrain' AND COMMODITY_DESC = 'Pork' AND UNIT_DESC = 'CWE' AND YEAR_ID = '2007';
		-- This statement provides us with all of the entries made in 2005 in KG. 
        -- Despite the fact that the statement accquires UNIT_DESC in CWE or pounds, the conversion calculation converts the values to KG. 
        -- This is valuable, but lets see if we can simplify the process further.

SELECT  SUM(AMOUNT) / 2.205
FROM livestockmeat_exports
WHERE GEOGRAPHY_DESC = 'Bahrain' AND COMMODITY_DESC = 'Pork' AND UNIT_DESC = 'CWE' AND YEAR_ID = '2006';
		-- This statement added the values from the previous statement together to give us the total amount of pork for 2005 in KG. 
        -- This value can be saved and used to generate the graph later on. 
        -- The statements on line #172 and line #179 will be used for obtaining all of the information needed for Bahrain. 
        -- The only information we will need to edit is the year.  

SELECT SUM(AMOUNT)
FROM livestockmeat_exports
WHERE GEOGRAPHY_DESC = 'Bahrain' AND COMMODITY_DESC = 'Pork' AND UNIT_DESC = 'KG' AND YEAR_ID = '2021';
		-- In this statement, the conversion calculation has been omitted. 
        -- The UNIT_DESC has been changed to "KG" to account for the values being reported in KG instead of pounds. 
        -- This statement will be used to accquire the total amount of pork in KG for each year.
        
        -- Lets try another process in order to obtain the information we desire.  
SELECT YEAR_ID, SUM(AMOUNT) / 2.205
FROM livestockmeat_exports
WHERE GEOGRAPHY_DESC = 'Thailand' AND COMMODITY_DESC = 'Pork' AND UNIT_DESC = 'CWE' AND YEAR_ID>= 2004
GROUP BY YEAR_ID;
		-- In this statement, we can easily obtain the total amount of pork exported for years greater than or equal to 2004. 
		-- This statement is an easy way to visualize the information we desire. 
        -- The only portion of the statement we need to change is the UNIT_DESC and the conversion calculation for all of the years. 
        








        


















































  
  

  






















