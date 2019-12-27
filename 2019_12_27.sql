/* 게시판 */
DROP TABLE boardMaster 
	CASCADE CONSTRAINTS;

/* 사용자 */
DROP TABLE users 
	CASCADE CONSTRAINTS;

/* 게시글 */
DROP TABLE board 
	CASCADE CONSTRAINTS;

/* 댓글 */
DROP TABLE reply 
	CASCADE CONSTRAINTS;

/* 첨부파일 */
DROP TABLE attachFile 
	CASCADE CONSTRAINTS;

/* 게시판 시퀀스 */
DROP SEQUENCE seq_boardMaster;

/* 게시글 시퀀스 */
DROP SEQUENCE seq_board;

/* 댓글 시퀀스 */
DROP SEQUENCE seq_reply;

/* 첨부파일 시퀀스 */
DROP SEQUENCE seq_attachfile;

/* 게시판 시퀀스 */
CREATE SEQUENCE seq_boardMaster;

/* 게시글 시퀀스 */
CREATE SEQUENCE seq_board;

/* 댓글 시퀀스 */
CREATE SEQUENCE seq_reply;

/* 첨부파일 시퀀스 */
CREATE SEQUENCE seq_attachfile;

/* 게시판 */
CREATE TABLE boardMaster (
	id NUMBER NOT NULL, /* 게시판ID */
	nm VARCHAR2(150) NOT NULL, /* 게시판이름 */
	ac_yn VARCHAR2(1) DEFAULT 'Y' NOT NULL, /* 활성여부 */
	reg_id VARCHAR2(20) NOT NULL, /* 작성자 */
	reg_dt DATE NOT NULL /* 작성일시 */
);

COMMENT ON TABLE boardMaster IS '게시판';

COMMENT ON COLUMN boardMaster.id IS '게시판ID';

COMMENT ON COLUMN boardMaster.nm IS '게시판이름';

COMMENT ON COLUMN boardMaster.ac_yn IS '활성여부';

COMMENT ON COLUMN boardMaster.reg_id IS '작성자';

COMMENT ON COLUMN boardMaster.reg_dt IS '작성일시';

CREATE UNIQUE INDEX PK_boardMaster
	ON boardMaster (
		id ASC
	);

ALTER TABLE boardMaster
	ADD
		CONSTRAINT PK_boardMaster
		PRIMARY KEY (
			id
		);

/* 사용자 */
CREATE TABLE users (
	userid VARCHAR2(20) NOT NULL, /* 사용자아이디 */
	pass VARCHAR2(20), /* 비밀번호 */
	usernm VARCHAR2(20), /* 사용자이름 */
	alias VARCHAR2(20) /* 별명 */
);

COMMENT ON TABLE users IS '사용자';

COMMENT ON COLUMN users.userid IS '사용자아이디';

COMMENT ON COLUMN users.pass IS '비밀번호';

COMMENT ON COLUMN users.usernm IS '사용자이름';

COMMENT ON COLUMN users.alias IS '별명';

CREATE UNIQUE INDEX PK_users
	ON users (
		userid ASC
	);

ALTER TABLE users
	ADD
		CONSTRAINT PK_users
		PRIMARY KEY (
			userid
		);

/* 게시글 */
CREATE TABLE board (
	id NUMBER NOT NULL, /* 게시글ID */
	bm_id NUMBER NOT NULL, /* 게시판ID */
	p_id NUMBER, /* 부모게시글번호 */
	title VARCHAR2(255) NOT NULL, /* 제목 */
	cont CLOB NOT NULL, /* 내용 */
	del_yn VARCHAR2(1) DEFAULT 'Y' NOT NULL, /* 삭제여부 */
	reg_id VARCHAR2(20) NOT NULL, /* 작성자 */
	reg_dt DATE NOT NULL /* 작성일시 */
);

COMMENT ON TABLE board IS '게시글';

COMMENT ON COLUMN board.id IS '게시글ID';

COMMENT ON COLUMN board.bm_id IS '게시판ID';

COMMENT ON COLUMN board.p_id IS '부모게시글번호';

COMMENT ON COLUMN board.title IS '제목';

COMMENT ON COLUMN board.cont IS '내용';

COMMENT ON COLUMN board.del_yn IS '삭제여부';

COMMENT ON COLUMN board.reg_id IS '작성자';

COMMENT ON COLUMN board.reg_dt IS '작성일시';

CREATE UNIQUE INDEX PK_board
	ON board (
		id ASC
	);

ALTER TABLE board
	ADD
		CONSTRAINT PK_board
		PRIMARY KEY (
			id
		);

/* 댓글 */
CREATE TABLE reply (
	id NUMBER NOT NULL, /* 댓글ID */
	b_id NUMBER NOT NULL, /* 게시글ID */
	cont VARCHAR2(1500) NOT NULL, /* 내용 */
	reg_id VARCHAR2(20) NOT NULL, /* 작성자 */
	reg_dt DATE NOT NULL /* 작성일시 */
);

COMMENT ON TABLE reply IS '댓글';

COMMENT ON COLUMN reply.id IS '댓글ID';

COMMENT ON COLUMN reply.b_id IS '게시글ID';

COMMENT ON COLUMN reply.cont IS '내용';

COMMENT ON COLUMN reply.reg_id IS '작성자';

COMMENT ON COLUMN reply.reg_dt IS '작성일시';

CREATE UNIQUE INDEX PK_reply
	ON reply (
		id ASC
	);

ALTER TABLE reply
	ADD
		CONSTRAINT PK_reply
		PRIMARY KEY (
			id
		);

/* 첨부파일 */
CREATE TABLE attachFile (
	id NUMBER NOT NULL, /* 첨부파일번호 */
	b_id NUMBER NOT NULL, /* 게시글ID */
	nm VARCHAR2(500) NOT NULL /* 첨부파일명 */
);

COMMENT ON TABLE attachFile IS '첨부파일';

COMMENT ON COLUMN attachFile.id IS '첨부파일번호';

COMMENT ON COLUMN attachFile.b_id IS '게시글ID';

COMMENT ON COLUMN attachFile.nm IS '첨부파일명';

CREATE UNIQUE INDEX PK_attachFile
	ON attachFile (
		id ASC
	);

ALTER TABLE attachFile
	ADD
		CONSTRAINT PK_attachFile
		PRIMARY KEY (
			id
		);

ALTER TABLE boardMaster
	ADD
		CONSTRAINT FK_users_TO_boardMaster
		FOREIGN KEY (
			reg_id
		)
		REFERENCES users (
			userid
		);

ALTER TABLE board
	ADD
		CONSTRAINT FK_users_TO_board
		FOREIGN KEY (
			reg_id
		)
		REFERENCES users (
			userid
		);

ALTER TABLE board
	ADD
		CONSTRAINT FK_boardMaster_TO_board
		FOREIGN KEY (
			bm_id
		)
		REFERENCES boardMaster (
			id
		);

ALTER TABLE board
	ADD
		CONSTRAINT FK_board_TO_board
		FOREIGN KEY (
			p_id
		)
		REFERENCES board (
			id
		);

ALTER TABLE reply
	ADD
		CONSTRAINT FK_users_TO_reply
		FOREIGN KEY (
			reg_id
		)
		REFERENCES users (
			userid
		);

ALTER TABLE reply
	ADD
		CONSTRAINT FK_board_TO_reply
		FOREIGN KEY (
			b_id
		)
		REFERENCES board (
			id
		);

ALTER TABLE attachFile
	ADD
		CONSTRAINT FK_board_TO_attachFile
		FOREIGN KEY (
			b_id
		)
		REFERENCES board (
			id
		);