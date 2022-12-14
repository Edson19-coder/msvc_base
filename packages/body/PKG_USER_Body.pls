CREATE OR REPLACE PACKAGE BODY MSVC_BASE.PKG_USER AS
 
    PROCEDURE CREATE_USER(vUserName IN VARCHAR2, vEmail IN VARCHAR2, vPassword IN VARCHAR2, vResponse OUT VARCHAR2) IS
    BEGIN
        INSERT INTO MSVC_BASE.MB_USERS(USER_ID,USER_NAME,USER_EMAIL,PASSWORD,CREATION_DATE,ACTIVE)
        VALUES(SEQ_USERS.nextval,vUserName,vEmail,vPassword,SYSDATE,1);
        COMMIT;
        vResponse:='true';
    END CREATE_USER;

    PROCEDURE UPDATE_USER(vUserId IN NUMBER, vUserName IN VARCHAR2, vEmail IN VARCHAR2, vPassword IN VARCHAR, vResponse OUT VARCHAR2) IS
    BEGIN
        UPDATE MSVC_BASE.MB_USERS SET USER_NAME = vUserName, USER_EMAIL = vEmail, PASSWORD = vPassword, LAST_UPDATE_DATE = SYSDATE
        WHERE USER_ID = vUserId;
        COMMIT;
        vResponse:='true';
    END UPDATE_USER;

    PROCEDURE DELETE_USER(vUserId IN NUMBER, vResponse OUT VARCHAR2) IS
    BEGIN
        UPDATE MSVC_BASE.MB_USERS SET ACTIVE = 0, LAST_UPDATE_DATE = SYSDATE
        WHERE USER_ID = vUserId;
        COMMIT;
        vResponse:='true';
    END DELETE_USER;

    PROCEDURE GET_USER(vEmail IN VARCHAR2, rc OUT SYS_REFCURSOR) IS
    BEGIN
        OPEN rc FOR
        SELECT USER_ID, USER_EMAIL, USER_NAME, PASSWORD FROM MSVC_BASE.MB_USERS WHERE USER_EMAIL = vEmail;
    END GET_USER;

    PROCEDURE GET_USERS(rc OUT SYS_REFCURSOR) IS
    BEGIN
        OPEN rc FOR
        SELECT USER_ID, USER_EMAIL, USER_NAME, PASSWORD FROM MSVC_BASE.MB_USERS WHERE ACTIVE = 1 ORDER BY CREATION_DATE DESC;
    END GET_USERS;

END PKG_USER;