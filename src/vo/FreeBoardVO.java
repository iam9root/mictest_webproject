package vo;

public class FreeBoardVO {
	private int free_board_seq;
	private String f_title;
	private String f_contents;
	private String writer;
	private String fdate;
	private int f_viewcount;
	private int category;
	private String nickname;
	private int boardNum;
	
	//Constructor Overriding
	public FreeBoardVO() {};
	public FreeBoardVO(int free_board_seq, String f_title, String f_contents, String writer, String fdate,
			int f_viewcount, int category) {
		this.free_board_seq = free_board_seq;
		this.f_title = f_title;
		this.f_contents = f_contents;
		this.writer = writer;
		this.fdate = fdate;
		this.f_viewcount = f_viewcount;
		this.category = category;
	}
	public FreeBoardVO(String f_title, String f_contents, String writer) {
		this.f_title = f_title;
		this.f_contents = f_contents;
		this.writer = writer;
	}
	//getters and setters
	public int getFree_board_seq() {
		return free_board_seq;
	}
	public void setFree_board_seq(int free_board_seq) {
		this.free_board_seq = free_board_seq;
	}
	public String getF_title() {
		return f_title;
	}
	public void setF_title(String f_title) {
		this.f_title = f_title;
	}
	public String getF_contents() {
		return f_contents;
	}
	public void setF_contents(String f_contents) {
		this.f_contents = f_contents;
	}
	public String getWriter() {
		return writer;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public String getFdate() {
		return fdate;
	}
	public void setFdate(String fdate) {
		this.fdate = fdate;
	}
	public int getF_viewcount() {
		return f_viewcount;
	}
	public void setF_viewcount(int f_viewcount) {
		this.f_viewcount = f_viewcount;
	}
	public int getCategory() {
		return category;
	}
	public void setCategory(int category) {
		this.category = category;
	}
	public String getNickname() {
		return nickname;
	}
	public void setNickname(String nickname) {
		this.nickname = nickname;
	}
	public int getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}
}
