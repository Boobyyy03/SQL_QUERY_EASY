delete from tblInvoices 
 where not exists (
 select * from tblInv_Detail
 where customer like N'Lê Minh Phương' )