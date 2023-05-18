
/*
    Welcome to your first dbt model!
    Did you know that you can also configure models directly within SQL files?
    This will override configurations stated in dbt_project.yml

    Try changing "table" to "view" below
*/

{{ 
config(
    materialized='incremental',
    unique_key='keyword',
)
}}
/*
with source_data as (

    select 1 as id
    union all
    select null as id

)

select *
from source_data
*/
/*
    Uncomment the line below to remove records with null `id` values
*/

-- where id is not null
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
       , bounce_rate
        )


select
        date
        , campaign
       , ad_content
       , keyword
       , sessions
       , transactions
       , bounces
       , bounce_rate
       , lemonaid_sk
        from t1;
