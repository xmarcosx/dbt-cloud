
SELECT
    * EXCEPT(GradingPeriodDescriptor, SessionName),
    REPLACE(SessionName, "SY2022 ", "") AS SessionName,
    {{ convert_grading_period('GradingPeriodDescriptor') }} AS GradingPeriodDescriptor
FROM {{ source("StarterPack", "CourseGrades") }}
