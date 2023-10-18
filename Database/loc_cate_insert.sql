-- 테이블 생성
CREATE TABLE member (
 nickname	VARCHAR2(18)		NOT NULL,
 email	VARCHAR2(30)		NOT NULL,
 passwd	VARCHAR2(20)		NOT NULL,
 phone	NUMBER(8)		NOT NULL,
 gender	char(1)		NOT NULL,
 memberintro	VARCHAR2(100)		NULL,
 profile_img	VARCHAR2(100)	DEFAULT 'avartar.png'	NULL
);

CREATE TABLE mainboard (
	momo_id	NUMBER(5)		NOT NULL,
	nickname	VARCHAR2(18)		NOT NULL,
	cate_num	NUMBER(3)		NOT NULL,
	loc_num	NUMBER(4)		NOT NULL,
	momoName	VARCHAR2(60)		NOT NULL,
	momoIntro	VARCHAR2(100)		NOT NULL,
	momoDetail	VARCHAR2(2000)		NOT NULL,
	momoLoc	VARCHAR2(150)		NOT NULL,
	momoDate	date		NOT NULL,
	fee	NUMBER(6)	DEFAULT 0	NOT NULL,
	materials	VARCHAR2(50)		NULL,
	momo_img	VARCHAR2(100)	DEFAULT 'momo.png'	NULL,
	headcount	NUMBER(2)		NOT NULL,
	maxHeadcount	NUMBER(2)		NOT NULL,
	recruit	NUMBER(1)		NOT NULL,
	status	NUMBER(1)		NOT NULL,
	writeDate	date		NOT NULL
);

CREATE TABLE reply (
	reply_id	NUMBER(5)		NOT NULL,
	momo_id	NUMBER(5)		NOT NULL,
	nickname	VARCHAR2(18)		NOT NULL,
	replyContent	VARCHAR2(300)		NOT NULL,
	replyDate	date		NOT NULL
);

CREATE TABLE mark (
	mark_id	NUMBER(5)		NOT NULL,
	momo_id	NUMBER(5)		NOT NULL,
	nickname	VARCHAR2(18)		NOT NULL,
	mark_check	NUMBER(1)	DEFAULT 1	NOT NULL
);

CREATE TABLE host (
	host_id	NUMBER(5)		NOT NULL,
	momo_id	NUMBER(5)		NOT NULL,
	nickname	VARCHAR2(18)		NOT NULL,
	applicant_id	NUMBER(5)		NOT NULL,
	cancel_id	NUMBER(5)		NOT NULL
);

CREATE TABLE guest (
	guest_id	NUMBER(5)		NOT NULL,
	nickname	VARCHAR2(18)		NOT NULL,
	momo_id	NUMBER(5)		NOT NULL
);

CREATE TABLE category (
	cate_num	NUMBER(4)		NOT NULL,
	cate	VARCHAR2(30)		NOT NULL,
	cate_level	NUMBER(1)		NOT NULL,
	par_cate_num	NUMBER(4)		NULL,
	cate_path	VARCHAR2(50)		NOT NULL
);

CREATE TABLE location (
	loc_num	NUMBER(4)		NOT NULL,
	loc	VARCHAR2(25)		NOT NULL,
	loc_level	NUMBER(1)		NOT NULL,
	par_loc_num	NUMBER(4)		NULL,
	loc_path	VARCHAR2(50)		NOT NULL
);

CREATE TABLE applicant (
	applicant_id	NUMBER(5)		NOT NULL,
	momo_id	NUMBER(5)		NOT NULL,
	nickname VARCHAR2(18)		NOT NULL,
	reason1	VARCHAR2(150)		NULL,
	reason2	VARCHAR2(150)		NULL
);

CREATE TABLE cancel (
	cancel_id	NUMBER(5)		NOT NULL,
	momo_id	NUMBER(5)		NOT NULL,
	guest_id	NUMBER(5)		NOT NULL,
	reason1	VARCHAR2(150)		NULL,
	reason2	VARCHAR2(150)		NULL
);


-- 기본키 지정
ALTER TABLE member ADD CONSTRAINT PK_MEMBER PRIMARY KEY (
	nickname
);

ALTER TABLE mainboard ADD CONSTRAINT PK_MAINBOARD PRIMARY KEY (
	momo_id
);

ALTER TABLE reply ADD CONSTRAINT PK_REPLY PRIMARY KEY (
	reply_id
);

ALTER TABLE mark ADD CONSTRAINT PK_MARK PRIMARY KEY (
	mark_id
);

ALTER TABLE host ADD CONSTRAINT PK_HOST PRIMARY KEY (
	host_id
);

ALTER TABLE guest ADD CONSTRAINT PK_GUEST PRIMARY KEY (
	guest_id
);

ALTER TABLE category ADD CONSTRAINT PK_CATEGORY PRIMARY KEY (
	cate_num
);

ALTER TABLE location ADD CONSTRAINT PK_LOCATION PRIMARY KEY (
	loc_num
);

ALTER TABLE applicant ADD CONSTRAINT PK_APPLICANT PRIMARY KEY (
	applicant_id
);

ALTER TABLE cancel ADD CONSTRAINT PK_CANCEL PRIMARY KEY (
	cancel_id
);


-- 외래키 지정
ALTER TABLE mainboard ADD CONSTRAINT FK_member_TO_mainboard_1 FOREIGN KEY (
	nickname
)
REFERENCES member (
	nickname
);

ALTER TABLE mainboard ADD CONSTRAINT FK_category_TO_mainboard_1 FOREIGN KEY (
	cate_num
)
REFERENCES category (
	cate_num
);

ALTER TABLE mainboard ADD CONSTRAINT FK_location_TO_mainboard_1 FOREIGN KEY (
	loc_num
)
REFERENCES location (
	loc_num
);

ALTER TABLE reply ADD CONSTRAINT FK_mainboard_TO_reply_1 FOREIGN KEY (
	momo_id
)
REFERENCES mainboard (
	momo_id
);

ALTER TABLE reply ADD CONSTRAINT FK_MEMBER_TO_reply_1 FOREIGN KEY (
	nickname
)
REFERENCES member (
	nickname
);

ALTER TABLE mark ADD CONSTRAINT FK_mainboard_TO_mark_1 FOREIGN KEY (
	momo_id
)
REFERENCES mainboard (
	momo_id
);

ALTER TABLE mark ADD CONSTRAINT FK_MEMBER_TO_mark_1 FOREIGN KEY (
	nickname
)
REFERENCES member (
	nickname
);

ALTER TABLE host ADD CONSTRAINT FK_mainboard_TO_host_1 FOREIGN KEY (
	momo_id
)
REFERENCES mainboard (
	momo_id
);

ALTER TABLE host ADD CONSTRAINT FK_member_TO_host_1 FOREIGN KEY (
	nickname
)
REFERENCES member (
	nickname
);

ALTER TABLE host ADD CONSTRAINT FK_applicant_TO_host_1 FOREIGN KEY (
	applicant_id
)
REFERENCES applicant (
	applicant_id
);

ALTER TABLE host ADD CONSTRAINT FK_cancel_TO_host_1 FOREIGN KEY (
	cancel_id
)
REFERENCES cancel (
	cancel_id
);

ALTER TABLE guest ADD CONSTRAINT FK_member_TO_guest_1 FOREIGN KEY (
	nickname
)
REFERENCES member (
	nickname
);

ALTER TABLE guest ADD CONSTRAINT FK_mainboard_TO_guest_1 FOREIGN KEY (
	momo_id
)
REFERENCES mainboard (
	momo_id
);

ALTER TABLE applicant ADD CONSTRAINT FK_mainboard_TO_applicant_1 FOREIGN KEY (
	momo_id
)
REFERENCES mainboard (
	momo_id
);

ALTER TABLE applicant ADD CONSTRAINT FK_member_TO_applicant_1 FOREIGN KEY (
	nickname
)
REFERENCES member (
	nickname
);

ALTER TABLE cancel ADD CONSTRAINT FK_mainboard_TO_cancel_1 FOREIGN KEY (
	momo_id
)
REFERENCES mainboard (
	momo_id
);

ALTER TABLE cancel ADD CONSTRAINT FK_guest_TO_cancel_1 FOREIGN KEY (
	guest_id
)
REFERENCES guest (
	guest_id
);


-- 시퀀스 생성
create sequence guest_seq;
create sequence host_seq;
create sequence cancle_seq;
create sequence mark_seq;
create sequence momo_seq;
create sequence reply_seq;
create sequence applicant_seq;


-- 지역 삽입
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values(1000,'서울',1,NULL,'서울특별시');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values(1100,'경기',1,NULL,'경기도');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values(1200,'인천',1,NULL,'인천광역시');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values(1300,'강원',1,NULL,'강원도');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values(1400,'대전',1,NULL,'대전광역시');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values(1500,'세종',1,NULL,'세종특별자치시');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values(1600,'충남',1,NULL,'충청남도');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values(1700,'충북',1,NULL,'충청북도');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values(1800,'부산',1,NULL,'부산광역시');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values(1900,'울산',1,NULL,'울산광역시');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values(2000,'경남',1,NULL,'경상남도');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values(2100,'경북',1,NULL,'경상북도');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values(2200,'대구',1,NULL,'대구광역시');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values(2300,'광주',1,NULL,'광주광역시');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values(2400,'전남',1,NULL,'전라남도');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values(2500,'전북',1,NULL,'전라북도');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values(2600,'제주',1,NULL,'제주특별자치도');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values(2700,'전국',1,NULL,'전국');

insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1001, '강남구', 2, 1000, '서울특별시 강남구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1002, '강동구', 2, 1000, '서울특별시 강동구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1003, '강북구', 2, 1000, '서울특별시 강북구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1004, '강서구', 2, 1000, '서울특별시 강서구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1005, '관악구', 2, 1000, '서울특별시 관악구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1006, '광진구', 2, 1000, '서울특별시 광진구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1007, '구로구', 2, 1000, '서울특별시 구로구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1008, '금천구', 2, 1000, '서울특별시 금천구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1009, '노원구', 2, 1000, '서울특별시 노원구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1010, '도봉구', 2, 1000, '서울특별시 도봉구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1011, '동대문구', 2, 1000, '서울특별시 동대문구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1012, '동작구', 2, 1000, '서울특별시 동작구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1013, '마포구', 2, 1000, '서울특별시 마포구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1014, '서대문구', 2, 1000, '서울특별시 서대문구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1015, '서초구', 2, 1000, '서울특별시 서초구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1016, '성동구', 2, 1000, '서울특별시 성동구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1017, '성북구', 2, 1000, '서울특별시 성북구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1018, '송파구', 2, 1000, '서울특별시 송파구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1019, '양천구', 2, 1000, '서울특별시 양천구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1020, '영등포구', 2, 1000, '서울특별시 영등포구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1021, '용산구', 2, 1000, '서울특별시 용산구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1022, '은평구', 2, 1000, '서울특별시 은평구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1023, '종로구', 2, 1000, '서울특별시 종로구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1024, '중구', 2, 1000, '서울특별시 중구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1025, '중랑구', 2, 1000, '서울특별시 중랑구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1026, '서울전체', 2, 1000, '서울특별시 전체');

insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1101, '가평군', 2, 1100, '경기도 가평군');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1102, '고양시 덕양구', 2, 1100, '경기도 고양시 덕양구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1103, '고양시 일산동구', 2, 1100, '경기도 고양시 일산동구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1104, '고양시 일산서구', 2, 1100, '경기도 고양시 일산서구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1105, '고양시 전체', 2, 1100, '경기도 고양시 전체');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1106, '과천시', 2, 1100, '경기도 과천시');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1107, '광명시', 2, 1100, '경기도 광명시');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1108, '광주시', 2, 1100, '경기도 광주시');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1109, '구리시', 2, 1100, '경기도 구리시');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1110, '군포시', 2, 1100, '경기도 군포시');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1111, '김포시', 2, 1100, '경기도 김포시');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1112, '남양주시', 2, 1100, '경기도 남양주시');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1113, '동두천시', 2, 1100, '경기도 동두천시');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1114, '부천시', 2, 1100, '경기도 부천시');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1115, '성남시 분당구', 2, 1100, '경기도 성남시 분당구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1116, '성남시 수정구', 2, 1100, '경기도 성남시 수정구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1117, '성남시 중원구', 2, 1100, '경기도 성남시 중원구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1118, '성남시 전체', 2, 1100, '경기도 성남시 전체');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1119, '수원시 권선구', 2, 1100, '경기도 수원시 권선구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1120, '수원시 영통구', 2, 1100, '경기도 수원시 영통구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1121, '수원시 장안구', 2, 1100, '경기도 수원시 장안구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1122, '수원시 팔달구', 2, 1100, '경기도 수원시 팔달구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1123, '수원시 전체', 2, 1100, '경기도 수원시 전체');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1124, '시흥시', 2, 1100, '경기도 시흥시');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1125, '안산시 단원구', 2, 1100, '경기도 안산시 단원구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1126, '안산시 상록구', 2, 1100, '경기도 안산시 상록구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1127, '안산시 전체', 2, 1100, '경기도 안산시 전체');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1128, '안성시', 2, 1100, '경기도 안성시');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1129, '안양시', 2, 1100, '경기도 안양시');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1130, '양주시', 2, 1100 '경기도 양주시');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1131, '양평시', 2, 1100, '경기도 양평시');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1132, '여주시', 2, 1100, '경기도 여주시');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1133, '오산시', 2, 1100, '경기도 오산시');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1134, '용인시 기흥구', 2, 1100, '경기도 용인시 기흥구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1135, '용인시 수지구', 2, 1100, '경기도 용인시 수지구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1136, '용인시 처인구', 2, 1100, '경기도 용인시 처인구');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1137, '용인시 전체', 2, 1100, '경기도 용인시 전체');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1138, '의왕시', 2, 1100, '경기도 의왕시');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1139, '의정부시', 2, 1100, '경기도 의정부시');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1140, '이천시', 2, 1100, '경기도 이천시');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1141, '파주시', 2, 1100, '경기도 파주시');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1142, '평택시', 2, 1100, '경기도 평택시');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1143, '포천시', 2, 1100, '경기도 포천시');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1144, '하남시', 2, 1100, '경기도 하남시');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1145, '화성시', 2, 1100, '경기도 화성시');
insert into location (loc_num, loc, loc_level, par_loc_num, loc_path)
values (1146, '경기전체', 2, 1100, '경기도 경기 전체');


-- 카테고리 저장
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1000,'운동',1,NULL,'운동');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1100,'푸드/드링크',1,NULL,'푸드/드링크
');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1200,'문화/예술',1,NULL,'문화/예술');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1300,'여행',1,NULL,'여행');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1400,'자기계발',1,NULL,'자기계발');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1500,'원예/DIY',1,NULL,'원예/DIY');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1600,'오락',1,NULL,'오락');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1700,'사진/영상',1,NULL,'사진/영상');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1800,'음악',1,NULL,'음악');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1900,'소모임',1,NULL,'소모임');


-- 태그 저장
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1001,'피트니스',2,1000,'운동 피트니스');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1002,'축구',2,1000,'운동 축구');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1003,'농구',2,1000,'운동 농구');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1004,'야구',2,1000,'운동 야구');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1005,'테니스',2,1000,'운동 테니스');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1006,'배드민턴',2,1000,'운동 배드민턴');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1007,'골프',2,1000,'운동 골프');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1008,'러닝',2,1000,'운동 러닝');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1009,'수영',2,1000,'운동 수영');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1010,'운동전체',2,1000,'운동 운동 전체');

insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1101,'베이킹',2,1100,'푸드/드링크 베이킹');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1102,'주류',2,1100,'푸드/드링크 주류');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1103,'건강/다이어트',2,1100,'푸드/드링크 건강/다이어트');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1104,'비건/채소',2,1100,'푸드/드링크 비건/채소');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1105,'요리',2,1100,'푸드/드링크 요리');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1106,'푸드/드링크 전체',2,1100,'푸드/드링크 푸드/드링크 전체');

insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1201,'영화',2,1200,'문화/예술 영화');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1202,'연극',2,1200,'문화/예술 연극');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1203,'뮤지컬',2,1200,'문화/예술 뮤지컬');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1204,'음악회',2,1200,'문화/예술 음악회');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1205,'콘서트',2,1200,'문화/예술 콘서트');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1206,'오페라',2,1200,'문화/예술 오페라');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1207,'전시',2,1200,'문화/예술 전시');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1208,'독서',2,1200,'문화/예술 독서');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1209,'글쓰기',2,1200,'문화/예술 글쓰기');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1210,'문화/예술 전체',2,1200,'문화/예술 문화/예술 전체');

insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1301,'캠핑',2,1300,'여행 캠핑');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1302,'국내여행',2,1300,'여행 국내여행');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1303,'해외여행',2,1300,'여행 해외여행');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1304,'드라이브',2,1300,'여행 드라이브');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1305,'여행 전체',2,1300,'여행 여행 전체');

insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1401,'프로그래밍',2,1400,'자기계발 프로그래밍');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1402,'외국어',2,1400,'자기계발 외국어');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1403,'스터디',2,1400,'자기계발 스터디');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1404,'주식',2,1400,'자기계발 주식');
insert into category (cate_num,cate,cate_level,par_cate_num,cate_path)
values(1405,'자기계발 전체',2,1400,'자기계발 자기계발 전체');

insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1501, '나무/금속공예', 2, 1500, '원예/DIY 나무/금속공예');
insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1502, '가구', 2, 1500, '원예/DIY 가구');
insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1503, '꽃꽂이', 2, 1500, '원예/DIY 꽃꽂이');
insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1504, '분재', 2, 1500, '원예/DIY 분재');
insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1505, '소품', 2, 1500, '원예/DIY 소품');
insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1506, '향수', 2, 1500, '원예/DIY 향수');
insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1507, '보드게임', 2, 1500, '원예/DIY 원예/DIY 전체');

insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1601, '보드게임', 2, 1600, '오락 보드게임');
insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1602, 'PC게임', 2, 1600, '오락 PC게임');
insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1603, '방탈출', 2, 1600, '오락 방탈출');
insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1604, '오락 전체', 2, 1600, '오락 오락 전체');

insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1501, '나무/금속공예', 2, 1500, '원예/DIY 나무/금속공예');
insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1502, '가구', 2, 1500, '원예/DIY 가구');
insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1503, '꽃꽂이', 2, 1500, '원예/DIY 꽃꽂이');
insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1504, '분재', 2, 1500, '원예/DIY 분재');
insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1505, '소품', 2, 1500, '원예/DIY 소품');
insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1506, '향수', 2, 1500, '원예/DIY 향수');
insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1507, '보드게임', 2, 1500, '원예/DIY 원예/DIY 전체');

insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1601, '보드게임', 2, 1600, '오락 보드게임');
insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1602, 'PC게임', 2, 1600, '오락 PC게임');
insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1603, '방탈출', 2, 1600, '오락 방탈출');
insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1604, '오락 전체', 2, 1600, '오락 오락 전체');

insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1701, '유튜브/인터넷방송', 2, 1700, '사진/영상 유튜브/인터넷방송');
insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1702, '웹툰/웹소설/만화', 2, 1700, '사진/영상 웹툰/웹소설/만화');
insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1703, '사진촬영', 2, 1700, '사진/영상 사진촬영');
insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1704, '영상제작', 2, 1700, '사진/영상 영상제작');
insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1705, '유튜브운영', 2, 1700, '사진/영상 유튜브운영');
insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1706, '사진/영상 전체', 2, 1700, '사진/영상 사진/영상 전체');

insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1801, '악기연주', 2, 1800, '음악 악기연주');
insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1802, '작곡/프로듀싱', 2, 1800, '음악 작곡/프로듀싱');
insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1803, '보컬', 2, 1800, '음악 보컬');
insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1804, '음악감상', 2, 1800, '음악 음악감상');
insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1805, '음악 전체', 2, 1800, '음악 음악 전체');

insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1901, '맛집투어', 2, 1900, '소모임 맛집투어');
insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1902, '카페투어', 2, 1900, '소모임 카페투어');
insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1903, '동네모임', 2, 1900, '소모임 동네모임');
insert into category (cate_num, cate, cate_level, par_cate_num, cate_path)
values (1904, '소모임 전체', 2, 1900, '소모임 소모임 전체');
