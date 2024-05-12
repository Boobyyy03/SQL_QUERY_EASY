
select p.proname, sum(d.quantity) as [Total quantity]
from tblProducts p join tblInv_Detail d on d.proid = p.proid 
where p.proname like N'Router Wifi Chuẩn Wifi 6 AX5400 TP-Link Archer AX73'
group by p.proname