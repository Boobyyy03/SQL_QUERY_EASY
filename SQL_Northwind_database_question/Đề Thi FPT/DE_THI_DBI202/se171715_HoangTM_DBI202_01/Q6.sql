 with t as (
 select i.invid , count(d.price) as [Total amount]  
 from tblInvoices i left join tblInv_Detail d on d.invid = i.invid 
 group by i.invid )
 select * from t 
 where [Total amount] = (select TOP 1[Total amount] from t)