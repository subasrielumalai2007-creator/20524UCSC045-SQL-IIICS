CREATE OR REPLACE PROCEDURE GET_STATE_DETAILS
(
    P_STATE_NAME VARCHAR2
)
IS
    V_COUNT NUMBER := 0;
BEGIN
    FOR R IN
    (
        SELECT DISTRICT_NAME,
               CROP_NAME,
               CROP_YEAR,
               PRODUCTION
        FROM CROP_PRODUCTION
        WHERE UPPER(STATE_NAME) = UPPER(P_STATE_NAME)
    )
    LOOP
        V_COUNT := V_COUNT + 1;

        DBMS_OUTPUT.PUT_LINE(
            'District: ' || R.DISTRICT_NAME ||
            ', Crop: ' || R.CROP_NAME ||
            ', Year: ' || R.CROP_YEAR ||
            ', Production: ' || R.PRODUCTION
        );
    END LOOP;

    IF V_COUNT = 0 THEN
        RAISE_APPLICATION_ERROR(-20003,
        'No records found for the given state');
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE(SQLERRM);
END;
/

BEGIN 
    GET_STATE_DETAILS('Tamil Nadu');
END;
