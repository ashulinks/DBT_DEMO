WITH daily_weather as (

select
DATE(Time) as daily_weather,
weather,
temp,
pressure,
humidity,
clouds
from {{ source('demo', 'weather') }}
),

daily_weather_aggregate as (

select
daily_weather,
weather,
round(avg(temp),2) as avg_temp,
round(avg(pressure),2) as avg_pressure,
avg(humidity) as avg_humidity,
avg(clouds) as avg_clouds
from daily_weather

group by daily_weather, weather

qualify Row_Number() OVER (PARtition by daily_weather Order by count(weather) desc) =1

)

select * from daily_weather_aggregate