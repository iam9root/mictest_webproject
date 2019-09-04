package vo;

public class goldVO {
	private String nick;
	private String artist_Name;
	private String file_name;
	private String profile_Img;
	
	public String getProfile_Img() {
		return profile_Img;
	}
	public void setProfile_Img(String profile_Img) {
		this.profile_Img = profile_Img;
	}
	public String getFile_name() {
		return file_name;
	}
	public void setFile_name(String file_name) {
		this.file_name = file_name;
	}
	public String getNick() {
		return nick;
	}
	public void setNick(String nick) {
		this.nick = nick;
	}
	public String getArtist_Name() {
		return artist_Name;
	}
	public void setArtist_Name(String artist_Name) {
		this.artist_Name = artist_Name;
	}
	public String getMusic_Name() {
		return music_Name;
	}
	public void setMusic_Name(String music_Name) {
		this.music_Name = music_Name;
	}
	private String music_Name;
}
