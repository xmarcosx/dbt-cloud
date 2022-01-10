
{% macro convert_grading_period(grading_period) %}
    CASE
        WHEN {{ grading_period }} = 'End of Year' THEN 'Y1'
        WHEN {{ grading_period }} = 'First Semester' THEN 'S1'
        WHEN {{ grading_period }} = 'Second Semester' THEN 'S2'
        WHEN {{ grading_period }} = 'Third Nine Weeks' THEN 'Q3'
        WHEN {{ grading_period }} = 'First Nine Weeks' THEN 'Q1'
        ELSE {{ grading_period }}
    END
{% endmacro %}
