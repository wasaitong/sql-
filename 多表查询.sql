#建表
create table department(
id int,
name varchar(20) 
);

create table employee(
id int primary key auto_increment,
name varchar(20),
sex enum('male','female') not null default 'male',
age int,
dep_id int
);

#插入数据
insert into department values
(200,'技术'),
(201,'人力资源'),
(202,'销售'),
(203,'运营');

insert into employee(name,sex,age,dep_id) values
('egon','male',18,200),
('alex','female',48,201),
('wupeiqi','male',38,201),
('yuanhao','female',28,202),
('liwenzhou','male',18,200),
('jingliyang','female',18,204)
;

#查看表结构
desc department;

# 查看表数据
select * from department;
select * from employee;

#笛卡尔积
select * from department,employee; 
#一个员工和4个部门都做了一次匹配，笛卡尔积，发生了交叉连接
#单纯得笛卡尔积没有意义，只是简单粗暴的将所有数据集合在一起

#要得到有意义的表需要加where 
select * from employee,department where employee.dep_id=department.id;

#内连接
select * from employee inner join department on employee.dep_id=department.id;

#左连接
select * from employee left join department on employee.dep_id=department.id;

#右连接
select * from employee right join department on employee.dep_id=department.id;

#全连接（左连接和右连接）
select * from employee left join department on employee.dep_id=department.id
union
select * from employee right join department on employee.dep_id=department.id;


#查询平均年龄大于30岁的部门名
select department.name,avg(age) from employee inner join department on employee.dep_id=department.id group by department.name having avg(age)>30;

#
select name from department where id in 
(select dep_id from employee group by dep_id having avg(age)>25);

#
select name from employee where dep_id in
(select id from department where name='技术');

#不足一人
select name from department where id not in
(select dep_id from employee group by dep_id having count(id)>=1);


#带比较运算符的子查询
#查询大于所有人平均年龄的员工名与年龄
select name,age from employee where age>
(select avg(age) from employee);

#exists 
select * from employee where exists
(select id from department where name = 'IT');






