
WITH GradesRanked AS (

    SELECT
        * EXCEPT(GradingPeriodDescriptor, SessionName),
        SessionName, 
        GradingPeriodDescriptor,
        RANK() OVER (
            PARTITION BY StudentUniqueId,  CourseTitle,  GradingPeriodDescriptor
            ORDER BY  StudentUniqueId,  CourseTitle,  GradingPeriodDescriptor,  GradeTypeDescriptor DESC
        ) Rank
    FROM {{ ref('StgCourseGrades') }}
    WHERE
        GradeTypeDescriptor != "Gradebook"
        OR IsCurrentCourseEnrollment IS TRUE
)

SELECT
    DimStudents.*,
    GradesRanked.SectionIdentifier,
    GradesRanked.StaffDisplayName,
    GradesRanked.StaffClassroomPosition,
    GradesRanked.ClassPeriodName,
    GradesRanked.CourseCode,
    GradesRanked.CourseTitle,
    GradesRanked.AcademicSubject,
    GradesRanked.SessionName,
    GradesRanked.GradingPeriodDescriptor,
    GradesRanked.GradeTypeDescriptor,
    GradesRanked.IsCurrentCourseEnrollment,
    GradesRanked.IsCurrentGradingPeriod,
    GradesRanked.NumericGradeEarned,
    GradesRanked.LetterGradeEarned
FROM GradesRanked
LEFT JOIN {{ ref('DimStudents') }} DimStudents
    ON GradesRanked.SchoolId = DimStudents.SchoolId
    AND GradesRanked.StudentUniqueId = DimStudents.StudentUniqueId
WHERE Rank = 1
