package vo;

import java.util.Date;

public class Contest_BoardVO {
	int contest_seq;
	String c_title;
	String c_contents;
	String writer;
	int c_viewcount;
	int c_like;
	Date cdate;
	int round;
	int c_file;	
	
	public int getContest_seq() {
		return contest_seq;
	}
	public void setContest_seq(int contest_seq) {
		this.contest_seq = contest_seq;
	}
	public String getC_title() {
		return c_title;
	}
	public void setC_title(String c_title) {
		this.c_title = c_title;
	}
	public String getC_contents() {
		return c_contents;
	}
	public void setC_contents(String c_contents) {
		this.c_contents = c_contents;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public int getC_viewcount() {
		return c_viewcount;
	}
	public void setC_viewcount(int c_viewcount) {
		this.c_viewcount = c_viewcount;
	}
	public int getC_like() {
		return c_like;
	}
	public void setC_like(int c_like) {
		this.c_like = c_like;
	}
	public Date getCdate() {
		return cdate;
	}
	public void setCdate(Date cdate) {
		this.cdate = cdate;
	}
	public int getRound() {
		return round;
	}
	public void setRound(int round) {
		this.round = round;
	}
	public int getC_file() {
		return c_file;
	}
	public void setC_file(int c_file) {
		this.c_file = c_file;
	}
	
}
