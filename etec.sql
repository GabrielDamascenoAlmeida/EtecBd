create database  etec;
use etec;
 
create table student(
id int primary key auto_increment unique,
fullname varchar(100), 
age int, 
cpf char (11) unique,
email varchar (100) unique,
tel varchar (11) unique,
 
id_class  int,
id_period int,
id_responsible int,
foreign key (id_class) references class(id),
foreign key (id_period) references period(id),
foreign key (id_responsible) references responsible(id)
);
 
create table responsible(
id int primary key auto_increment,
fullname varchar(50),
tel  varchar (11) unique,
email varchar(100) unique,
cpf char (11) unique
);
 
create table teacher(
id int primary key auto_increment unique,
fullName varchar (100),
tel varchar (11) unique,
cpf char (11) unique,
`year_of_hire` date,
`year_of_departure` date
);
 
create table  course_subject(
id int primary key auto_increment,
`name` varchar (70), 
id_class int, 
id_teacher int,

foreign key (id_teacher) references teacher(id),
foreign key (id_class) references class(id)
);

create table status_student(
id int primary key auto_increment,
id_student int,
id_subject int,
note_student varchar(2),
`number_of_absences` int,
approved bool,

foreign key (id_student) references student(id),
foreign key (id_subject) references course_subject(id)
);
 
create table class(
id int primary key auto_increment unique,
`name` varchar(20),
room_number int,
number_students int (40),
floor int,
id_period int,
foreign key (id_period) references period(id)
);
 
create table period(
id int primary key auto_increment unique,
name_period varchar(10),
start_period time,
end_period time 
);
 
create table course(
id int primary key auto_increment unique,
name_course varchar (40),

id_teacher int,
id_class int,
id_period int,
foreign key (id_teacher) references teacher(id),
foreign key (id_class) references class(id),
foreign key (id_period) references period(id)
); 

create table student_records(
id_student int,
id_subject int,
note_student decimal,
`number_of_absences` int,

foreign key (id_student) references student(id),
foreign key (id_subject) references course_subject(id)
);

select * from student;
select * from responsible;
select * from teacher;
select * from course_subject;
select * from class;
select * from period;
select * from course;  
select * from status_student;

/*Liste os alunos de uma turma*/
select * from student where id_class=1;
select * from student where id_class=2;

/*Liste as disciplinas de uma turma*/
select * from course_subject where id_class=1;
select * from course_subject where id_class=2;

/*Listar Turmas do curso*/
select class.`name`,
course.name_course
from course
inner join class on course.id_class;

/*Liste alunos reprovados de uma turma*/
select student.fullname,
course_subject.`name`,
status_student.approved
from status_student
inner join student on id_student = student.id
inner join course_subject on id_subject = course_subject.id
where approved=0 /*Aqui aparece 0 pois o valor está em boolean*/