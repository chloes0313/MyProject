DROP TABLE DOER;
DELETE FROM DOER;
--ALTER TABLE DOER ADD(EMAIL VARCHAR2(200) NOT NULL);
ALTER TABLE DOER MODIFY(PASSWORD VARCHAR2(80));
ALTER TABLE DOER ADD(EMAIL VARCHAR2(200) NOT NULL);
CREATE TABLE DOER (
	ID			VARCHAR2(20)	PRIMARY KEY,
	PASSWORD	VARCHAR2(80)	NOT NULL,	--암호화위해 
	NAME		VARCHAR2(20)	NOT NULL,
	EMAIL 		VARCHAR2(200) 	NOT NULL
);

SELECT * FROM DOER;

DROP TABLE AUTHORITIES;
/*권한 테이블 - ROLE_ADMIN, ROLE_MEMBER*/
CREATE TABLE AUTHORITIES(
	USER_ID VARCHAR2(20),
	AUTHORITY VARCHAR2(20) NOT NULL,
	CONSTRAINT AUTHORITIES_PK PRIMARY KEY(USER_ID, AUTHORITY),
	CONSTRAINT AUTHORITIES_USER_ID_FK FOREIGN KEY(USER_ID) REFERENCES DOER(ID) ON DELETE CASCADE
);

SELECT * FROM AUTHORITIES;


/******* 임시로 수행자 데이터 추가 *****/
DELETE FROM doer
WHERE		id = 'admin'
INSERT INTO DOER VALUES ('chloes0313', '$2a$10$vxmMJtWGAxKhFIqPP.ONA.IHHr8f1aDELCj7WiArdhpcd3BdibDDa', '끌로이', 'chloeseong0313@gmail.com');--암호화pw:2222
INSERT INTO DOER VALUES('admin', '$2a$10$vxmMJtWGAxKhFIqPP.ONA.IHHr8f1aDELCj7WiArdhpcd3BdibDDa', '관리자', 'admin@a.com'); --pwd : 2222

INSERT INTO AUTHORITIES VALUES ('admin', 'ROLE_ADMIN');
INSERT INTO AUTHORITIES VALUES ('admin', 'ROLE_MEMBER');
INSERT INTO AUTHORITIES VALUES ('chloes0313', 'ROLE_MEMBER');

/*****************************/


DROP TABLE HABIT CASCADE CONSTRAINT;
CREATE TABLE HABIT (
	HABIT_NO	NUMBER(7)		PRIMARY KEY,
	DOER_ID		VARCHAR2(20)	NOT NULL,
	HABIT_TITLE	VARCHAR2(100)	NOT NULL,
	HABIT_START	DATE			NOT NULL,
	HABIT_END	DATE,
	COMPLETION	CHAR(1)			NOT NULL,
	ACHIEVEMENT	CHAR(1),
CONSTRAINT HABIT_DOER_ID_FK FOREIGN KEY(DOER_ID) REFERENCES DOER(ID) ON DELETE CASCADE
);

DROP SEQUENCE HABIT_NO_SEQ;
CREATE SEQUENCE HABIT_NO_SEQ INCREMENT BY 1 START WITH 1; 

DROP TABLE HABIT_CHECK;
--ALTER TABLE HABIT_CHECK ADD(DATE DATE NOT NULL);
CREATE TABLE HABIT_CHECK (
	HABIT_NO	NUMBER(7)	NOT NULL,
	DAY			NUMBER(2)	NOT NULL,
	HABIT_DATE	DATE		NOT NULL,
	HABIT_STATE	VARCHAR2(20)	NOT NULL,
	CONSTRAINT HABIT_CHECK_PK PRIMARY KEY(HABIT_NO, DAY),
	CONSTRAINT HABIT_CHECK_HABIT_NO_FK FOREIGN KEY(HABIT_NO) REFERENCES HABIT ON DELETE CASCADE
);

DROP TABLE JOURNAL;
CREATE TABLE JOURNAL (
	JOURNAL_NO			NUMBER(7)		PRIMARY KEY,
	JOURNAL_WRITE_ID	VARCHAR2(20)	NOT NULL,
	JOURNAL_WRITE_DATE	DATE			NOT NULL,
	JOURNAL_TITLE		VARCHAR2(100)	NOT NULL,
	JOURNAL_CONTENTS	VARCHAR2(1000)	NOT NULL,
	JOURNAL_ICONIC_IMAGE	VARCHAR2(1000),
	CONSTRAINT JOURNAL_JOURNAL_WRITE_ID_FK FOREIGN KEY(JOURNAL_WRITE_ID) REFERENCES DOER(ID) ON DELETE CASCADE
);

DROP SEQUENCE JOURNAL_NO_SEQ;
CREATE SEQUENCE JOURNAL_NO_SEQ INCREMENT BY 1 START WITH 1; 

DROP TABLE IMAGE;
CREATE TABLE IMAGE(
	JOURNAL_NO		NUMBER(7)	NOT NULL,
	IMAGE_SAVE_NAME		VARCHAR2(41) NOT NULL, --UUID로 생성된 문자열 (36글자+확장자까지 최대 41 : JPG, JPEG 등)
	IMAGE_ORIGINAL_NAME	VARCHAR2(100)	NOT NULL,
	CONSTRAINT JOURNAL_IMAGES_PK PRIMARY KEY(JOURNAL_NO, IMAGE_SAVE_NAME),
	CONSTRAINT JOURNAL_IMAGES_JOURNAL_NO_FK FOREIGN KEY(JOURNAL_NO) REFERENCES JOURNAL(JOURNAL_NO) ON DELETE CASCADE
);
-------------------------------------------------------
SELECT	*
FROM	habit
WHERE	completion = 'y'
AND		achievement = 'n'


SELECT	h.habit_no,
			h.doer_id,
			h.habit_title,
			h.habit_start,
			h.habit_end,
			h.completion,
			h.achievement,
			c.day,
			c.habit_date,
			c.habit_state
	FROM	habit h, habit_check c
	WHERE	h.habit_no = c.habit_no (+)
	AND		h.habit_no = 1;
	
	
	SELECT	h.habit_no,
			h.doer_id,
			h.habit_title,
			h.habit_start,
			h.habit_end,
			h.completion,
			h.achievement,
			c.day,
			c.habit_date,
			c.habit_state
	FROM	habit h, habit_check c
	WHERE	c.habit_no = h.habit_no (+)
	AND		c.habit_date = '2017-11-18'
	
SELECT * FROM HABIT where habit_no = 1;

SELECT * FROM AUTHORITIES
UPDATE	AUTHORITIES
SET		AUTHORITY = 'ROLE_DOER'
WHERE	USER_ID = 'admin' AND AUTHORITY = 'ROLE_MEMBER'

UPDATE 	habit_check
SET		habit_state = 'do'
WHERE	habit_no = 65
AND		habit_date < '2017-11-15'


SELECT	c.habit_no,
		c.day,
		c.habit_date,
		c.habit_state,
		h.doer_id,
		h.habit_title,
		h.habit_start,
		h.habit_end,
		h.completion,
		h.achievement
FROM	habit_check c, habit h
WHERE	c.habit_no = h.habit_no (+)
AND		h.completion = 'n'
AND		c.habit_date = '2017-11-24'



	SELECT	j.journal_no,
			j.journal_write_id,
			j.journal_write_date,
			j.journal_title,
			j.journal_contents,
			i.image_original_name,
			i.image_save_name
	FROM	journal j, image i 
	WHERE	j.journal_no = i.journal_no (+)
	AND		i.journal_no = 84;
	
select * from journal where journal_no=83;
select * from image
where	journal_no=84
and		image_original_name='0a0d9afa-b45c-47cf-b2df-5b25cee497f5.jpg'


UPDATE HABIT_CHECK
SET 	habit_state='do'
WHERE	habit_no = 161
AND		day between 1 and 6