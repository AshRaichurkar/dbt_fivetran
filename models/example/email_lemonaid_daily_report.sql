


{{ 
config(
    materialized='incremental',
    unique_key='keyword',
)
}}

with t1 as (
select * from bi_dashboard.email_lemonaid_daily_report_raw where date = '20230402')


select * from t1
