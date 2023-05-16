
      
        
            delete from "hl"."bi_dashboard"."email_lemonaid_daily_report"
            where (
                keyword) in (
                select (keyword)
                from "email_lemonaid_daily_report__dbt_tmp203031164973"
            );

        
    

    insert into "hl"."bi_dashboard"."email_lemonaid_daily_report" ("date", "campaign", "ad_content", "keyword", "sessions", "transactions", "bounces", "bounce_rate")
    (
        select "date", "campaign", "ad_content", "keyword", "sessions", "transactions", "bounces", "bounce_rate"
        from "email_lemonaid_daily_report__dbt_tmp203031164973"
    )
  