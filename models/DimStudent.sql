
WITH enrollments_ranked AS (
    SELECT *,
        RANK() OVER (
            PARTITION BY SchoolId, StudentUniqueId 
            ORDER BY SchoolId, StudentUniqueId, EntryDate DESC
        ) rank
    FROM {{ ref("StgStudentDemographicsAndEnrollment_v2") }}
)


SELECT *
FROM enrollments_ranked
WHERE rank = 1
