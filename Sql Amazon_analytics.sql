CREATE TABLE amazon_analysis(
product_id TEXT,
Product_name TEXT,
Category TEXT,
discounted_price Numeric,
actual_price NUMERIC,
discounted_percentage NUMERIC,
rating NUMERIC,
rating_count INTEGER,
discount_amount NUMERIC,
main_category TEXT
);

SELECT*FROM amazon_analysis;

SELECT COUNT(*) FROM amazon_analysis;

SELECT column_name, data_type FROM information_schema.columns
WHERE table_name = 'amazon_analysis';

select distinct main_category FROM amazon_analysis;

#main_category vs total product
SELECT main_category, count(*) as total_products from amazon_analysis
group by main_category
Order By Total_products desc ;

#Main_category wise average rating
SELECT main_category, ROUND(AVG(rating),2) as avg_rating,
       count(rating) as Total_rated_product from amazon_analysis
group by main_category
order by avg_rating Desc;

#main_category wise average discount
SELECT main_category, ROUND(AVG(discounted_percentage),2) as avg_discount
       from amazon_analysis
group by main_category
order by avg_discount Desc;

#Highestrating product
select product_name, main_category,rating,rating_count from amazon_analysis
where rating is not NULL
order by rating DESC,
rating_count DESC NULLs last  limit 10;

#actualprice  VS discountedprice
select main_category, round(avg(actual_price)) as avg_actual_price,
       Round(avg(discounted_price)) as avg_discounted_price ,
	   round(avg(discount_amount)) as avg_discount_amount
	   from amazon_analysis
where actual_price is not null and discounted_price is not null
group by  main_category
order by avg_discounted_price desc;

#discountpercentage vs rating
select
  case 
      when discounted_percentage < 0.20 Then 'Low Discount'
	   when discounted_percentage <0.40 Then 'medium Discount'
	       Else 'high Discount'
		 end as discount_group,
       count(*) as total_products,
	    round(avg(rating),2) as avg_rating
from amazon_analysis
where discounted_percentage is not null and Rating is not null 
group by 
      case
	  when discounted_percentage < 0.20 Then 'Low Discount'
	   when discounted_percentage <0.40 Then 'medium Discount'
	       Else 'high Discount'
		 end 
order by avg_rating desc;

#ratingcount vs rating
select
   case 
      when rating_count<1000 then 'low reviews '
	  when rating_count <10000 then 'Medium reviews'
	  else 'High reviews'
	  end as review_group,
	count(*) as total_products,
	round(avg(rating),2) as avg_rating from amazon_analysis
group by
     case 
      when rating_count<1000 then 'low reviews '
	  when rating_count <10000 then 'Medium reviews'
	  else 'High reviews'
	  end 
order by avg_rating desc;


#pricerange vs rating
select
   case
       when discounted_price<1000 then 'Budget product'
	   when discounted_price <5000 then 'mid range products'
	   else 'Premium products'
	   end as price_group,
	 count(*) as Total_products,
	 round(avg(rating),2) as avg_rating from amazon_analysis
group by 1
order by
     case
       when discounted_price<1000 then 'Budget product'
	   when discounted_price <5000 then 'mid range products'
	   else 'Premium products'
	   end;
	   

select column_name
from information_schema.columns
where table_name= 'amazon_analysis';

#__main category vs rating
select main_category,count(*) as total_products ,round(avg(rating),2) as avg_rating
from amazon_analysis
Group by main_category
order by avg_rating desc;

#top products and categories
select main_category,count(*) as total_products
from amazon_analysis
group by main_category
order by total_products desc;
