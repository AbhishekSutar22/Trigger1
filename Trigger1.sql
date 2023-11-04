use abhishek
go
select * from student
go
-- student audit table
--this table cotains all logs of admissions 

create table studentaudit
(
Id int primary key identity,
Description varchar(500),
AuditDate date
)

select * from studentaudit

create Trigger Tr_student_insert
on student
for insert
as 
begin 
print 'Abhishek'
end


exec sp_helptext Tr_student_insert

alter Trigger Tr_student_insert  
on student  
for insert  
as   
begin   
declare @Rollnumber int ,@name varchar(50)
select @Rollnumber = Rollnumber , @name = name from inserted

declare @Description varchar(500) = 'student with rollnumber '+'  '
set @Description = @Description + cast(@Rollnumber as varchar(5))+'  ' + 'and name'+ '  '+ @name + '  ' +
'taken admission on'+'  ' + cast(getdate() as varchar(100))

insert into studentaudit values (@Description, getdate())

end  

go

select * from student
select * from studentaudit 

insert into student values(12,'Rahul','Pune',2,'Male',40)

delete from student where Rollnumber = 12
 
 create Trigger Tr_student_Delete
on student
instead of delete
as 
begin 
print 'Abhishek'
end

exec sp_helptext Tr_student_delete
 alter Trigger Tr_student_Delete  
on student  
for delete  
as   
begin   
declare @Rollnumber int, @name varchar(50)
select @Rollnumber = Rollnumber, @name = name from deleted

declare @Description varchar(500)
set @Description = 'student with rollnumber ' + cast(@Rollnumber as varchar(5))+ ' and name ' +
@name + ' cancelled admission on ' + cast(getdate() as varchar(100))
end

select * from student
select * from studentaudit 

delete from student where Rollnumber = 11


alter trigger tr_student_insert
on student
for delete
as 
begin
declare @Rollnumber int,@name varchar(500)


select  @Rollnumber=Rollnumber,@name=name from deleted
declare @description varchar(500) 
set @description ='student with rollnumber'+ '  ' + cast(@Rollnumber as varchar(5)) +'  '+ 'and name' + '  ' +
@name + ' cancelled  admission on' + '  ' + cast(getdate() as varchar(100))
insert into studentaudit values(@description,getdate())
end

delete from student where Rollnumber = 10

select * from student
select * from studentaudit 

-- update data

alter Trigger Tr_student_update
on student
for update
as 
begin 
declare @Rollnumber int, @OldName varchar(50), @NewName varchar(50), @OldCity varchar(50),
@NewCity varchar(50)
select @Rollnumber = Rollnumber, @OldName = Name, @OldCity = City from deleted
select @NewName = Name, @NewCity = City from inserted

declare @Description varchar(500) = 'student with Rollnumber ' + cast(@Rollnumber as varchar(5)) + 
'updated '

if @OldName <> @NewName
set @Description = @Description + 'name from ' + @OldName + ' to ' + @NewName

if @OldCity <> @NewCity
set @Description = @Description + 'city from ' + @OldCity + ' to ' + @NewCity

set @Description = @Description + ' on ' + cast(getdate() as varchar(100))

insert into studentaudit values (@Description, getdate())

end

update student set name = 'Abhishek', city = 'Pune' where Rollnumber = 1

select * from student
select * from studentaudit 

create trigger Tr_B22_student_table_creation
on database
for create_table
as
begin
print 'B22 database table creation is restricted'
rollback
end

go

create  table v2(Id int)

use ArchivedDB

create  table v2(Id int)

use abhishek
create trigger Tr_B22_student_table_creation
on all server
for create_table
as
begin
print 'B22 database table creation is restricted'
rollback
end

use ArchivedDB
create  table v3(Id int)

use abhishek
create  table v3(Id int)




