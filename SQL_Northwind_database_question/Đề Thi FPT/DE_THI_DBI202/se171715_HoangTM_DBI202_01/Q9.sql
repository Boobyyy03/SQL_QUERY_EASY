create trigger tbllnv_Detail on tblInv_Detail after insert as
 BEGIN 
 select i.invid , d.price as [Total Amount]  
 from inserted d join tblInvoices i on i.invid = d.invid 
end 
insert into tblInv_Detail 
values('000003','RTPL02',1,10000000)