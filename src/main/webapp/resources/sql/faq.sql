USE SCOTT;  -- 지금부터 spring 스키마에서 작업한다.

DROP TABLE IF EXISTS FAQ;

CREATE TABLE FAQ
(
    FAQ_NO BIGINT NOT NULL AUTO_INCREMENT,
    FAQ_TITLE VARCHAR(50),
    FAQ_CONTENT VARCHAR(1500),
    FAQ_CREATED DATETIME,
    CONSTRAINT FAQ_PK PRIMARY KEY(FAQ_NO)
);
 
INSERT INTO FAQ (FAQ_NO, FAQ_TITLE, FAQ_CONTENT, FAQ_CREATED)
	VALUES (1,'체크인과 체크아웃 시간은 언제입니까?','체크인 시간은 14:00이며, 체크아웃시간은 11:00입니다',NOW());
    INSERT INTO FAQ (FAQ_NO, FAQ_TITLE, FAQ_CONTENT, FAQ_CREATED)
	VALUES (2,'예약 취소는 언제까지 가능한가요?','일반 예약은 체크인 하루전 14:00시 이전까지 연락주시면 별도의 요금 지불 없이 취소 가능합니다.',NOW());
    INSERT INTO FAQ (FAQ_NO, FAQ_TITLE, FAQ_CONTENT, FAQ_CREATED)
	VALUES (3,'호텔 객실 내에서 인터넷 사용이 가능 한가요?','YOGIOTERU호텔에서는 전 객실 내에서 유선, 무선 인터넷 사용이 무료로 이용 가능 합니다.',NOW());
    INSERT INTO FAQ (FAQ_NO, FAQ_TITLE, FAQ_CONTENT, FAQ_CREATED)
	VALUES (4,'주차는 어디서 해야하나요?','호텔 내부의 지하주차장(지하3층 ~지하 7층)이 별도로 마련되어 있습니다.',NOW());
INSERT INTO FAQ (FAQ_NO, FAQ_TITLE, FAQ_CONTENT, FAQ_CREATED)
	VALUES (5,'레스토랑 운영시간은 어떻게 되나요?','조식 6:30~10:00, 중식 11:00~14:00, 석식 17:00~20:00 로 운영되고 있습니다',NOW());
    INSERT INTO FAQ (FAQ_NO, FAQ_TITLE, FAQ_CONTENT, FAQ_CREATED)
	VALUES (6,'대관 및 행사 문의','대관 및 행사에 대한 문의는 010-1234-5678으로 전화주시면 자세한 안내를 도와드리겠습니다',NOW());
INSERT INTO FAQ (FAQ_NO, FAQ_TITLE, FAQ_CONTENT, FAQ_CREATED)
	VALUES (7,'외부 배달 음식을 주문해도 되나요?','호텔 규정 상 외부 배달 음식은 주문하실 수 없습니다',NOW());
    
    commit;


