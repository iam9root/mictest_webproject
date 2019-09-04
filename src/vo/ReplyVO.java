package vo;

import java.util.Date;

public class ReplyVO {
	int c_0_f_1;
	int board_seq;
	int cm_seq;
	String cm_contents;
	String writer;
	Date cmdate;
	
	public int getC_0_f_1() {
		return c_0_f_1;
	}
	public void setC_0_f_1(int c_0_f_1) {
		this.c_0_f_1 = c_0_f_1;
	}
	public int getBoard_seq() {
		return board_seq;
	}
	public void setBoard_seq(int board_seq) {
		this.board_seq = board_seq;
	}
	public int getCm_seq() {
		return cm_seq;
	}
	public void setCm_seq(int cm_seq) {
		this.cm_seq = cm_seq;
	}
	public String getCm_contents() {
		return cm_contents;
	}
	public void setCm_contents(String cm_contents) {
		this.cm_contents = cm_contents;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public Date getCmdate() {
		return cmdate;
	}
	public void setCmdate(Date cmdate) {
		this.cmdate = cmdate;
	}
	
}
