create table Estudiante(
	Id bigserial primary key not null,
	Nombre varchar(60) not null,
	Apellido  varchar(60),
	Fecha_Matricula date
)


create table Profesor (
	Id bigserial not null primary key,
	Nombre varchar(60),
	Apellido  varchar(60),
	correo varchar(150)
)


create table Curso (
	Id bigserial not null primary key,
	Nombre varchar(60),
	Fecha_Inicio date,
	Fecha_Final date,
	id_profesor integer, 
	constraint fk_profesor
		foreign key (id_profesor)
		references profesor(id)
		on delete cascade
)


create table Matricula (
	id_estudiante integer,
	id_curso integer, 
	foreign key (id_estudiante) references estudiante(id),
	foreign key (id_curso) references curso(id)
	on delete cascade
)


-- Poblar Tablas
insert into profesor (nombre, apellido, correo) 
	values 
		('josse', 'zuñiga', 'josse.z@larnu.com'),
		('emiliano', 'rotta', 'emiliano.r@larnu.com'),
		
		

insert into curso (nombre, fecha_inicio , fecha_final, id_profesor) 
	values 
		('Primera Generacion ', '13-06-2022', '13-10-2022', 1),
		('Segunda Generacion ', '11-07-2022', '11-11-2022', 2),
		('Tercera Generacion ', '22-08-2022', '22-12-2022', 1);
		

insert into estudiante  (nombre, apellido, fecha_matricula) 
	values 
		('Robert', 'Velasco', '13-06-2022'),
		('antony', 'Ure', '13-06-2022'),
		('Estebanh', 'Hurtado', '13-06-2022'),
		('Cesar', 'Agusto', '13-06-2022'),
		('isa', 'Valenzuela', '13-06-2022'),
		('ellis', 'Velandia', '13-06-2022'),
		('Andres', 'Cuellar', '13-06-2022'),
		('sefhiroth', 'perez', '13-06-2022'),
		('Hugo', 'Hernandez', '11-07-2022'),
		('cristian', 'carhuas', '11-07-2022'),
		('Estuardo', 'Chancusig', '11-07-2022'),
		('Peter', 'Neville', '11-07-2022'),
		('jhen', 'nunez', '11-07-2022'),
		('carlos', 'martinez', '22-08-2022'),
		('catalina', 'castillo', '22-08-2022'),
		('christoper', 'calvachi', '22-08-2022'),
		('elena', 'mazo', '22-08-2022'),
		('jose', 'peralta', '22-08-2022');
		

-- consultas 
-- mostrar por cada tabla su contenido
	
select * from public.estudiante e ;
select * from public.curso c  ;
select * from public.profesor p  ;

-- Mostrar que curso tiene asignado cada docente con su fecha de inicio
select p.nombre , p.apellido, c.nombre, c.fecha_inicio 
from public.profesor p
inner join curso c ON p.id  = c.id_profesor;


-- mostrar que docente no tiene curso asignado 
select p.nombre , p.apellido, c.nombre, c.fecha_inicio
from public.profesor p
left join public.curso c ON p.id  = c.id_profesor
where c.nombre is null; 

-- mostrar los estudiantes con el nombre del curso 
select e.nombre, e.apellido, c.nombre
from public.estudiante e
join public.matricula as m on m.id_estudiante = e.id 
join public.curso as c on m.id_curso = c.id;


-- contar cuantos estudiantes pertenecen a la Primera generacion
select count(*) as Primera_Generacion
from estudiante e 
join matricula as m on m.id_estudiante = e.id 
join curso as c on m.id_curso = c.id
where c.id = 1;


-- Contar la cantidad de estudiantes por generacion
select c.nombre as Generacion, count(c.nombre) as Cantidad_Estudiantes
from public.estudiante e 
join public.matricula as m on m.id_estudiante = e.id 
join public.curso as c on m.id_curso = c.id
where c.nombre in ('Primera Generacion', 'Segunda Generacion', 'Tercera Generacion')
group by c.nombre;

-- mostrar los estudiantes que tiene asignado el docente josse zuñiga
select (e.nombre || ' ' ||e.apellido)as Nombre_Completo, c.nombre as Curso, (p.nombre|| ' '||p.apellido) as Docente
from public.estudiante e 
join public.matricula as m on m.id_estudiante = e.id 
join public.curso as c on m.id_curso = c.id 
join public.profesor p on c.id_profesor = p.id 
where p.nombre in ('josse') and p.apellido in ('zuñiga')
order by 2;
