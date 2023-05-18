


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
       , fnv_hash(date, fnv_hash(campaign,  fnv_hash(keyword))) as lemonaid_sk
        from hl.fivetran.email_lemonaid_daily_report_raw where to_date(cast(_modified as TEXT),'YYYY-MM-DD') >= '2023-01-01'
        and _file in (select _file from hl.fivetran.email_lemonaid_daily_report_raw where to_date(cast(_modified as TEXT),'YYYY-MM-DD') >= '2023-01-01')
        group by
        date
       , campaign
       , ad_content
       , keyword
       , sessions
       , transactions
       , bounces
       , bounce_rate)


select * from t1
