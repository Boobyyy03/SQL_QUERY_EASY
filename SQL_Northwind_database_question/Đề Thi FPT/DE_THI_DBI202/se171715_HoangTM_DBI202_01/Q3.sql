
select p.proid , p.proname , s.supname 
from tblProducts p right join tblSuppliers s
on p.supcode = s.supcode 
where s.supname = N'Hoàn Vũ'

