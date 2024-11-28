create database QuanLyDichVuKhachSan
go
use QuanLyDichVuKhachSan
go
create table LoaiDV
(
	ID_LoaiDV	int primary key identity(1,1),
	TenLoai		nvarchar(30) not null,
	Enable		tinyint,
)
go

SELECT l.ID_LoaiDV, l.TenLoai, d.TenDV, d.DonGia, d.GhiChu, l.Enable, d.Enable
FROM LoaiDV l
JOIN DichVu d ON l.ID_LoaiDV = d.ID_LoaiDV
WHERE l.Enable = 0 AND d.Enable = 0
ORDER BY l.ID_LoaiDV, d.TenDV

create table DichVu
(
	ID_DichVu	int primary key identity (1,1),
	ID_LoaiDV	int references LoaiDV(ID_LoaiDV) not null,
	TenDV		nvarchar(30) not null,
	DonGia		float not null,
	GhiChu		nvarchar(3000),
	Enable		tinyint,
)
go

create table KhachHang
(
	ID_KhachHang	int primary key identity(1,1),
	HoTen			nvarchar(30) not null,
	SoDT_KH			char(10) not null,
	SoCC_KH			char(10) not null,
	GhiChu			nvarchar(3000),
	Enable			tinyint,
)
go

create table NhanVien
(
	ID_NV		int primary key identity(1,1),
	TenDN		nvarchar (30) not null,
	MatKhau		char(10) not null,
	HoTen		nvarchar(30) not null,
	SoDT_NV		char(10) not null,
	SoCC_NV		char(20) not null,
	NgaySinh	smalldatetime,
	GioiTinh	bit, -- 0: nữ; 1: nam (vì sql ko có kiểu bool)
	VaiTro		nvarchar(30) not null,
	DiaChi		nvarchar(50),
	NgayThoiViec	smalldatetime,
	GhiChu		nvarchar(3000),
	Enable		tinyint
)
go

create table HoaDon
(
	ID_HD			int primary key identity(1,1),
	ID_NV			int references NhanVien(ID_NV) not null,
	ID_KhachHang	int references KhachHang(ID_KhachHang) not null,
	NgayLap			datetime not null,
	ThanhTien		float not null,
	GiamGia			float,
	Coc				float,
	TongTien		float not null,
	Enable			tinyint,
)
go

create table CT_HD
(
	ID_HD		int references HoaDon(ID_HD),
	ID_DV		int references DichVu(ID_DichVu),
	SoLuong		int not null,
	ThanhTien	float,
	Ngay		datetime,
	primary key (ID_HD, ID_DV)
)
go

----- Thêm dữ liệu vào các bảng
insert into	LoaiDV (TenLoai, Enable)
values (N'Nhà Hàng', 0), (N'Spa', 0), (N'Giặt ủi', 0), (N'Thuê xe', 0)

go

insert into DichVu (ID_LoaiDV, TenDV, DonGia, GhiChu, Enable)
values	(1, N'Mỳ ly', 30000, '', 0), (1, N'Coca', 20000, '', 0), (1, N'Mỳ quảng', 50000, '', 0),
		(1, N'Bánh canh', 50000, '', 0), (1, N'Phở', 50000, '', 0), 
		(1, N'Nước ép', 35000, N'Không đường', 0), (1, N'Caphe', 40000, N'Ít sữa', 0),
		(2, N'Gội đầu', 100000, N'Không dùng dầu gội chứa silicon', 0),
		(2, N'Massage', 200000, '', 0), (2, N'Chăm sóc da', 300000, '', 0), (2, N'Nặn mụn', 250000, '' , 0),
		(3, N'Giặt ướt', 50000, '', 0), (3, N'Giặt khô', 60000, '', 0),
		(4, N'Xe ga', 20000, '', 0), (4, N'Xe số', 60000, '', 0)

go

set dateformat dmy 
go
insert into NhanVien (TenDN, MatKhau, HoTen, SoDT_NV, SoCC_NV, NgaySinh, GioiTinh, VaiTro, DiaChi, NgayThoiViec, GhiChu, Enable)
values	('HoangTX', '1234', N'Trần Xuân Hoàng', '0275863537', '0976482490', '07/04/1997', 1, N'Chủ', N'45 An Dương Vương', '', '', 0),
		('XuanHV', '1234', N'Hoàng Viết Xuân', '0878545635', '0772864375', '09/07/1999', 1, N'Quản Lý', N'5/10 Hà Huy Tập', '', '', 0),
		('YDN', '1234', N'Đăng Như Ý', '0687455324', '0887633221', '12/08/2000', 0, N'Nhân viên', N'80 Nguyễn Đình Chiểu', '07/06/2023', '', 0),
		('TuNX', '1234', N'Ngô Xuân Tú', '0098985764', '0974316587', '11/11/2001', 0, N'Nhân viên', N'70/ 108 Phan Nhật Duật', '', N'Chỉ làm ca sáng', 0)
		select  * from KhachHang
insert into KhachHang (HoTen, SoDT_KH, SoCC_KH, GhiChu, Enable)
values	(N'Nguyễn Xuân Thắng', '0345627899', '1000000002', '', 0),
		(N'Nguyễn Đức Duy Ân', '0967262184', '1690000005', '', 0),
		(N'Nguyễn Quốc Anh', '0785324678', '1460576438', '', 0),
		(N'Lê Nhật Ánh', '0788743225', '666855856', '', 0),
		(N'Võ Thị Thu Ngân', '0976542268', '113325564', '', 0),
		(N'Hứa Duy Băng', '0898674532', '1013579065', '', 0),
		(N'Lê Thuỳ Lam Chi', '0642175789', '2456767737', '',0),
		(N'Trần Huỳnh Bảo', '0765267854', '6534758766', '', 0),
		(N'Phan Đình Huỳnh Bảo', '0878765325', '6076245899', '', 0),
		(N'Nguyễn Gia Bảo', '0865256709', '8757536432', '', 0)
go

select * from NhanVien
select * from KhachHang

set dateformat dmy
go
insert into HoaDon (ID_NV,ID_KhachHang,NgayLap,ThanhTien,GiamGia,Coc,TongTien)
values  (3, 1, '24/11/2024', 500000, 50000, 100000, 450000), 
		(4, 2, '25/11/2024', 750000, 75000, 150000, 675000), 
		(3, 3, '26/11/2024', 600000, 60000, 120000, 540000), 
		(4, 4, '27/11/2024', 850000, 85000, 170000, 765000),
		(4, 5, '28/11/2024', 400000, 40000, 80000, 360000),
		(4, 6, '29/11/2024', 550000, 55000, 110000, 495000), 
		(3, 7, '30/11/2024', 700000, 70000, 140000, 630000),
		(4, 8, '2/12/2024', 800000, 80000, 160000, 720000), 
		(3, 9, '6/12/2024', 450000, 45000, 90000, 405000), 
		(3, 10, '22/12/2024', 300000, 30000, 60000, 270000)
go

select * from HoaDon

set dateformat dmy
go
insert into CT_HD (ID_HD, ID_DV, SoLuong, ThanhTien, Ngay)
values 
(1, 3, 2, 200000, '24/11/2024'),
(1, 1, 1, 150000, '4/11/2024'),
(2, 6, 3, 300000, '21/11/2024'),
(2, 7, 2, 250000, '25/11/2024'), 
(3, 3, 1, 100000, '26/11/2024'), 
(3, 4, 4, 400000, '27/11/2024'), 
(4, 3, 2, 200000, '23/11/2024'),
(4, 4, 1, 150000, '17/11/2024'), 
(3, 5, 3, 300000, '9/11/2024'),
(3, 2, 2, 250000, '08/11/2024'), 
(2, 1, 1, 100000, '3/11/2024'), 
(4, 2, 4, 400000, '11/11/2024'),
(4, 7, 2, 200000, '22/11/2024'), 
(1, 4, 1, 150000, '15/11/2024'),
(2, 3, 3, 300000, '24/12/2024'),
(4, 1, 2, 250000, '19/12/2024'), 
(3, 1, 1, 100000, '3/12/2024'), 
(1, 5, 4, 400000, '13/12/2024'), 
(2, 4, 2, 200000, '4/12/2024'), 
(1, 6, 1, 150000, '14/12/2024')
go
select * from CT_HD
	


----- Các thủ tục và hàm -----

create proc LayDS_LoaiDV
AS
BEGIN
	select	ID_LoaiDV, TenLoai
	from	LoaiDV
	where	Enable = 0
END
GO

create proc ThemXoaSua_LoaiDV
	@id int output, @ten nvarchar(30), @hanhdong int
AS
BEGIN
	if @hanhdong = 0 -- Thêm loại dịch vụ
		begin
			insert into LoaiDV (TenLoai, Enable) values (@ten, 0)
			select @id = SCOPE_IDENTITY()
		end
	else if @hanhdong = 1 -- Sửa thông tin loại dịch vụ 
		begin
			update	LoaiDV
			set		TenLoai = @ten
			where	ID_LoaiDV = @id
		end
	else if @hanhdong = 2 -- Xoá loại dịch vụ 
		begin
			update LoaiDV
			set		Enable = 1
			where	ID_LoaiDV = @id
		end
END
GO

create proc LayDS_DV_LoaiDV		@idloaidv int
AS 
BEGIN
	select	ID_DichVu, TenLoai TenDV, DonGia, GhiChu
	from	DichVu dv, LoaiDV l
	where	dv.Enable = 0 and dv.ID_LoaiDV = l.ID_LoaiDV and dv.ID_LoaiDV = @idloaidv
END
GO

create proc LayDS_DichVu
AS
BEGIN
	select	ID_DichVu, TenLoai TenDV, DonGia, GhiChu
	from	DichVu dv, LoaiDV l
	where	dv.Enable = 0 and dv.ID_LoaiDV = l.ID_LoaiDV
END
GO

create proc ThemXoaSua_DichVu
	@iddv int output, @idloai int, @tendv nvarchar(30), @dongia float, @ghichu nvarchar(3000), @hanhdong tinyint
AS
BEGIN
	if @hanhdong = 0	--Thêm dịch vụ
		begin
			insert into DichVu (ID_LoaiDV, TenDV, DonGia, GhiChu, Enable)
			values (@idloai, @tendv, @dongia, @ghichu, 0)
			select @iddv = SCOPE_IDENTITY()
		end
	else if @hanhdong = 1 -- Cập nhật thông tin dịch vụ
		begin
			update DichVu
			set
				ID_LoaiDV = @idloai,
				TenDV = @tendv,
				DonGia = @dongia,
				GhiChu = @ghichu
			where	ID_DichVu = @iddv
		end
	else if @hanhdong = 2 --Xoá dịch vụ
		begin
			update	DichVu
			set		Enable = 1
			where	ID_DichVu = @iddv
		end
END
GO

create proc LayDS_KhachHang
AS
BEGIN
	select	ID_KhachHang, HoTen, SoDT_KH, SoCC_KH, GhiChu
	from	KhachHang
	where	Enable = 0
END
GO

create proc ThemXoaSua_KhachHang
	@idkh int output, @hoten nvarchar(30), @sdt char(10), 
	@cccd char(10), @ghichi nvarchar(3000), @hanhdong tinyint
AS
BEGIN
	if @hanhdong = 0	-- Thêm khách hàng
		begin
			insert into	KhachHang (HoTen, SoDT_KH, SoCC_KH, GhiChu, Enable)
			values (@hoten, @sdt, @cccd, @ghichi, 0)
			select @idkh = SCOPE_IDENTITY()
		end
	else if @hanhdong = 1	-- Cập nhật thông tin khách hàng
		begin
			update KhachHang
			set
				HoTen = @hoten,
				SoDT_KH = @sdt,
				SoCC_KH = @cccd,
				GhiChu = @ghichi
			where	ID_KhachHang = @idkh
		end
	else if @hanhdong = 2	-- Xoá khách hàng
		begin
			update	KhachHang
			set		Enable = 1
			where	ID_KhachHang = @idkh
		end
END
GO

create proc LayDS_NhanVien
AS
BEGIN
	select	ID_NV, MatKhau, HoTen, SoDT_NV, SoCC_NV, NgaySinh, GioiTinh, VaiTro, DiaChi, NgayThoiViec, GhiChu
	from	NhanVien
	where	Enable = 0
END
GO

create proc ThemXoaSua_NhanVien
	@idnv int output,
	@tendn nvarchar(30),
	@matkhau char(10),
	@hoten nvarchar(30),
	@sdt char(10),
	@cccd char(20),
	@ngaysinh smalldatetime,
	@gioitinh bit,
	@vaitro nvarchar(30),
	@diachi nvarchar(50),
	@ngaythoiviec smalldatetime,
	@ghichu nvarchar(3000),
	@hanhdong tinyint
AS
BEGIN
	if @hanhdong = 0	-- Thêm nhân viên
		begin
			insert into NhanVien (TenDN, MatKhau, HoTen, SoDT_NV, SoCC_NV, NgaySinh, GioiTinh, VaiTro, DiaChi, NgayThoiViec, GhiChu, Enable)
			values (@tendn, @matkhau, @hoten, @sdt, @cccd, @ngaysinh, @gioitinh, @vaitro, @diachi, @ngaythoiviec, @ghichu, 0)
			select @idnv = SCOPE_IDENTITY()
		end
	else if @hanhdong = 1	-- Cập nhật thông tin nhân viên
		begin
			update NhanVien
			set
				TenDN = @tendn,
				MatKhau = @matkhau,
				HoTen = @hoten,
				SoDT_NV = @sdt,
				SoCC_NV = @cccd,
				NgaySinh = @ngaysinh,
				GioiTinh = @gioitinh,
				VaiTro = @vaitro,
				DiaChi = @diachi,
				NgayThoiViec = @ngaythoiviec,
				GhiChu = @ghichu
			where	ID_NV = @idnv
		end
	else if @hanhdong = 2	-- Xoá nhân viên
		begin
			update	NhanVien
			set		Enable = 1
			where	ID_NV = @idnv
		end
END
GO

create proc LayDS_HoaDon
AS
BEGIN
	select	ID_HD, n.HoTen, k.HoTen, NgayLap, ThanhTien, GiamGia, Coc, TongTien
	from	HoaDon h, NhanVien n, KhachHang k
	where	h.ID_NV = n.ID_NV and h.ID_KhachHang = k.ID_KhachHang
END
GO

create proc LayDS_HD_Ngay	@ngaybd smalldatetime, @ngaykt smalldatetime
AS
BEGIN
	select	ID_HD, n.HoTen, k.HoTen, NgayLap, ThanhTien, GiamGia, Coc, TongTien
	from	HoaDon h, NhanVien n, KhachHang k
	where	h.ID_NV = n.ID_NV and h.ID_KhachHang = k.ID_KhachHang and NgayLap between @ngaybd and @ngaykt
END
GO

create proc ThemXoaSua_HoaDon
	@idhd int output,
	@idnv int,
	@idkh int,
	@ngaylap smalldatetime,
	@thanhtien float,
	@giamgia float,
	@coc int,
	@tongtien float,
	@hanhdong tinyint
AS
BEGIN
	if @hanhdong = 0	-- Thêm hoá đơn
		begin
			insert into	HoaDon (ID_NV, ID_KhachHang, NgayLap, ThanhTien, GiamGia, Coc, TongTien, Enable)
			values (@idnv, @idkh, @ngaylap, @thanhtien, @giamgia, @coc, @TongTien, 0)
			select @idhd = SCOPE_IDENTITY()
		end
	else if @hanhdong = 1	-- Cập nhật thông tin hoá đơn
		begin
			update HoaDon
			set
				ID_NV = @idnv,
				ID_KhachHang = @idkh,
				NgayLap = @ngaylap,
				ThanhTien = @thanhtien,
				GiamGia = @giamgia,
				Coc = @coc,
				TongTien = @tongtien
			where	ID_HD = @idhd
		end
	else if @hanhdong = 2	-- xoá hoá đơn
		begin
			update	HoaDon
			set		Enable = 1
			where	ID_HD = @idhd
		end
END
GO

create proc LayDS_CT_HD_HD	@idhd int
AS
BEGIN
	select	ID_HD, TenDV, SoLuong, ThanhTien, Ngay
	from	CT_HD c, DichVu d
	where	c.ID_DV = d.ID_DichVu and c.ID_HD = @idhd 
END
GO
SELECT ID_KhachHang, HoTen, SoDT_KH, SoCC_KH, GhiChu FROM KhachHang WHERE HoTen LIKE 'Phan'
create proc ThemXoaSua_CT_HD
	@idhd int, @iddv int, @sl int, @thanhtien float, @ngay datetime, @hanhdong tinyint
AS
BEGIN
	if @hanhdong = 0	-- Thêm chi tiết hoá đơn
		begin
			insert into	CT_HD (ID_HD, ID_DV, SoLuong, ThanhTien, Ngay)
			values (@idhd, @iddv, @sl, @thanhtien, @ngay)
		end
	else if @hanhdong = 1	-- Cập nhật thông tin chi tiết hoá đơn
		begin
			update	CT_HD
			set
				ID_HD = @idhd,
				ID_DV = @iddv,
				SoLuong = @sl,
				ThanhTien = @thanhtien,
				Ngay = @ngay
			where	ID_HD = @idhd and ID_DV = @iddv
		end 
	else if @hanhdong = 2	-- Xoá chi tiết hoá đơn
		begin
			delete from	CT_HD 
			where ID_HD = @idhd and ID_DV = @iddv
		end
END
GO


SELECT * FROM [LoaiDV]
CREATE PROCEDURE InsertDV
@id int output,
@ten nvarchar(3000), 
@loaidv nvarchar(3000), 
@dongia int, 
@hinh int,  
@notes nvarchar(3000)
AS
	INSERT INTO [DichVu]
	([TenDV],[ID_LoaiDV],[DonGia],Enable)
	VALUES ( @ten, @loaidv, @dongia)

	SELECT @id = SCOPE_IDENTITY()

go
CREATE PROCEDURE [UpdateDV] 
	@id int output,
	@ten nvarchar(3000), 
	@loaidv nvarchar(3000), 
	@dongia int, 
	@hinh int,  
	@notes nvarchar(3000)
AS
UPDATE [DichVu]
SET
	[ID_DichVu] = @id
	[TenDV]=@ten,
	[ID_LoaiDV]= @loaidv,
	[DonGia]=@dongia

WHERE [ID_DichVu] = @id

IF @@ERROR <> 0
RETURN 0
ELSE
RETURN 1
GO
