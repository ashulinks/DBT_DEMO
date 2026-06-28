With Trips as (

select
ride_id,
RIDEABLE_TYPE,
TO_TIMESTAMP(STARTED_AT),
DATE(TO_TIMESTAMP(STARTED_AT)) as trip_date,
START_STATIO_ID as start_stationn_id,
END_STATION_ID,
MEMBER_CSUAL as member_casual,
TIMESTAMPDIFF(second,TO_TIMESTAMP(STARTED_AT),TO_TIMESTAMP(ENDED_AT)) as trip_duration_seconds

from {{source('demo', 'bike')}}    
where RIDE_ID != 'ride_id'

)

select * from trips