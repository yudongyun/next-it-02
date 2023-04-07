package ch09_class.school;

import ch09_class.commons.UtilClass;

public class Student {

	// 1. 필드변수 선언
	// private 접근제어자
	// public : 공개, 프로젝트 내부 어디서든 접근 가능
	// private : 비공개, 현재 클래스 내에서만 접근이 가능
	// (default) : 같은 폴더 내에 있는 클래스에서만 접근이 가능함
	// 캡슐화는 필드 변서 접근 제어자를 전부 private 으로 만든다.
	private String name;
	private int guk;
	private int eng;
	private int mat;
	private double avg = UtilClass.weRound(((guk + eng + mat) / 3.0), 1);

	public Student() {
	}

	// 2. 생성자 만들기( + 기본 생성자 )
	public Student(String name, int guk, int eng, int mat, double avg) {
		this.name = name;
		this.guk = guk;
		this.eng = eng;
		this.mat = mat;
		this.avg = avg;
	}

	// 평균을 기본값으로 입력해주는 생성자
	public Student(String name, int guk, int eng, int mat) {
		this.name = name;
		this.guk = guk;
		this.eng = eng;
		this.mat = mat;
		this.avg = UtilClass.weRound(((guk + eng + mat) / 3.0), 1);
	}

	// 변경된 점수에 대해 평균을 고치는 메소드
	// 현재 클래스 내부에서만 사용되므로 private 으로 한다.
	private void setAvg() {
		avg = UtilClass.weRound((guk + eng + mat) / 3.0, 1);

	}

	// 3. toString() 추가
	@Override
	public String toString() {
		return "[" + name + ", 국어 : " + guk + ", 영어 : " + eng + ", 수학 : " + mat + ", 평균 : " + avg + "]";
	}

	// private으로 접근을 막은 필드 변수에 대해
	// Getters and Setters 로 접근을 허용한다.
	// 단축키 [Alt + Shift + S]
	// Generate Getters and Setters

	// getter
	public String getName() {
		return name;
	}

	// setter
	public void setName(String name) {
		this.name = name;
	}

	public int getGuk() {
		return guk;
	}

	public void setGuk(int guk) {
		this.guk = guk;
		setAvg();

	}

	public int getEng() {
		return eng;
	}

	public void setEng(int eng) {
		this.eng = eng;
		setAvg();
	}

	public int getMat() {
		return mat;
	}

	public void setMat(int mat) {
		this.mat = mat;
		setAvg();
	}

	public double getAvg() {
		return avg;
	}

}
