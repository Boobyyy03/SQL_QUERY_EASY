use FUH_COMPANY 	
-- Phần 1 : Truy vấn cơ bản : Select (chọn), from (từ bảng nào), where (điều kiện), order by (sắp xếp)
--1. Hiển thị tất cả nhân viên
select *
from tblEmployee

--2. 

--3. hiển thị thông tin tất cả nhân viên nhưng chỉ lấy thông tin mã số, tên địa chỉ và ngày bắt đầu đi làm
select empSSN, empName,empAddress, empStartdate
from tblEmployee

--4. Hiển thị thông tin nhân viên tương ứng
--empSSN -> Mã SV
--empName -> Tên NV
select empSSN as N'Mã NV', empName as N'Tên NV',
empStartdate as N'Ngày bắt đầu làm việc'
from tblEmployee

--5. Hiển thị 5  nhân viên đầu tiên các thông tin empSSN, empName đổi thành Tên nhân viên và empSex, address

select top 5 empSSN,
empName as N'Tên nhân viên',
empSex,empAddress
from tblEmployee

--6. Lấy tất cả nhân viên có lương trên 3000 và là nữ
select *
from tblEmployee
where empSalary > 3000 and empSex ='F'

--8. Lấy tất cả nhân viên không có ngừoi quản lý
select *
from tblEmployee
where supervisorSSN is NULL

--9. Lấy tất cả nhân viên có chữ 'Hoàng'
select *
from tblEmployee
where empName like '%Hoàng%'
--10. Hiển thị thông tin nhân viên bao gồm mã số, họ tên, giới tính, lương, ngày làm việc theo thứ tự lương tăng dần
select empSSN,empName,empSex,empSalary,empStartdate
from tblEmployee
order by empSalary 


--11. Liệt kê tên nhân viên, lương, ngày vào làm sau đó sắp xếp giảm dần theo ngày vào làm, biét rằng nhân viên phải là nữ
select empName, empSalary,empStartdate
from tblEmployee
where empSex = 'F'
order by empStartdate desc

--12. Mã số, họ tên , giới tính, lương, ngày làm việc theo thứ tự ngày làm việc giảm dần
select empSSN, empName, empSex,empSalary,empStartdate
from tblEmployee
order by empStartdate desc

--13. theo thứ tự tăng dần và thứ tự ngày làm việc giảm dần
select empSSN, empName, empSex,empSalary,empStartdate
from tblEmployee
order by empSalary asc, empStartdate desc

--14. Hiển thị 10 nhân viên với mã số, họ tên, lươn, ngày sinh, địa chỉ
select top 10 empSSN, empName,empSalary,empBirthdate,empAddress
from tblEmployee

-- 15. Hãy cho biết những nhân viên
-- không có người quản lý và có họ là Nguyễn và ở TP.HCM
select*
from tblEmployee
where supervisorSSN is null and empName like N'Nguyễn%'

-- 16. Hãy cho biết những nhân viên
-- có người quản lý và có lương > 10000 và ở TP.HCM
select*
from tblEmployee
where supervisorSSN is not null and empSalary > 1000

-- 17. Hãy cho biết những nhân viên
-- có người quản lý và có lương > 10000
-- và ở TP.HCM, sau đó sắp xếp tăng dần theo ngày vào làm và giảm dần theo lương
select*
from tblEmployee
where supervisorSSN is not null and empSalary > 1000 and empAddress = N'TP.HCM' 
order by empSalary desc

-- 18. Hãy hiển thị thông tin nhân viên
-- bao gồm mã số, họ tên, giới tính, lương và ngày làm việc
-- có lương > 30000
-- và sắp xếp theo thứ tự ngày sinh giảm dần và tăng dần theo ngày vào làm

select*
from tblEmployee
where empSalary > 3000
order by empBirthdate desc, empStartdate asc

--19. Hiển thị thông tin nhân viên có tên Giang và là nữ
select*
from tblEmployee
where empName = '%Giang' and empSex = 'F'

--20.  Hiển thị nhân viên có họ Vũ mà là nữ ở HCM và HN
select *
from tblEmployee
where empName like N'Vũ%'and empAddress =N'TP.HCM'

--21. Nhân viên có chữ lót là Hồng

select*
from tblEmployee
where empName like N'%_Hồng_%'

-- Phần 2 : Các hàm phổ biến nâng cao
--22. Hiển thị thông tin nhân vien sinh tháng 2 
select *
from tblEmployee
where MONTH(empBirthdate) = 2
--23. Hiển thị thông tin mã nhân viên, tên nhân viên và tháng sinh\
SELECT empSSN , empName as N'Tên nhân viên', MONTH(empBirthdate) as N'Tháng sinh'
from tblEmployee

--24. Tháng sinh lớn hơn 4
select empSSN, empName, MONTH(empBirthdate)
from tblEmployee
where MONTH(empBirthdate) > 4


--25. Hiển thị thông tin mã nv, tên nv, tháng sinh, tháng sinh > 4 và sắp xếp giảm dần
select empSSN, empName, MONTH(empBirthdate)
from tblEmployee
where month(empBirthdate) > 4
order by month(empBirthdate) desc

--26. Hiển thị hân viên làm việc tại các tháng lẻ
SELECT *
from tblEmployee
where month(empBirthdate) in (1,3,5,7,9)

--27. Hiển thị thông tin nhân viên có mã phòng ban là chẵn
select *
from tblEmployee
where depNum % 2 = 0

--28. Hiển thị thông tin riêng biệt của nhân viên
select distinct empAddress
from tblEmployee

--29. Hiển thị nhân viên có tuổi lớn hơn 40
select*
from tblEmployee
where YEAR(getdate()) - YEAR(empBirthdate) > 40
-- nâng cao : nếu tính tuổi theo ngày thamgs năm
SELECT*
from tblEmployee 
where FLOOR(datediff(DAY,empBirthdate,getdate())/365.25) > 40

--30. Liệt kê các mã nhân viên và quản lý
select distinct supervisorSSN
from tblEmployee
where supervisorSSN is not null

-------TRUY VẤN LỒNG (QUAN TRỌNG)--------
--31. Liệt kê tên những nhân viên và quản lý của nhân viên khác
select empName
from tblEmployee
where empSSN in (
select distinct supervisorSSN
from tblEmployee
where supervisorSSN is not null)

--32. Liệt kê MS, tên, giới tính, địa chỉ của các nhân viên là quản lý của phòng ban
select empSSN, empName, empAddress, depNum
from tblEmployee
where empSSN in (
select distinct supervisorSSN 
from tblEmployee
where supervisorSSN is not NULL )

--33. Liệt kê MS, tên, giới tính, địa chỉ của các nhân viên là quản lý của phòng ban và đang quản lý nhân viên khác
select empSSN, empName, empAddress
from tblEmployee
where empSSN in (
select distinct supervisorSSN 
from tblEmployee
where depNum is not NULL )

--34. Liệt kê những nhân viên có người thân
select depName, depRelationship
from tblDependent
where depRelationship is not null

--35. Liệt kê những nhân viên có tham gia làm dự án.
select tblEmployee.empSSN , tblEmployee.empName , sum(tblWorksOn.workHours)
from tblEmployee JOIN tblWorksOn on tblEmployee.empSSN = tblWorksOn.empSSN
GROUP BY tblEmployee.empSSN,empName

--36. Liệt kê những địa điểm đặt phòng ban
SELECT distinct locName
from tblLocation

--37. Liệt kê những phòng ban có tham gia dự án
select tblDepartment.depNum, tblProject.proName,tblDepartment.depName
from tblDepartment join tblProject on tblProject.depNum = tblDepartment.depNum
group by tblDepartment.depNum, proName, depName

--38. Liệt kê những nhân viên tham gia dự án mà vừa làm quản lý phòng ban
SELECT * FROM tblEmployee 
WHERE empSSN IN 
    (select w.empSSN from tblWorksOn as w JOIN tblDepartment as d ON w.empSSN = d.mgrSSN) 

select *
from tblEmployee
where empSSN in(
select distinct empSSN
from tblWorksOn)
and empSSN in(
select mgrSSN
from tblDepartment)

--39. Liệt kê những nhân viên đang làm quản lý phòng ban
SELECT *
FROM tblEmployee
where supervisorSSN is NULL

-- BÀI LUYỆN TẬP

--40. Hiển thị thông tin nhân viên có tháng sinh là chẵn
select * from tblEmployee
where month(empBirthdate) % 2 = 0

--41. Hiển thị thông tin nhân viên có tháng sinh là chẵn sau đó giảm dần theo năm sinh
select * from tblEmployee
where month(empBirthdate) % 2 = 0
order by month(empBirthdate) desc

--42. Hiển thị thông tin mã nhân viên, tên nhân viên, ngày sinh, tháng sinh và năm sinh > 1965
select empSSN, empName, empBirthdate, month(empBirthdate), year(empBirthdate)
from tblEmployee
where year(empBirthdate) > 1965

--43. Liệt kê tên, mã NV, số năm đi làm và tuổi ( tính theo năm ), biết rằng nhân viên ở TP.HCM hoặc Hà Nội
select empSSN, empName, year(getdate()) - year(empStartdate) as N'Năm đi làm',year(getdate()) - year(empBirthdate) as N'Tuổi' ,empAddress
from tblEmployee
where empAddress in (N'TP. Hồ Chí Minh', N'TP. Hà Nội')

--44. Liệt kê mã NV, tên , lương, số năm đi làm và tuổi (tính theo năm), biết rằng nhân viên ở TP.HCM hoặc Hà Nội
select empSSN, empName, year(getdate()) - year(empStartdate) as N'Năm đi làm',year(getdate()) - year(empBirthdate) as N'Tuổi' ,empSalary, empAddress
from tblEmployee
where empAddress in (N'TP. Hồ Chí Minh', N'TP. Hà Nội')

--45. Hiển thị thông tin nhân viên có số năm đi làm lớn hơn 5.
select empSSN, empName, year(getdate()) - year(empStartdate) as N'Năm đi làm'
from tblEmployee
where year(getdate()) - year(empStartdate) > 5

--46. Hay liêt kê ma nhân viên, tên nhan viên, luong,so nam di lam và tuòi (tinh theo nam) biêt rang nhan viên & TP. Hö Chi Minh hoäc Hà Noi 
--sau dó, sap xep täng dän so nam di lam va giam dän theo theo tuổi
select empSSN, empName, year(getdate()) - year(empStartdate) as N'Năm đi làm',year(getdate()) - year(empBirthdate) as N'Tuổi' ,empSalary, empAddress
from tblEmployee
where empAddress in (N'TP. Hồ Chí Minh', N'TP. Hà Nội')
ORDER BY year(getdate()) - year(empStartdate) ASC, year(getdate()) - year(empBirthdate) DESC

--47. Liệt kê những nhân viên là quản lý tại TP.HCM và Hà Nội sau đó sắp xếp tăng dần theo lương và giảm dần theo năm đi làm
select empName, empAddress
from tblEmployee
where empSSN in (
select distinct supervisorSSN
from tblEmployee
where supervisorSSN is not null) and empAddress in (N'TP. Hồ Chí Minh', N'TP. Hà Nội')
order by empSalary asc 


--48. Liệt kê những nhân viên là quản lý mà là nữ có lương > 10000 và số năm đi làm nhỏ hơn 10 và tuổi lớn hơn 40
select empSSN, empName , empSex,empSalary, year(getdate()) - year(empStartdate) as N'Năm đi làm'
from tblEmployee
where empSex = 'F' and empSalary > 1000 and year(getdate()) - year(empStartdate) < 10  and year(getdate()) - year(empStartdate) < 40


--49. Liệt kê mã NV, tên, lương NV , số tuổi, số năm đi làm, mà nhân viên quản lý là nam , lương > 10000, số năm đi làm < 10, tuổi > 40
--sắp xếp tăng dần theo lương và giảm theo số năm đi làm
select empSSN, empName, year(getdate()) - year(empStartdate) as N'Năm đi làm',year(getdate()) - year(empBirthdate) as N'Tuổi' ,empSalary, empAddress
from tblEmployee
where empSex = 'M' and empSalary > 1000 and year(getdate()) - year(empBirthdate) > 40 and  year(getdate()) - year(empStartdate) < 10
order by empSalary ASC , year(getdate()) - year(empStartdate) DESC

--50. Hiển thị thông tin những nhân viên là quản lý , bắt đầu làm việc tại công ty vào tháng 2,4,6,8,10 và ở các tỉnh miền Nam , tuổi > 30
--sắp xếp lương tăng dần
select empName, empStartdate, empAddress, year(getdate()) - year(empBirthdate) as N'Tuổi' ,empSalary
from tblEmployee
where empSSN in (
select distinct supervisorSSN
from tblEmployee
where supervisorSSN is not null) and month(empStartdate) in ('2','4','6','8','10') and empAddress in (N'Long An', N'TP. Hồ Chí Minh', N'Đồng Nai')
order by empSalary ASC 

-- Phần 3 : TRUY VẤN HÀM TỔNG HỢP ( count, sum, max, min )
--51. Đếm số lượng nhân viên
select count(*)
from tblEmployee

--52. Hãy cho biết có bao nhiêu nhân viên lương > 30000
select count(empSSN)
from tblEmployee
where empSalary > 30000

--53. Cho biết bao nhiêu nhân viên là quản lý nhân viên khác
select count(distinct supervisorSSN)
from tblEmployee
where supervisorSSN is not null

--54. Hãy tìm lương nhỏ nhất
select min(empSalary) as N'Lương nhỏ nhất'
from tblEmployee

--55. Hãy in ra bảng tổng hợp bao gồm (SLNV, lương nhỏ nhất, lương lớn nhất, lương trung bình, tổng lương)
select count(emp.empSSN) as N'Số lượng NV',
min(emp.empSalary) as N'Lương nhỏ nhất',
max(emp.empSalary) as N'Lương lớn nhất',
avg(emp.empSalary) as N'Lương trung bình',
sum(emp.empSalary) as N'Tổng lương'
from tblEmployee emp 

--56. Hãy cho biết có bao nhiêu loại giới tính.
select count(distinct empSex)
from tblEmployee

--59. Hãy tính tổng lương công ty phải trả hàng tháng
select sum(empSalary)
from tblEmployee

--60. Hãy đếm số lượng nhân viên không có quản lý
select count(empSSN) as N'Số lượng nhân viên không giám sát'
from tblEmployee
where empSSN not in (
select distinct supervisorSSN
from tblEmployee
where supervisorSSN is not Null)

--61. Hãy tính tổng lương phải trả cho nhân viên giám sát hàng tháng
select sum(empSalary) as N'Số lượng nhân viên giám sát'
from tblEmployee
where empSSN in (
select distinct supervisorSSN
from tblEmployee
where supervisorSSN is not Null)

--62. Tính tuổi trung bình của quản lý phòng ban
select avg(year(getdate()) - year(mgrAssDate))
from tblDepartment

-- Phần 4: TRUY VẤN GOM NHÓM VÀ ĐIỀU KIỆN TRÊN NHÓM

-- Dẫn nhập : Hiển thị mã NV, tên NV, lương, mã phòng ban, kỹ thuật đặt tên bảng emp.

select emp.empSSN, emp.empName
from tblEmployee emp

--63. Hãy cho biết có bao nhiêu nhân viên mỗi phòng ban
select count(emp.empSSN)
from tblEmployee emp
group by emp.depNum

--64. Hiển thị thêm mã phòng ban
select depNum, count(emp.empSSN)
from tblEmployee emp
group by emp.depNum

--65. Hãy cho biết bảng thống kê về số lượng nhân viên,lương min ,max, avg,sum, trong mỗi phòng ban
select depNum, count(emp.empSSN) as N' Số lượng nhân viên phòng ban', 
min(emp.empSalary) as Min,
max(emp.empSalary) as Max,
avg(emp.empSalary) as AVG
from tblEmployee emp
group by emp.depNum

--66. Hãy cho biết bảng thống kê về số lượng nhân viên,lương min ,max, avg,sum, trong mỗi phòng ban mà ở đó nhân viên > 4
select depNum, count(emp.empSSN) as N' Số lượng nhân viên phòng ban', 
min(emp.empSalary) as Min,
max(emp.empSalary) as Max,
avg(emp.empSalary) as AVG
from tblEmployee emp
group by emp.depNum
having count(emp.empSSN) > 4

--where : là điều kiện không dựa trên nhóm
--Having : là điều kiện dựa trên nhóm

--67. Hãy cho biết những phòng ban có số lượng nhân viên ở TP và có số lượng tối thiểu là 2 và sắp xếp giảm dần theo số lượng
select depNum,count(empSSN) as N'Số nhân viên'
from tblEmployee
where empAddress like 'TP.%'
GROUP by depNum
having COUNT(empSSN) > 2
order by count(empSSN) desc

--BÀI TẬP:
--68. Hãy cho biết mỗi mã nhân viên có bao nhiêu thân nhân-- select * from tblDependent
select empSSN, count(dep.depRelationship) as N'Người thân'
from tblDependent dep
group by empSSN
-- 69. Hãy cho biết mỗi nhân viên làm trên bao nhiêu dự án
select empSSN, count(pro.proNum) as N'Dự án'
from tblWorksOn pro
group by empSSN

-- 70. Hãy cho biết mỗi phòng ban được đặt tại bao nhiêu địa điểm
select * from tblLocation
select * from tblDepLocation

select depNum, count(dep.locNum) as N'Địa điểm'
from tblDepLocation dep
group by depNum

-- 71. Hãy cho biết mỗi địa điểm có bao nhiêu phòng ban
select locNum, count(dep.depNum) as N'Phòng ban'
from tblDepLocation dep
group by locNum

-- 72. Hãy cho biết mỗi địa điểm có bao nhiêu dự án, lấy những địa điểm có dự án
-- có số lượng tối thiểu là 2 và sắp xếp giảm dần theo số dự án
select count(emp.proNum) as N'Số dự án', locNum
from tblProject emp
group by emp.locNum
having count(emp.proNum) >= 2
order by count(emp.proNum)

-- 73. Hãy cho biết mỗi nhân viên làm bao nhiêu giờ, trung bình số giờ làm,
-- số giờ ít nhất, số giờ làm nhiều nhất,
-- biết rằng chỉ trung bình giờ làm lớn hơn 2
select * from tblWorksOn

select empSSN, sum(w.workHours) as N'Giờ làm', 
avg(w.workHours) as AVG,
min(w.workHours) as Min,
max(w.workHours) as Max
from tblWorksOn w
group by empSSN


-- 74. Hãy cho biết mỗi nhân viên giám sát thì giám sát bao nhiêu nhân viên
select supervisorSSN, count(emp.empSSN)
from tblEmployee emp
group by supervisorSSN
having supervisorSSN is not null

-- 75. Hãy cho biết lương trung bình của nhân viên giám sát
select supervisorSSN, avg(emp.empSalary) as N'Lương trung bình'
from tblEmployee emp
group by supervisorSSN
having supervisorSSN is not null

--TRUY VẤN LỒNG NÂNG CAO
--76. In ra các mã nhân viên , tên NV có lương nhỏ nhất
select empSSN, empName
from tblEmployee
where empSalary = (select min(empSalary) from tblEmployee)

--77. Hãy cho biết có bao nhiêu nhân viên có lương lớn hơn mức trung bình của thành phố.
select count(*) as N'Số lượng nhân viên'
from tblEmployee
where empSalary > (
select avg(empSalary) as AVGSalary
from tblEmployee
) and empAddress like '%TP.%'

--78. Hãy liệt kê phòng ban, lương trung bình của phòng ban 
--mà có lương trung bình của nó lớn hơn trung bình lương của công ty.
-- sắp xếp theo lương trung bình phòng ban tăng dần
select x.depNum, avg(x.empSalary)
from tblEmployee x
group by x.depNum
having avg(x.empSalary) > (
select avg(y.empSalary) as AVGSalary
from tblEmployee y
)
order by avg(x.empSalary) ASC

--79. Hãy liệt kê phòng ban, lương tb của phòng ban mà có lương trung bình của nó lớn hơn trung bình lương của công ty.
--lưu ý chỉ tính toán trên những nhân viên làm ở thành phố, sau đó sắp xếp giảm dần theo mã phòng ban

select x.depNum, avg(x.empSalary) as N'Lương trung bình'
from tblEmployee x
where x.empAddress like N'TP.%'
group by x.depNum
having avg(x.empSalary) >
(
select avg(y.empSalary) 
from tblEmployee y
where y.empAddress like N'TP.%'
) 
order by x.depNum DESC 

--80. Liệt kê mã nâhn viên, tên NV có giờ làm trung bình trên dự án lớn hơn 5.0 và ở thành phố.
select empSSN, empName
from tblEmployee
where empAddress like 'TP.%' and empSSN in
(
select empSSN
from tblWorksOn
group by empSSN
having avg(workHours) > 5.0
)

--82. Hiển thị tên NV, tên phòng ban đang làm việc
select emp.empName, dep.depName
from tblEmployee emp , tblDepartment dep
where dep.depNum = emp.depNum

--cách 2
select emp.empName, dep.depName
from tblEmployee emp
join tblDepartment dep on dep.depNum = emp.depNum


--83. LIỆT KÊ TÊN NHÂN VIÊN, tên thân nhân và mối quan hệ
select emp.empName, dep.depRelationship
from tblEmployee emp, tblDependent dep
where emp.empSSN = dep.empSSN
--Cách 2 
select emp.empName, dep.depName, dep.depRelationship
from tblEmployee emp 
left join tblDependent dep on emp.empSSN = dep.empSSN

--84. Hãy cho biết tên dự án, tên địa điểm diễn ra dự án , ưu tiên hiển thị địa điểm

select loc.locName, pr.ProName
from tblLocation loc 
left join tblProject pr on loc.locNum = pr.locNum

--85. Hãy cho biết mã nhân viên, tên nhân viên, tên phòng ban và tên thân nhân
select emp.empSSN, emp.empName,dep.depName, depend.depRelationship
from tblEmployee emp
join tblDependent depend on depend.empSSN = emp.empSSN
join tblDepartment dep on dep.depNum = emp.depNum

--86. Hãy cho biết tên phòng ban và địa điểm đặt phòng ban
select  dep.depName, loc.locName
from tblDepLocation depl
join tblLocation loc on loc.locNum = depl.locNum
join tblDepartment dep on dep.depNum = depl.depNum

-- 87. Hãy cho biết tên phòng ban và các dự án do phòng ban quản lý
-- và địa điểm diễn ra dự án
-- Gợi ý: tblDepartment, tblProject, tblLocation
select dep.depName, loc.locName, pr.proName
from tblProject pr
join tblDepartment dep on dep.depNum = pr.depNum
join tblLocation loc on loc.locNum = pr.locNum

-- 88. Hãy cho biết tên dự án và tên nhân viên tham gia dự án
-- Gợi ý: tblProject, tblWorksOn và tblEmployee
select pr.proName, emp.empName
from tblEmployee emp
join tblWorksOn w on emp.empSSN = w.empSSN
join tblProject pr on w.proNum = pr.proNum

-- 89. Hãy cho biết tên dự án, tên nhân viên tham gia dự án
-- và phòng ban nhân viên đó làm
-- Gợi ý: tblProject, tblWorksOn, tblEmployee và tblDepartment
select pr.proName, emp.empName, dep.depName
from tblEmployee emp
join tblProject pr on emp.depNum = pr.depNum
join tblDepartment dep on dep.depNum = pr.depNum

-- 90. Hãy cho biết tên dự án, địa điểm diễn ra dự án
-- tên nhân viên tham gia dự án và phòng ban nhân viên đó làm
-- Gợi ý: tblLocation, tblProject, tblWorksOn, tblEmployee và tblDepartment
select pro.proName, loc.locName, emp.empName, dep.depName 
from tblEmployee emp
join tblWorksOn w on w.empSSN = emp.empSSN
join tblDepartment dep on dep.depNum = emp.depNum
join tblProject pro on pro.depNum = dep.depNum
join tblLocation loc on pro.locNum = loc.locNum

-- 91. Hãy cho biết tên thân nhân, tên nhân viên, tên phòng ban
-- và địa điểm của phòng ban
-- Gợi ý: tblDependent, tblEmployee, tblDepartment, tblDepLoc và tblLocation
select emp.empName, depend.depName as N'Tên thân nhân',dep.depName as N'Tên phòng ban', loc.locName
from tblEmployee emp
join tblDepartment dep on dep.depNum = emp.depNum
join tblDependent depend on depend.empSSN = emp.empSSN
join tblDepLocation depl on depl.depNum = dep.depNum
join tblLocation loc on depl.locNum = loc.locNum


-- 92. Hãy cho biết tên nhân viên và quản lý của nhân viên đó
select emp.empName as N'Tên nhân viên', em.empName as N'Tên quản lý'
from tblEmployee emp
join tblEmployee em on emp.supervisorSSN = em.empSSN

-- 93. hãy cho biết tên phòng ban và tên nhân viên quản lý
select dep.depName as N'Tên phòng ban', emp.empName as N'Tên quản lý'
from tblEmployee emp
join tblDepartment dep on emp.empSSN = dep.mgrSSN

-- 94. Hãy cho biết thông tin mã phòng, tên phòng
-- và mã nhân viên quản lý, tên nhân viên quản lý và lương người quản lý  > 50000
select emp.depNum as N'Mã phòng ban', 
dep.depName as N'Tên phòng ban', 
depa.mgrSSN as N'Mã quản lý', 
emp.empName as N'Tên quản lý', 
emp.empSalary as N'Lương quản lý'
from tblEmployee emp
join tblDepartment dep on dep.depNum = emp.depNum
join tblDepartment depa on depa.mgrSSN = emp.empSSN
where emp.empSalary > 50000


-- 95. Truy vấn để hiển thị danh sách
-- mã nhân viên không quản lý phòng ban nào hết và tên thân nhân
-- Gợi ý
select emp.empSSN,emp.empName, depend.depRelationship
from tblEmployee emp
full join tblDependent depend on depend.empSSN = emp.empSSN
where emp.empSSN not in  
(
select dept.mgrSSN 
from tblDepartment dept
)

-- 96. Hãy cho biết tên nhân viên, tên phòng ban
-- mà không có người thân
select emp.empName, dep.depName
from tblEmployee emp
full join tblDepartment dep on emp.depNum = dep.depNum
full join tblDependent depend on emp.empSSN = depend.empSSN 
where emp.empSSN not in 
(
select empSSN
from tblDependent
)

-- 97. Hãy cho biết tên nhân viên, tên phòng ban của những nhân viên làm giám sát và không có người thân
select distinct(emp.empSSN), emp.empName ,dep.depName
from tblEmployee emp
join tblEmployee em on emp.empSSN = em.supervisorSSN
join tblDepartment dep on dep.depNum = em.depNum
where emp.empSSN in (
    select emp.supervisorSSN
    from tblEmployee emp
    where emp.supervisorSSN is not null
) and emp.empSSN not in
(
    select empSSN
    from tblDependent
)

-- 98. Hãy cho biết tên nhân viên, tên phòng ban mà nhân viên đó không tham gia dự án nào.
select emp.empSSN,emp.empName, dep.depName
from tblEmployee emp
join tblDepartment dep on dep.depNum = emp.depNum
where emp.empSSN not in
(
    select empSSN
    from tblWorksOn
)

--99. Hãy cho biết mã phòng ban, tên phòng ban và số lượng dự án mà phòng ban quản lý
select dep.depNum, dep.depName, count(pro.proName) as Soluong
from tblProject pro
join tblDepartment dep on pro.depNum = dep.depNum
group by dep.depNum,dep.depName

--100. Hãy cho biết mã phòng ban, tên phòng ban, và số lượng dự án mà phòng ban quản lý có số lượng dự án > 1
select dep.depNum, dep.depName, count(pro.proNum)
from tblProject pro
join tblDepartment dep on dep.depNum = pro.depNum
group by dep.depNum, dep.depName
having count(pro.proNum) > 1

--101. Hãy cho biết mã phòng ban, tên phòng ban, và số lượng dự án mà phòng ban quản lý có số lượng dự án > 1
-- mà làm bên phần mềm, sau đó giảm dần theo số dự án.
select dep.depNum, dep.depName, count(pro.proNum)
from tblProject pro
join tblDepartment dep on dep.depNum = pro.depNum
group by dep.depNum, dep.depName
having count(pro.proNum) > 1 and dep.depName like N'%_Phần mềm_%'
order by count(pro.proNum) desc

--102. Hãy cho biết mỗi nhân viên có bao nhiêu người thân và tên phòng ban.
select emp.empSSN, emp.empName, count(depend.depRelationship), dep.depName
from tblEmployee emp
join tblDependent depend on depend.empSSN = emp.empSSN
join tblDepartment dep on dep.depNum = emp.depNum
group by emp.empName, emp.empSSN, dep.depName

-- 103. Hãy cho biết có bao nhiêu dự án ở mỗi địa điểm, hiển thị tên địa điểm
select loc.locName, count(pro.proNum)
from tblLocation loc 
join tblProject pro on pro.locNum = loc.locNum
group by loc.locName

-- 104. Hãy cho biết tên mỗi phòng ban được đặt tại bao nhiêu địa điểm
select dep.depName, count(depl.locNum)
from tblDepLocation depl
join tblDepartment dep on dep.depNum = depl.depNum
group by dep.depName

-- 105. Hãy cho biết tên mỗi địa điểm và số lượng phòng ban ở đó
select loc.locName, count(dep.depNum) as Soluong
from tblLocation loc 
join tblDepLocation dep on dep.locNum = loc.locNum
group by loc.locName

-- 106. Hãy cho biết tên nhân viên và số lượng dự án nhân viên tham gia
select emp.empSSN, emp.empName, count(w.proNum)
from tblEmployee emp
join tblWorksOn w on w.empSSN = emp.empSSN
group by emp.empSSN, emp.empName

-- 107. Hãy cho biết tên dự án và số lượng nhân viên tham gia
SELECT pro.proNum,pro.proName , count(w.empSSN)
from tblProject pro
join tblWorksOn w on w.proNum = pro.proNum
group by pro.proName, pro.proNum


-- VIEWS : Tạo bảng ảo phục vụ trong bảo mật nhằm giới hạn thông tin người dùng
-- và phân quyền sử dụng view. Tên view thường có pre-fix là vw_
-- Bảng tạm có liên quan trực tiếp và chịu tác động lien đới 2 chiều với bảng dữ liệu

-- Ngữ cảnh: Lấy hết thông tin của tblEmployee
select *
from tblEmployee

-- 109. Viết Views hiển thị thông tin nhân viên bao gồm mã số, tên,giới tính và lương
create view vw_Employees
as
select empSSN,empName,empSex,empSalary
from tblEmployee
go

--go
--create view vw_tên Bảng
--as
--select empSSN,empName,empSex,empSalary
--from tblEmployee
--go



-- Sử dụng Views như bảng để truy vấn thông tin
select *
from vw_Employees


-- Với Views được sinh ra từ câu truy vấn cơ bản thì ta có thể
-- thực hiện các thao tác INSERT,UPDATE,DELETE
insert vw_Employees (empSSN,empName,empSex,empSalary) values
('3014023012','Nguyễn Ngọc Minh','F',20000)

update vw_Employees
set empSalary = 9000
where empSSN = '1234'

delete vw_Employees
where empSSN = '1234'


-- Xóa Views
drop view vw_Employees


-- View kết hợp nhiều bảng: vw_EmployeeDepartment
-- 110. Liệt kê mã nhân viên, tên nhân viên và mã phòng ban,
-- tên phòng ban mà nhân viên làm việc
go
create view vw_EmployeeDepartmentt
as
select emp.empSSN ,emp.empName, emp.depNum, dept.depName
from tblEmployee emp 
join tblDepartment dept on emp.depNum = dept.depNum
go

select * 
from vw_EmployeeDepartmentt


-- Đối với Views được sinh ra từ câu truy vấn kết hợp nhiều bảng
-- thì chúng ta hạn chế các thao tác INSERT, UPDATE, DELETE, trên Views



-- PHẦN 7 : LẬP TRÌNH T - SQL
-- Script
-- 1. Khai báo biến
-- 1.1: System: hệ thống --> @@<name> --> lấy (xem) giá trj
-- 1.2: User defined: Do người dùng định nghĩa --> @<name> -> get(xem), set(gán)
-- Tham khảo : SQL - w3school


-- 2. Gán giá trị cho biến

-- 3. Hiện thị giá trị của biến

-- hoặc: print @soluong

-- 4. T-SQL: Đưa biến vào Query


-- IF...ELSE
-- Part 1.Cơ bản

-- PART 2 : Nâng cao (liên quan truy vấn)
-- 112. Hãy tính tổng lương phải trả hàng tháng cho nhân viên,
-- Nếu tổng lương < 250000 thì xuất ra 'Chưa cần tinh giản biên chế'
-- Ngược lại thì in ra 'Cần tinh giản biên chế'
go
declare @tongluong float
select @tongluong = sum(empSalary)
from tblEmployee
if @tongluong < 250000
begin
	print N'Chưa cần tinh giản biên chế'
end
else
begin
	print N'Cần tinh giản biên chế'
end
go


-- PHẦN 8 : VIẾT THỦ TỤC STORE PROCEDURE

-- Dẫn nhập: tránh lộ thông tin


-- Tạo thủ tục để giới hạn quyền truy xuất thông tin nhạy cảm
-- THỦ TỤC KHÔNG THAM SỐ
-- Prefix: sp
-- 113. Viết thủ tục spEmpInfo
-- để liệt kê mã nhân viên, tên nhân viên, lương của nhân viên
go
create procedure spEmpInfo1
as
select empSSN,empName,empSalary
from tblEmployee
go


-- THỰC THI SP
exec spEmpInfo1

-- Xóa store procedure
drop procedure spEmpInfo1


-- THỦ TỤC CÓ THAM SỐ
-- 114. Viết thủ tục spEmpSalary
-- để liệt ke mã nhân viên, tên nhân viên, lương của nhân viên,
-- biết rằng lương lớn hơn một giá trị nào đó
go
create procedure spEmpSalary1
	@luong float
as
	select empSSN,empName,empSalary
	from tblEmployee
	where empSalary > @luong
go

-- Thực thi Store Procedure
exec spEmpSalary1 12000
drop procedure spEmpSalary1

-- 115. Viết thủ tục spEmpSalaryAddress
-- để liệt kê mã nhân viên, tên nhân viên, lương ủa nhân viên
-- và tên phòng ban
-- biết rằng lương lớn hơn một giá trị nào đó
-- và nhân viên ở một nơi nào đó
go
create procedure spEmpSalaryAdress1
@vluong float,
@vaddress nvarchar(50)
as
	select empSSN,empName,empSalary,empAddress
	from tblEmployee
	where empSalary > @vluong
	and empAddress like '%'+@vaddress+'%'
go

-- Thực thi
exec spEmpSalaryAdress1 80000,N'TP. Hà Nội'

-- FUNCTION: Có 2 loại
-- Trả về Scalar (một giá trị cụ thể), Table (bảng dữ liệu)
-- Prefix của hàm là fn
-- LOẠI 1: TRẢ VỀ SCALAR (Giá trị cụ thể)


-- 116.  Hãy viết hàm fnCountEmployee nhằm để
-- đếm số lượng nhân viên có trong công ty
go
create function fnCountEmployee2()
returns int
as
begin
	declare @soluong int
	select @soluong = count(*)
	from tblEmployee
	return @soluong
end
go

declare @kq int
exec @kq = fnCountEmployee2
print(@kq)

-- Đây không thâm số
drop function fnCountEmployee2


-- Thực thi


-- Xóa Hàm


-- 117. Hãy viết hàm fnSumSalaryEmployeeSex nhằm để tính tổng lương phải trả cho nhna viên hàng tháng trong công ty
-- theo giới tính <-- tham số đầu vào
go
create function fnSumSalaryEmployeeSex1(
	@gioitinh varchar(1)
)
returns float
as
begin 
	declare @tongluong float
	select @tongluong = sum(empSalary)
	from tblEmployee
	where empSex = @gioitinh
	return @tongluong
end
go

declare @kq1 float
exec @kq1 = fnSumSalaryEmployeeSex1 'F'
select(@kq1)

drop function fnSumSalaryEmployeeSex1


-- LOẠI 2: TRẢ VỀ TABLE ( Kết quả trả về là bảng dữ liệu)
-- bao gồm : mã nhân viên, tên nhân viên
-- giới tính, địa chỉ, lương
-- biết rằng, lương lớn hơn một mức nào đó <-- tham số truyền vào 
-- và nhân viên là giới tính nào đó <-- tham số truyền vào
go
create function fnEmpSalarySex1(
	@sex varchar(1),@vluong float
)
returns table
as
return(
	select empSSN,empName,empSex,empAddress,empSalary
	from tblEmployee
	where empSex = @sex and empSalary > @vluong)
go

-- EXEC
select * 
from fnEmpSalarySex1('F',80000)


-- 120. Viết hàm fnEmployeeDepartment hiển thị danh sách
-- thông tni mã nhân viên, tên nhân viên,
-- lương và tên phòng ban nhân viên làm việc
-- biết rằng tham số truyền vào là địa chỉ
go
create function fnEmployeeDepartment1(
	@vdiachi nvarchar(50)
)
returns table
as
return (select emp.empSSN, emp.empName, emp.empSalary, dept.depName
		from tblEmployee emp  
		join tblDepartment dept on emp.depNum = dept.depNum
		where empAddress = @vdiachi)

go

select * from fnEmployeeDepartment1(N'TP. Hà Nội')



-- Bài tập luyện =======

-- 121. Viết thủ tục spProjectLocation
-- để liệt kê mã dự án, tên dự án được tổ chức ở địa điểm ở đó
go
create procedure spProjectLocation1
as
begin
select pro.proNum,pro.proName
from tblProject pro
end
go

exec spProjectLocation1


-- 122. Viết thủ tục spDepartmentLocation
-- để liệt kê danh sách địa điểm mà một phòng ban nào đó được đặt
go
create procedure spDepartmentLocation1
@phongban int
as
begin
	select lo.locNum,lo.locName,dept.depName
	from tblDepartment dept
	join tblDepLocation deplo on dept.depNum = deplo.depNum
	join tblLocation lo on lo.locNum = deplo.locNum
	where dept.depNum = @phongban
	end
go

exec spDepartmentLocation1 2

drop procedure spDepartmentLocation1


-- 123. Viết hàm fnEmployeeDepend
-- Trả về số lượng thân nhân của một nhân viên khi biết mã nhân viên
go
create function fnEmployeeDepend(
	@manv numeric
)
returns numeric
as
begin
	declare @soluongthannhan numeric
	select @soluongthannhan = count(*)
	from tblDependent
	where empSSN = @manv
	return @soluongthannhan
end
go

declare @kq int
exec @kq = fnEmployeeDepend '30121050038'
select (@kq)

drop function fnEmployeeDepend


-- 124. Viết hàm fnEmployeeInfo
-- Liệt kê thông tin mã nhân viên, tên nhân viên, lương, số giờ làm, tên phòng ban của các nhân viên
go
create function fnEmployeeInfo()
returns table
as
return (select emp.empSSN,emp.empName,emp.empSalary,sum(wk.workHours) as Sogiolam,dept.depName
		from tblEmployee emp inner join tblDepartment dept on emp.depNum = dept.depNum
		inner join tblWorksOn wk on wk.empSSN = emp.empSSN
		group by emp.empSSN,empName,emp.empSalary,dept.depName)
go

select * from fnEmployeeInfo()
drop function fnEmployeeInfo

-- 125. Viết ahmf fnEmployeePerformance
-- Trả về bảng thông tin bao gồm tên nhân viên, lương, số giờ làm việc, tên phòng ban của những
-- nhân viên có tuổi lớn hơn một mức tuổi nào đó và giới tính nào đó
go
create function fnEmployeePerformance(
	@tuoi int, @gioitinh char(1)
)
returns table
as
return (select emp.empName,emp.empSalary,sum(wk.workHours) as Sogiolam, dept.depName
		from tblEmployee emp 
		join tblDepartment dept on emp.depNum = dept.depNum
		join tblWorksOn wk on wk.empSSN = emp.empSSN
		where year(getdate()) - year(emp.empBirthdate) > @tuoi
		and emp.empSex = @gioitinh
		group by emp.empName,emp.empSalary,dept.depName)
go

select * from fnEmployeePerformance (60,'M')


---------- CÁC RÀNG BUỘC DƯ LIỆU CƠ BẢN (CONTRAINST)
-- Áp dụng trên các thao tác INSERT, UPDATE, DELETE
-- 1. Primary Key (demo) --> prefix là pk
-- 2. Foreign key (demo) --> prefix là fk
-- 3. Check (logical expression) --> kiểm tra các ràng buộc về giá trị
-- của dòng dữ liệu cơ bản, ràng buộc này sẽ áp dụng cho tất cả các dòng
--> prefix là ck

-- 126. Hãy thêm ràng buộc về lương (Salary) của nhân viên(tblEmployee)
-- là lớn hơn 10000
alter table tblEmployee ADD CHECK (empSalary > 10000)

-- alter table + bảng muốn ràng buộc + ADD + check (điều kiền) ( TH1: Không đặt tên ràng buộc )

-- alter table + bảng muốn ràng buộc + ADD + Contrainst + tên ck_tên + check (điều kiện) ( TH2: Đặt tên cho ràng buộc )

alter table tblEmployee drop constraint CK__tblEmploy__empSa__22751F6C


-- 127. Tạo ràng buộc kiểm tra ck_sex là F,M,L,G,B,T
alter table tblEmployee ADD Constraint ck_sex
check (empSex in ('F','M','G','L','T','B'))

alter table tblEmployee drop constraint ck_sex

------------------ TRANSACTION ------------------------
-- 128. Cập nhật lương nhân viên tăng thêm 10,000 mỗi lần tăng lương
-- tuy nhiên nếu tổng lương công ty phải trả quá 2,000,000 phải trả hàng tháng 
-- thì không được tăng lương nữa
begin tran
update tblEmployee
set empSalary += 10000

declare @tongluong int
select @tongluong = sum(empSalary)
from tblEmployee

-- Task 1
if @tongluong < 20000000000000000
begin
	print N'Đã tăng thành công'
	commit tran
end
else
begin
	print N'Vượt quá giới hạn'
	rollback tran -- Trả về giá trị trước khi tăng bị vượt quá
end


select empSalary
from tblEmployee

-- Task 2


-- 129. Cập nhật lương nhân viên tăng thêm 5.000 mỗi lần tăng lương
-- tuy nhiên nếu có bất kì một phòng ban mà có tổng lương hàng tháng phải > 250.000
-- thì không được tăng lương nữa
begin tran
update tblEmployee
set empSalary += 5000

declare @tongluong1 int
select @tongluong1 = sum(emp.empSalary)
from tblEmployee emp 
join tblDepartment dept on emp.depNum = dept.depNum
group by dept.depNum

if @tongluong1 < 2500000000
begin
	print N'Đă tăng lương thành công'
	commit tran
end
else
	begin
	print N'Đã vượt quá giới hạn'
	rollback tran
end

select dept.depName, sum(emp.empSalary)
from tblDepartment dept 
join tblEmployee emp
on dept.depNum = emp.depNum
group by dept.depName

-------- CÁC RÀNG BUỘC DWXX LIỆU NÂNG CAO (TRIGGER)
-- Sử dụng để kiểm tra các ràng buộc dữ liệu mang tính nghiệp vụ nâng cao
-- Trigger tác động lên 3 thao tác INSERT, UPDATE và DELETE cho bảng dữ liệu
-- Prefix : tg

-- 130. Hãy tạo Trigger tg_CheckInsertLocation trong bảng tblLocation
-- để ràng buộc số lượng địa điểm không được vượt quá 10
-- khi thêm mới dữ liệu INSERT
go
create trigger tg_CheckInsertLocation1 on tblLocation after insert
as
	declare @soluong int
	select @soluong = count(*)
	from tblLocation

if @soluong > 10
begin
	print N'Không được thêm nữa'
	rollback
end
else
begin
	print N'Đã thêm thành công'
end
go

		-- commit -- Ghi dữ liệu chính thức xuất CSDL
		-- (tuy nhiên, mặc định là commit nên không cần ghi nữa)


-- Tắt Trigger
Disable trigger tg_CheckInsertLocation1 on tblLocation

-- Mở Trigger
Enable trigger tg_CheckInsertLocation1 on tblLocation

-- Xóa Trigger
drop trigger tg_CheckInsertLocation1

-- 131 Hãy tạo Trigger tg_CheckDeleteLocation trong bảng tblLocation
-- để ràng buộc số lượng địa điểm tối thiểu là 6 khi xóa dữ liệu (DELETE)
go
create trigger tg_CheckDelteLocation on tblLocation after delete
as
declare @soluong int
select @soluong = count(*)
from tblLocation

if @soluong < 6
begin
	print N'Không được xóa nữa'
	rollback
end
else
begin
	print N'Đã xóa thành công'
end
go


-- 132. Hãy tạo Trigger tg_CheckInsertUpdateEmployee
-- trong bảng tblEmployee để ràng buộc tổng lương
-- phải trả hằng tháng không vượt quá 1500000
-- Khi thêm mới, cập nhật dữ liệu (INSERT, UPDATE)
go
create trigger tg_CheckInsertUpdateEmployee on tblEmployee after insert
as
	declare @tongluong int
	select @tongluong = sum(empSalary)
	from tblEmployee
if @tongluong > 150000000
begin
	print N'Vượt quá lương cho phép'
	rollback
end
else
begin
	print N'Đã cập nhật thành công'
end
go


-- NÂNG CAO TRIGGER
-- Khi thực hiện TRIGGER trên thao tác INSERT cho bảng dữ liệu
-- thì dữ liệu mới sẽ được insert tạm thời trong bảng có tên INSERTED
-- ta có thê rdungf bảng này để hỗ trợ xử lý các thao tác logic cho TRIGGER NÂNG CAO
-- Bảng INSERTED này có cấu trúc y như bảng được TRIGGER tác động lên
-- và trong đó chỉ chứa dòng dữ liệu mới vừa được thêm vào bảng đang được chỉ địnH

-- 133. Viết trigger tg_InsertProjectLocation để kiểm tra rằng một địa điểm
-- chỉ có tối đa 4 project được tổ chức khi thêm mới (INSERT) một
-- project vào bảng tblProject

go 
create trigger tg_InsertProjectLocation on tblProject after insert 
as 
-- Kỹ thuật quan trọng : Muốn lấy thông tin của dòng mới thêm vào ta dùng bảng Inserted 
    declare @maLoc int 
    select @maLoc = locNum
    from inserted 

    declare @soluong int 
    select @soluong = count(*)
    from tblProject 
    where locNum = @maLoc 
    if (@soluong > 4)
    begin 
        print N'Vi phạm số lượng Project trong địa điểm > 4'
        rollback 
    end 
    else 
    begin 
        print N'Insert thành công'
    end 
go 

disable trigger tg_InsertProjectLocation on tblProject 
drop trigger tg_InsertProjectLocation

--134. Hãy viết trigger tg_CheckEmployeeWorkOn
-- để kiểm tra rằng Insert, Update thì nhân viên không được làm quá 100 giờ 
go 
create trigger tg_CheckEmployeeWorkOn on tblWorksOn after insert 
as 
begin 
    set nocount on

    declare @manv int 
    select empSSN = @manv 
    from inserted 

    select empSSN = @manv 
    from deleted 

    declare @tonggio float 
    select @tonggio = sum(workHours)
    from tblWorksOn 
    where empSSN = @manv

    if ( @tonggio > 100 )
    begin 
        print 'Vi pham so gio > 100'
        rollback TRANSACTION
    end
    else 
    begin 
        print 'Insert thanh cong'
    end  
end
go
disable trigger tg_CheckEmployeeWorkOn on tblWorksOn
drop trigger tg_CheckEmployeeWorkOn

go 
create trigger tg_DeleteEmployeeWorkOn on tblWorksOn after delete 
as 
begin 
    declare @manv int 
    select empSSN = @manv 
    from inserted 

    declare @tonggio float 
    select @tonggio = sum(workHours)
    from tblWorksOn 
    where empSSn = @manv 
    if (@tonggio > 100)
    begin   
        print 'Vi pham'
        rollback 
    end 
    else 
    begin 
        print 'Thoả điều kiện'
    end
end 
go 

disable trigger tg_DeleteEmployeeWorkOn on tblWorksOn
select * from tblWorksOn


--Khi thực hiện Trigger trên thao tác Delete cho bảng dữ liệu 
--thì dữ liệu mới sẽ được deleted tạm thời tong bảng có tên DELETED ,
--ta có thể dùng bảng này để hỗ tợ xử lý theo tác logic cho Trigger nâng cao 
--Bảng Deleted này có cấu trúc y như bảng được Trigger tác động lên
--và trong đó chỉ chứa dòng dữ liệu mới vừa được xoá ra khỏi bnagr ban đầu. 

--135. Viết trigger tg_DeleteProjectLocation để kiểm tra rằng một địa điểm chỉ có tối thiểu 2 Project 
--được tổ chức khi xoá (Delete) một Project ra khỏi bảng tblProject 
--Gợi ý : lấy mã locaiton của dòng vừa xoá trong bảng Delete 
go 
create trigger tg_DeleteProjectLocation on tblProject after delete 
as 
begin 
    declare @mapro int 
    select proNum = @mapro
    from deleted
declare @tongdiadiem nvarchar(50)
    select @tongdiadiem = count(locNum)
    from tblProject
    where proNum = @mapro

    if (@tongdiadiem < 2)
    begin 
        print 'Vi pham dia diem < 2'
        rollback 
    end 
    else 
    begin 
        print 'Thoa dieu kien dia diem > 2'
    end 
end 
go 

disable trigger tg_DeleteProjectLocation on tblProject
drop  trigger tg_DeleteProjectLocation

--136. Viết trigger tg_CheckDeleteEmployeeDepartment để kiểm tra rằng, khi xoá một nhân viên 
--thì phải đảm bảo phòng ban còn ít nhất 2 nhân viên. 
go 
create trigger tg_CheckDeleteEmployeeDeapartment on tblEmployee after delete
as 
begin 
    declare @mapb int 
    select depNum = @mapb 
    from deleted

    declare @tongnhanvien int 
    select @tongnhanvien = count(empSSN)
    from tblEmployee 
    where depNum = @mapb 
    if ( @tongnhanvien < 2 )
    begin 
        print 'Vi pham so luong nhan vien < 2'
        rollback 
    end 
    else 
    begin 
        print 'Xoa thanh cong va so luong nhan vien > 2'
    end
end 
go 

disable trigger tg_CheckDeleteEmployeeDepartment on tblEmployee

drop trigger tg_CheckDeleteEmployeeDepartment
