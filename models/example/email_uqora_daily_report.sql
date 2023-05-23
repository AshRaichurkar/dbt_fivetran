


{{ 
config(
    materialized='incremental',
    unique_key='keyword',
)
}}

with t1 as (
SELECT date
       , campaign
       , ad_content
       , keyword
       , sessions
       , transactions
       , bounces
       , bounce_rate
	   , fnv_hash(date, fnv_hash(campaign,  fnv_hash(keyword, fnv_hash(ad_content)))) as uqora_sk
 FROM hl.fivetran.email_uqora_daily_report_raw
 where to_date(cast(_modified as TEXT),'YYYY-MM-DD') = current_date
 and _file in (select distinct _file from hl.fivetran.email_uqora_daily_report_raw where to_date(cast(_modified as TEXT),'YYYY-MM-DD') = current_date)
 and bounce_rate like '%\\%'
 group by date
       , campaign
       , ad_content
       , keyword
       , sessions
       , transactions
       , bounces
       , bounce_rate
	   , fnv_hash(date, fnv_hash(campaign,  fnv_hash(keyword, fnv_hash(ad_content)))))


select * from t1
