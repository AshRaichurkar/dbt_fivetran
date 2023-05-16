
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
select * from bi_dashboard.email_lemonaid_daily_report_raw where date = '20230402')


select * from t1
