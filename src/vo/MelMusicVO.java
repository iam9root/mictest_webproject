package vo;

public class MelMusicVO {
	private int music_seq;		//음악 넣고뺄때마다 생기는 sequence
	private String real_singer;	//가수
	private String real_title;	//제목
	private String real_album;	//앨범명
	private int numberofsingusers;//이 노래를 부른 사람 수
	
	public int getMusic_seq() {
		return music_seq;
	}
	public void setMusic_seq(int music_seq) {
		this.music_seq = music_seq;
	}
	public String getReal_singer() {
		return real_singer;
	}
	public void setReal_singer(String real_singer) {
		this.real_singer = real_singer;
	}
	public String getReal_title() {
		return real_title;
	}
	public void setReal_title(String real_title) {
		this.real_title = real_title;
	}
	public String getReal_album() {
		return real_album;
	}
	public void setReal_album(String real_album) {
		this.real_album = real_album;
	}
	public int getNumberofsingusers() {
		return numberofsingusers;
	}
	public void setNumberofsingusers(int numberofsingusers) {
		this.numberofsingusers = numberofsingusers;
	}
	
}
