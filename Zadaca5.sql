use SEDCHome

-- Homework 02.1
go
create or alter proc CreateGrade (@StudentID int, @TeacherID int, @Grade decimal(18,2), @CourseID int)
as
begin
	insert into Grade(StudentID, TeacherID, Grade, CreatedDate, CourseID)
	values (@StudentID, @TeacherID, @Grade, GETDATE(), @CourseID)

	select count(*) as TotalGrades
	from Grade
	where StudentID = @StudentID

	select max(Grade) as MaxGrade
	from Grade
	where StudentID = @StudentID and TeacherID = @TeacherID

end

exec CreateGrade 1, 2, 10.00, 4

-- Morao sam da dodam kolone CourseID i Date, prijavljuje gresku



-- Homework 02.2
go
create or alter proc CreateGradeDetail(
@GradeID int, 
@AchievementTypeID int, 
@AchievementPoints int, 
@AchievementMaxPoints int,
@ParticipationRate int
)
as
begin
	insert into GradeDetails(GradeID, AchievementTypeID, AchievementPoints, AchievementMaxPoints, AchievementDate)
	values (@GradeID, @AchievementTypeID, @AchievementPoints, @AchievementMaxPoints, GETDATE())

	select sum(GD.AchievementPoints * 1.0 / GD.AchievementMaxPoints * A.ParticipationRate) as GradePoints
	from GradeDetails GD
	inner join AchievementType A on GD.ID = A.ID
	where GradeID = @GradeID

end

exec CreateGradeDetail 1, 2, 50, 20, 4

