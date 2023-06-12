{{
  config(
    materialized = 'table'
    )
}}

SELECT
    em.year,
    em.country,
    em.totalemissions,
    em.percapitaemissions,
    em.shareofglobalemissions,
    temp.averagetemperature,
    coalesce(em.country, '')
    || '||'
    || em.year
    || '||'
    || coalesce(temp.averagetemperature, 0) AS bkey
FROM
    {{ source('carbon_emissions','co2_emissions_by_country') }} AS em
INNER JOIN
    {{ source('global_temperatures','aggregate_country_temperatures') }} AS temp
    ON em.country = temp.country AND em.year = temp.year
