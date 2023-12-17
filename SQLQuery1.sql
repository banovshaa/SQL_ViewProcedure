Create database Kitabxana
use Kitabxana

Create Table Books
(
Id int identity primary key,
Name nvarchar(100) Check(Len(Name)>2),
PageCount int Check(PageCount>10)
)

Create Table Authors
(
Id int identity primary key,
Name nvarchar(100) Check(Len(Name)>2),
SurName nvarchar(100) Check(Len(SurName)>2),
)

Create Table BooksAndAuthors
(
Id int identity primary key,
AuthorId int foreign key references Authors(Id),
BookId int foreign key references Books(Id)
)
Select * From Books
Select * From Authors
Insert Into Books 
Values
('Book1',100),
('Book2',200),
('Book3',300),
('Book4',400),
('Book5',500)

Insert Into Authors
Values
('Ad1','Sur1'),
('Ad2','Sur2'),
('Ad3','Sur3')

Insert Into BooksAndAuthors
Values
(3,2),
(4,3),
(5,1),
(3,4),
(4,5)

Create view Vw_GetBookDetails
as
Select b.Id, b.Name ,b.PageCount , a.Name + ' ' + a.SurName as 'AuthorFullName'
from BooksAndAuthors ba
Join Books b
on b.Id = ba.BookId
Join Authors a
on a.Id = ba.AuthorId

Select * from Vw_GetBookDetails

create procedure SP_InsertIntoBooks
 @search nvarchar(200)
 as
 begin 
 Select * from Vw_GetBookDetails
 Where Name like '%'+@search+'%'
 end

 exec SP_InsertIntoBooks 'book1'

 create procedure Sp_InsertIntoAuthors
 @name nvarchar(100),
 @surName nvarchar(100)
 as
 begin 
 Insert Into Authors
 Values
 (@name,@surName)
 end

  exec Sp_InsertIntoAuthors 'author4','surname4'

  Select * from Authors

  create procedure SP_DeleteFromAuthors
  @id int 
  as
  begin 
  Delete from Authors
  Where Id = @id
  end

 exec SP_DeleteFromAuthors 6

 create procedure SP_UpdateFromAuthors
  @id int,
  @name nvarchar(100),
  @surName nvarchar(100)
  as
  begin 
  Update  Authors
  set 
  Name = @name,
  SurName = @surName
  Where Id = @id
  end

  exec SP_UpdateFromAuthors 5 , 'upd','upd'

 Create View Vw_GetAuthorDetails
  as
  Select
  a.Id as 'AuthorId', 
  Max(b.PageCount ) as 'MaxPageCunt',
  Count(*) as 'BookCount',
  a.Name + ' ' + a.SurName as 'AuthorFullName'
from BooksAndAuthors ba
Join Books b
on b.Id = ba.BookId
Join Authors a
on a.Id = ba.AuthorId
Group By a.Name, a.Surname, a.Id

Select * From Vw_GetAuthorDetails