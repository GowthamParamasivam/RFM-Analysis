
create view SALES_DATA_RFM as select customername,max(Recency) Recency,max(Frequency) Frequency,max(Monetary) Monetary from (
select customername, ntile(4) over (order by max(orderdate) desc) Recency, null Frequency,null Monetary from sales_Data
group by customername
union all
select customername, null,ntile(4) over (order by count(orderdate) desc) Frequency,null from sales_Data
group by customername
union all
select customername, null,null,ntile(4) over (order by sum(sales) desc) Monetary from sales_Data
group by customername
) group by customername
order by recency,frequency,monetary;

select * from sales_Data_rfm;