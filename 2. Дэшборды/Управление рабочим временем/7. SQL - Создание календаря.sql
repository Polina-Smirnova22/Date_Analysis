select 
    min(dtdate) as dtDateFrom
,	max(dtdate) as dtDateTo
,	max(dtdate) as dtSelectedDate
,   1 as nDynamicTypeID
from src.smirnova_kalendar_2024_2741000002501
