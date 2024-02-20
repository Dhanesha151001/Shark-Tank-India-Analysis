select * from [Shark Tank].dbo.SharkTankRecord;

-- What is the total number of episodes in this season of Shark Tank India? --30

select count(distinct[Ep# No#]) from [Shark Tank]..SharkTankRecord;

--Total number of pitches on the show? --98

select count(distinct[Brand]) from [Shark Tank]..SharkTankRecord; 

--Total number of startups that did get or did not get fundings?
select sum(a.Pitches_Converted) funding_received , count(*) total_pitches from(
select [Amount Invested lakhs] , case when [Amount Invested lakhs]>0 then 1 else 0 end as Pitches_Converted from [Shark Tank]..SharkTankRecord) a ;

--success % ratio of funding approval
select cast(sum(a.Pitches_Converted) as float)/cast(count(*)as float) from(
select [Amount Invested lakhs] , case when [Amount Invested lakhs]>0 then 1 else 0 end as Pitches_Converted from [Shark Tank]..SharkTankRecord) a ;

--total number of male participants -
select sum(male) from [Shark Tank]..SharkTankRecord;

--total number of female partcipants -
select sum(female) from [Shark Tank]..SharkTankRecord;

--gender ratio of female:male - 42%
select sum(female)/sum(male) from [Shark Tank]..SharkTankRecord;

--Total amount invested - 3422 lakhs
select sum([Amount Invested lakhs]) from [Shark Tank]..SharkTankRecord;

--average equity taken -- 16.5803
select avg(a.[Equity Taken %]) from(
select * from [Shark Tank]..SharkTankRecord where [Equity Taken %]>0) a;

--highest deal considered -- 150lakhs
select max([Amount Invested lakhs]) from [Shark Tank]..SharkTankRecord;

--highest equity taken - 75%
select max([Equity Taken %]) from [Shark Tank]..SharkTankRecord;

-- All the startup teams that had at least one woman in their team --52 pitches
select sum(a.female_count) from(
select female, case when female>0 then 1 else 0 end as female_count from [Shark Tank]..SharkTankRecord)a;

--pitches converted in success having at least one women --29

select sum(b.female_count) from(
select case when a.Female>0 then 1 else 0 end as female_count,  a. *  from(
(select * from [Shark Tank]..SharkTankRecord where deal!='No Deal')) a)b;

--avg team memebers- 2.082

select avg([Team members]) from [Shark Tank]..SharkTankRecord

--avg amount invested per deal --60.035 Lakhs
select avg(a.[Amount Invested lakhs]) amount_invested_per_deal from(
select * from [Shark Tank]..SharkTankRecord 
where deal!='No Deal') a

--most age group / avg age group - 30-35
select [Avg age], count([Avg age]) 'Avg Age Group' from [Shark Tank]..SharkTankRecord group by [Avg age] order by [Avg Age Group] desc

--most famous location from where pitchers came --Delhi followed by Mumbai
select [Location], count([Location]) 'Max Visitors from here' from [Shark Tank]..SharkTankRecord group by [Location] order by [Max Visitors from here] desc;


--most numbers of deals from which sector -- Food (32)
select [Sector], count([Sector]) 'Highest pitchers from sector' from [Shark Tank]..SharkTankRecord group by [Sector] order by [Highest pitchers from sector] desc;

--find partnership of sharks

select [Partners], count ([Partners]) 'Count of Partners' from [Shark Tank]..SharkTankRecord  where Partners!='-' group by [Partners] order by [Count of Partners] desc ;

--matrix of collaboration
select 'Ashneer' as keyy, count([Ashneer Amount Invested]) from [Shark Tank]..SharkTankRecord where [Ashneer Amount Invested] is not null

--Deals Ashneer invested in- 17 
select 'Ashneer' as keyy, count([Ashneer Amount Invested]) from [Shark Tank]..SharkTankRecord where [Ashneer Amount Invested] is not null and [Ashneer Amount Invested]!=0

select 'Ashneer'as keyy, sum(c.[Ashneer Amount Invested]) , avg(c.[Ashneer Equity Taken %])
from (Select * from [Shark Tank]..SharkTankRecord where [Ashneer Equity Taken %]!=0 and [Ashneer Equity Taken %] is not null)C



---------

select m.keyy,m.Total_Deals_Present, m.Total_Deals,n.Total_Amount_Invested,n.Avg_Equity_Taken from
(select a.keyy, a.Total_Deals_Present, b.Total_Deals from (

select 'Ashneer' as keyy, count([Ashneer Amount Invested]) Total_Deals_Present from [Shark Tank]..SharkTankRecord where [Ashneer Amount Invested] is not null) a

inner join(
select 'Ashneer' as keyy, count([Ashneer Amount Invested]) Total_Deals from [Shark Tank]..SharkTankRecord 
where [Ashneer Amount Invested] is not null and [Ashneer Amount Invested]!=0 ) b

on a.keyy=b.keyy  ) m

inner join
 
 (select 'Ashneer'as keyy, sum(c.[Ashneer Amount Invested]) Total_Amount_Invested , avg(c.[Ashneer Equity Taken %]) Avg_Equity_Taken
from (Select * from [Shark Tank]..SharkTankRecord where [Ashneer Equity Taken %]!=0 and [Ashneer Equity Taken %] is not null)C) n

on m.keyy=n.keyy


UNION ALL

SELECT 
    m.keyy,
    m.Total_Deals_Present,
    m.Total_Deals,
    n.Total_Amount_Invested,
    n.Avg_Equity_Taken 
FROM
    (
        SELECT 
            a.keyy,
            a.Total_Deals_Present,
            b.Total_Deals 
        FROM
            (
                SELECT 
                    'Anupam' AS keyy,
                    COUNT([Anupam Amount Invested]) Total_Deals_Present 
                FROM 
                    [Shark Tank]..SharkTankRecord 
                WHERE 
                    [Anupam Amount Invested] IS NOT NULL
            ) a
            INNER JOIN
            (
                SELECT 
                    'Anupam' AS keyy,
                    COUNT([Anupam Amount Invested]) Total_Deals 
                FROM 
                    [Shark Tank]..SharkTankRecord 
                WHERE 
                    [Anupam Amount Invested] IS NOT NULL 
                    AND [Anupam Amount Invested] != 0 
            ) b 
            ON a.keyy = b.keyy
    ) m
    INNER JOIN
    (
        SELECT 
            'Anupam' AS keyy,
            SUM(c.[Anupam Amount Invested]) Total_Amount_Invested,
            AVG(c.[Anupam Equity Taken %]) Avg_Equity_Taken 
        FROM 
            (
                SELECT * 
                FROM [Shark Tank]..SharkTankRecord 
                WHERE [Anupam Equity Taken %] != 0 
                    AND [Anupam Equity Taken %] IS NOT NULL
            ) c
    ) n
    ON m.keyy = n.keyy;




--which is the startup which has highest amount has highest amount invested in each domain/sector


Select c.* from(
select [Brand],[Sector], [Amount Invested lakhs], rank() over(partition by [Sector] order by [Amount Invested lakhs] desc) rnk 
from [Shark Tank]..SharkTankRecord) c 
where c.rnk=1;