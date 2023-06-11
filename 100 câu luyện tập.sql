use COMPANY
-- Phần 1 : Truy vấn cơ bản : Select (chọn), from (từ bảng nào), where (điều kiện), order by (sắp xếp)
--1. Hiển thị tất cả nhân viên


--2. 

--3. hiển thị thông tin tất cả nhân viên nhưng chỉ lấy thông tin mã số, tên địa chỉ và ngày bắt đầu đi làm


--4. Hiển thị thông tin nhân viên tương ứng
--empSSN -> Mã SV
--empName -> Tên NV


--5. Hiển thị 5  nhân viên đầu tiên các thông tin empSSN, empName đổi thành Tên nhân viên và empSex, address


--6. Lấy tất cả nhân viên có lương trên 3000 và là nữ


--8. Lấy tất cả nhân viên không có ngừoi quản lý


--9. Lấy tất cả nhân viên có chữ 'Hoàng'



--11. Liệt kê tên nhân viên, lương, ngày vào làm sau đó sắp xếp giảm dần theo ngày vào làm, biét rằng nhân viên phải là nữ


--12. Mã số, họ tên , giới tính, lương, ngày làm việc theo thứ tự ngày làm việc giảm dần


--13. theo thứ tự tăng dần và thứ tự ngày làm việc giảm dần


--14. Hiển thị 10 nhân viên với mã số, họ tên, lươn, ngày sinh, địa chỉ


-- 15. Hãy cho biết những nhân viên
-- không có người quản lý và có họ là Nguyễn và ở TP.HCM


-- 16. Hãy cho biết những nhân viên
-- có người quản lý và có lương > 10000 và ở TP.HCM


-- 17. Hãy cho biết những nhân viên
-- có người quản lý và có lương > 10000
-- và ở TP.HCM, sau đó sắp xếp tăng dần theo ngày vào làm và giảm dần theo lương


-- 18. Hãy hiển thị thông tin nhân viên
-- bao gồm mã số, họ tên, giới tính, lương và ngày làm việc
-- có lương > 30000
-- và sắp xếp theo thứ tự ngày sinh giảm dần và tăng dần theo ngày vào làm


--19. Hiển thị thông tin nhân viên có tên Giang và là nữ


--20.  Hiển thị nhân viên có họ Vũ mà là nữ ở HCM và HN


--21. Nhân viên có chữ lót là Hồng


-- Phần 2 : Các hàm phổ biến nâng cao
--22. Hiển thị thông tin nhân vien sinh tháng 2 


--23. Hiển thị thông tin mã nhân viên, tên nhân viên và tháng sinh\


--24. Tháng sinh lớn hơn 4


--25. Hiển thị thông tin mã nv, tên nv, tháng sinh, tháng sinh > 4 và sắp xếp giảm dần


--26. Hiển thị hân viên làm việc tại các tháng lẻ


--27. Hiển thị thông tin nhân viên có mã phòng ban là chẵn


--28. Hiển thị thông tin riêng biệt của nhân viên

--29. Hiển thị nhân viên có tuổi lớn hơn 40


--30. Liệt kê các mã nhân viên và quản lý


-------TRUY VẤN LỒNG (QUAN TRỌNG)--------
--31. Liệt kê tên những nhân viên và quản lý của nhân viên khác


--32. Liệt kê MS, tên, giới tính, địa chỉ của các nhân viên là quản lý của phòng ban


--33. Liệt kê MS, tên, giới tính, địa chỉ của các nhân viên là quản lý của phòng ban và đang quản lý nhân viên khác


--34. Liệt kê những nhân viên có người thân


--35. Liệt kê những nhân viên có tham gia làm dự án.


--36. Liệt kê những địa điểm đặt phòng ban


--37. Liệt kê những phòng ban có tham gia dự án


--38. Liệt kê những nhân viên tham gia dự án mà vừa làm quản lý phòng ban


--39. Liệt kê những nhân viên đang làm quản lý phòng ban

-- BÀI LUYỆN TẬP

--40. Hiển thị thông tin nhân viên có tháng sinh là chẵn


--41. Hiển thị thông tin nhân viên có tháng sinh là chẵn sau đó giảm dần theo năm sinh


--42. Hiển thị thông tin mã nhân viên, tên nhân viên, ngày sinh, tháng sinh và năm sinh > 1965


--43. Liệt kê tên, mã NV, số năm đi làm và tuổi ( tính theo năm ), biết rằng nhân viên ở TP.HCM hoặc Hà Nội


--44. Liệt kê mã NV, tên , lương, số năm đi làm và tuổi (tính theo năm), biết rằng nhân viên ở TP.HCM hoặc Hà Nội

--45. Hiển thị thông tin nhân viên có số năm đi làm lớn hơn 5.


--46. Hay liêt kê ma nhân viên, tên nhan viên, luong,so nam di lam và tuòi (tinh theo nam) biêt rang nhan viên & TP. Hö Chi Minh hoäc Hà Noi 
--sau dó, sap xep täng dän so nam di lam va giam dän theo theo tuổi


--47. Liệt kê những nhân viên là quản lý tại TP.HCM và Hà Nội sau đó sắp xếp tăng dần theo lương và giảm dần theo năm đi làm


--48. Liệt kê những nhân viên là quản lý mà là nữ có lương > 10000 và số năm đi làm nhỏ hơn 10 và tuổi lớn hơn 40



--49. Liệt kê mã NV, tên, lương NV , số tuổi, số năm đi làm, mà nhân viên quản lý là nam , lương > 10000, số năm đi làm < 10, tuổi > 40
--sắp xếp tăng dần theo lương và giảm theo số năm đi làm


--50. Hiển thị thông tin những nhân viên là quản lý , bắt đầu làm việc tại công ty vào tháng 2,4,6,8,10 và ở các tỉnh miền Nam , tuổi > 30
--sắp xếp lương tăng dần


-- Phần 3 : TRUY VẤN HÀM TỔNG HỢP ( count, sum, max, min )
--51. Đếm số lượng nhân viên


--52. Hãy cho biết có bao nhiêu nhân viên lương > 30000


--53. Cho biết bao nhiêu nhân viên là quản lý nhân viên khác


--54. Hãy tìm lương nhỏ nhất


--55. Hãy in ra bảng tổng hợp bao gồm (SLNV, lương nhỏ nhất, lương lớn nhất, lương trung bình, tổng lương)


--56. Hãy cho biết có bao nhiêu loại giới tính.


--59. Hãy tính tổng lương công ty phải trả hàng tháng

--60. Hãy đếm số lượng nhân viên không có quản lý


--61. Hãy tính tổng lương phải trả cho nhân viên giám sát hàng tháng


--62. Tính tuổi trung bình của quản lý phòng ban


-- Phần 4: TRUY VẤN GOM NHÓM VÀ ĐIỀU KIỆN TRÊN NHÓM

-- Dẫn nhập : Hiển thị mã NV, tên NV, lương, mã phòng ban, kỹ thuật đặt tên bảng emp.


--63. Hãy cho biết có bao nhiêu nhân viên mỗi phòng ban


--64. Hiển thị thêm mã phòng ban


--65. Hãy cho biết bảng thống kê về số lượng nhân viên,lương min ,max, avg,sum, trong mỗi phòng ban


--66. Hãy cho biết bảng thống kê về số lượng nhân viên,lương min ,max, avg,sum, trong mỗi phòng ban mà ở đó nhân viên > 4
--where : là điều kiện không dựa trên nhóm
--Having : là điều kiện dựa trên nhóm

--67. Hãy cho biết những phòng ban có số lượng nhân viên ở TP và có số lượng tối thiểu là 2 và sắp xếp giảm dần theo số lượng


--BÀI TẬP:
--68. Hãy cho biết mỗi mã nhân viên có bao nhiêu thân nhân-- select * from tblDependent

-- 69. Hãy cho biết mỗi nhân viên làm trên bao nhiêu dự án


-- 70. Hãy cho biết mỗi phòng ban được đặt tại bao nhiêu địa điểm


-- 71. Hãy cho biết mỗi địa điểm có bao nhiêu phòng ban


-- 72. Hãy cho biết mỗi địa điểm có bao nhiêu dự án, lấy những địa điểm có dự án
-- có số lượng tối thiểu là 2 và sắp xếp giảm dần theo số dự án


-- 73. Hãy cho biết mỗi nhân viên làm bao nhiêu giờ, trung bình số giờ làm,
-- số giờ ít nhất, số giờ làm nhiều nhất,
-- biết rằng chỉ trung bình giờ làm lớn hơn 2


-- 74. Hãy cho biết mỗi nhân viên giám sát thì giám sát bao nhiêu nhân viên

-- 75. Hãy cho biết lương trung bình của nhân viên giám sát


--TRUY VẤN LỒNG NÂNG CAO
--76. In ra các mã nhân viên , tên NV có lương nhỏ nhất


--77. Hãy cho biết có bao nhiêu nhân viên có lương lớn hơn mức trung bình của thành phố.


--78. Hãy liệt kê phòng ban, lương trung bình của phòng ban 
--mà có lương trung bình của nó lớn hơn trung bình lương của công ty.
-- sắp xếp theo lương trung bình phòng ban tăng dần


--79. Hãy liệt kê phòng ban, lương tb của phòng ban mà có lương trung bình của nó lớn hơn trung bình lương của công ty.
--lưu ý chỉ tính toán trên những nhân viên làm ở thành phố, sau đó sắp xếp giảm dần theo mã phòng ban


--80. Liệt kê mã nâhn viên, tên NV có giờ làm trung bình trên dự án lớn hơn 5.0 và ở thành phố.


--82. Hiển thị tên NV, tên phòng ban đang làm việc


--cách 2


--83. LIỆT KÊ TÊN NHÂN VIÊN, tên thân nhân và mối quan hệ


--84. Hãy cho biết tên dự án, tên địa điểm diễn ra dự án , ưu tiên hiển thị địa điểm



--85. Hãy cho biết mã nhân viên, tên nhân viên, tên phòng ban và tên thân nhân


--86. Hãy cho biết tên phòng ban và địa điểm đặt phòng ban


-- 87. Hãy cho biết tên phòng ban và các dự án do phòng ban quản lý
-- và địa điểm diễn ra dự án
-- Gợi ý: tblDepartment, tblProject, tblLocation


-- 88. Hãy cho biết tên dự án và tên nhân viên tham gia dự án
-- Gợi ý: tblProject, tblWorksOn và tblEmployee


-- 89. Hãy cho biết tên dự án, tên nhân viên tham gia dự án
-- và phòng ban nhân viên đó làm
-- Gợi ý: tblProject, tblWorksOn, tblEmployee và tblDepartment


-- 90. Hãy cho biết tên dự án, địa điểm diễn ra dự án
-- tên nhân viên tham gia dự án và phòng ban nhân viên đó làm
-- Gợi ý: tblLocation, tblProject, tblWorksOn, tblEmployee và tblDepartment


-- 91. Hãy cho biết tên thân nhân, tên nhân viên, tên phòng ban
-- và địa điểm của phòng ban
-- Gợi ý: tblDependent, tblEmployee, tblDepartment, tblDepLoc và tblLocation



-- 92. Hãy cho biết tên nhân viên và quản lý của nhân viên đó


-- 93. hãy cho biết tên phòng ban và tên nhân viên quản lý


-- 94. Hãy cho biết thông tin mã phòng, tên phòng
-- và mã nhân viên quản lý, tên nhân viên quản lý và lương người quản lý  > 50000


-- 95. Truy vấn để hiển thị danh sách
-- mã nhân viên không quản lý phòng ban nào hết và tên thân nhân
-- Gợi ý


-- 96. Hãy cho biết tên nhân viên, tên phòng ban
-- mà không có người thân


-- 97. Hãy cho biết tên nhân viên, tên phòng ban của những nhân viên làm giám sát và không có người thân


-- 98. Hãy cho biết tên nhân viên, tên phòng ban mà nhân viên đó không tham gia dự án nào.


--99. Hãy cho biết mã phòng ban, tên phòng ban và số lượng dự án mà phòng ban quản lý


--100. Hãy cho biết mã phòng ban, tên phòng ban, và số lượng dự án mà phòng ban quản lý có số lượng dự án > 1


--101. Hãy cho biết mã phòng ban, tên phòng ban, và số lượng dự án mà phòng ban quản lý có số lượng dự án > 1
-- mà làm bên phần mềm, sau đó giảm dần theo số dự án.


--102. Hãy cho biết mỗi nhân viên có bao nhiêu người thân và tên phòng ban.


-- 103. Hãy cho biết có bao nhiêu dự án ở mỗi địa điểm, hiển thị tên địa điểm


-- 104. Hãy cho biết tên mỗi phòng ban được đặt tại bao nhiêu địa điểm


-- 105. Hãy cho biết tên mỗi địa điểm và số lượng phòng ban ở đó

-- 106. Hãy cho biết tên nhân viên và số lượng dự án nhân viên tham gia


-- 107. Hãy cho biết tên dự án và số lượng nhân viên tham gia
