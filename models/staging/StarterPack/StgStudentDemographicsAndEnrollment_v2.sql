

SELECT * EXCEPT (GradeLevel, Race, IsSped, Mentor),
    IsSped                                        AS HasIEP,
    CAST(GradeLevel AS int64)                     AS GradeLevel,
    IFNULL(Race, 'Unknown')                       AS RaceAndEthnicity,
    CASE ExitWithdrawReason
        WHEN 'Student is currently enrolled' THEN TRUE
        WHEN NULL THEN TRUE
        WHEN 'End of school year' THEN TRUE
        ELSE FALSE
    END                                           AS CurrentlyEnrolled
FROM {{ source("StarterPack", "StudentDemographicsAndEnrollment_v2") }}
