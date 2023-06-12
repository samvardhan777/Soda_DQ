{% test missing_percent(model,column_name,percent) %}

select  count(*) as cnt from {{ model }} where {{ column_name }}  is null
having cnt > (select (count(*)*{{percent}}/100) from {{ model }}) 

{% endtest %}