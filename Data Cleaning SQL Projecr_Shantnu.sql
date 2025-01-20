-- DATA CLEANING

select * from layoffs;

create table layoffs_staging
like layoffs;

select * from layoffs_staging;

insert layoffs_staging
select * from layoffs;

select * from layoffs_staging;

select *, row_number() over(partition by company, industry, total_laid_off, percentage_laid_off, `date`) as row_num
from layoffs_staging;

With duplicate_cte as
(select *, row_number() over(partition by company, industry, total_laid_off, percentage_laid_off, `date`) as row_num
from layoffs_staging)
select * from duplicate_cte
where row_num > 1;


select * from layoffs_staging
where company = 'Oda';


With duplicate_cte as
(select *, row_number() 
over(partition by company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions)
 as row_num
from layoffs_staging)
select * from duplicate_cte
where row_num > 1;


select * from layoffs_staging
where company = 'Casper';


CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;


select * from layoffs_staging2;

Insert into layoffs_staging2
select *, row_number() over(
partition by company, location, industry, total_laid_off, `date`, percentage_laid_off, 
stage, country, funds_raised_millions) as row_num
from layoffs_staging;

select * from layoffs_staging2;

select * from layoffs_staging2
where row_num > 1;

delete from layoffs_staging2
where row_num > 1;

select * from layoffs_staging2;


-- STANDARDIZING

select distinct(Trim(company)), company
from layoffs_staging2;


select company, trim(company)
from layoffs_staging2;

update layoffs_staging2
set company = trim(company);


select distinct industry
 from layoffs_staging2;
 
 select distinct industry
 from layoffs_staging2
 order by 1;
 
 Select * from layoffs_staging2
 where industry like "crypto%";
 
 update layoffs_staging2
 set industry = "Crypto"
 where industry like "Crypto%";
 
 Select * from layoffs_staging2
 where industry like "crypto%";
 
 select distinct industry
 from layoffs_staging2;
 
select distinct location
 from layoffs_staging2
 order by 1;
 
 
 select *
 from layoffs_staging2
 order by 1;
 
 select distinct country
 from layoffs_staging2
 order by 1;
 
 
 select *
 from layoffs_staging2
 where country like "United States%";
 
 select distinct country, trim(trailing "." from country)
 from layoffs_staging2
 order by 1;
 
 update layoffs_staging2
 set country = trim(trailing "." from country)
 where country like "United States%";
 
 select distinct country, trim(trailing "." from country)
 from layoffs_staging2
 order by 1;
 
select date, str_to_date(date, "%m/%d/$Y")
from layoffs_staging2;
 
 UPDATE layoffs_staging2
 set `date` = 
case
when `date` is not null 
and `date` != "null"
then str_to_date(`date`, "%m/%d/%Y")
else null
end;

select `date` from layoffs_staging2;


alter table layoffs_staging2
modify column `date` date;

select * from layoffs_staging2;


-- NULL AND BLANK VALUES

select * from layoffs_staging2
where total_laid_off is null;


select * from layoffs_staging2
where total_laid_off is null
and percentage_laid_off is null;

select distinct industry
 from layoffs_staging2;

select distinct *
 from layoffs_staging2
 where industry is null
 or industry = '';
 
 select * from layoffs_staging2
 where company = "Airbnb";
 
 select * 
 from layoffs_staging2 t1
 join layoffs_staging2 t2
 on t1.company = t2.company
 where (t1.industry is null or t1.industry = '')
 and t2.industry is not null;
 
 
 update layoffs_staging2 t1
 join layoffs_staging2 t2
 on t1.company = t2.company
 set t1.industry = t2.industry
 where (t1.industry is null or t1.industry = '')
 and t2.industry is not null;
 
 
 select t1.industry, t2.industry
 from layoffs_staging2 t1
 join layoffs_staging2 t2
 on t1.company = t2.company
 where (t1.industry is null or t1.industry = '')
 and t2.industry is not null;
 
 
 update layoffs_staging2 
 set industry = null
 where industry = '';
 

select t1.industry, t2.industry
 from layoffs_staging2 t1
 join layoffs_staging2 t2
 on t1.company = t2.company
 where (t1.industry is null or t1.industry = '')
 and t2.industry is not null;
 
 

update layoffs_staging2 t1
join layoffs_staging2 t2
on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null
and t2.industry is not null;



select t1.industry, t2.industry
 from layoffs_staging2 t1
 join layoffs_staging2 t2
 on t1.company = t2.company
 where (t1.industry is null or t1.industry = '')
 and t2.industry is not null;
 
 
 select * from layoffs_staging2
 where company = 'Airbnb';
 
 
 select * from layoffs_staging2
 where industry is null
 or industry = '';
 
 select * from layoffs_staging2
 where company like 'Bally%';
 
 
 select * from layoffs_staging2;
 
 select * from layoffs_staging2
 where total_laid_off is null
 and percentage_laid_off is null; 
 
 
 
 delete
 from layoffs_staging2
 where total_laid_off is null 
 and  percentage_laid_off is null;
 
 select * from layoffs_staging2;
 
 alter table layoffs_staging2
 drop column row_num;
 
 select * from layoffs_staging2;
 
