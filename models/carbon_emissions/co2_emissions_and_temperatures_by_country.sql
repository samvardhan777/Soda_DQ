
{{
  config(
    materialized = 'table'
    )
}}

SELECT
  coalesce(em.Country, '')||'||'||em.Year||'||'|| coalesce(temp.AverageTemperature,0)   as bkey,
  em.Year,
  em.Country,
  em.TotalEmissions,
  em.PerCapitaEmissions,
  em.ShareOfGlobalEmissions,
  temp.AverageTemperature
FROM
  {{ source('carbon_emissions','co2_emissions_by_country') }} em 
  INNER JOIN {{ source('global_temperatures','aggregate_country_temperatures') }} temp
    ON em.COUNTRY = temp.country AND em.Year = temp.year
