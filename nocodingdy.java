package dongyun.project01;

import java.util.ArrayList;
import java.util.Scanner;

public class nocodingdy {

	private String name;
	private int age;
	private int money;
	private int happiness;
	
	public nocodingdy(String name, int age, int money, int happiness) {
		super();
		this.name = name;
		this.age = age;
		this.money = money;
		this.happiness = happiness;
	}
	
	// 쇼핑하기 메소드
	public void shopping() throws InterruptedException {
		for(int i = 1; i < 4; i++) {
			System.out.println("💰💰💰💰💰FLEX💰💰💰💰💰");
			Thread.sleep(400);
		}
		System.out.println("매일 하는 쇼핑이 끝났다.");
		System.out.println("         ↓      ");
		money -= (int)(Math.random() * 1500);
		happiness += (int)(Math.random() * 20);
		
		System.out.println("자산(하락) ⇨⇨⇨ 현재 자산 : " + money);
		System.out.println("행복지수(상승) ⇨⇨⇨ 현재 행복지수 : " + happiness);
		
	}
	
	// 운동하기 메소드
	
	public void hellth2() throws InterruptedException {
		System.out.println("최첨단 헬스장에 입장합니다.");
		
		for(int i = 1; i < 5; i++) {
			System.out.println("깔짝 💪💪 " + i + "0 kg" + " 💪💪 깔짝");
			Thread.sleep(800);
		}
		System.out.println("운동이 끝났다.");
		System.out.println("동윤이에게 변화가 생겼습니다.");
		System.out.println("         ↓      ");
		
		happiness += (int)(Math.random() * 10);
		
		System.out.println("행복지수(상승) ⇨⇨⇨ 현재 행복지수 : " + happiness);
	}
	
	// 도박하기 메소드
	
	public void gamb() throws InterruptedException {
		System.out.println("강원랜드에 입장합니다.");
		
		Scanner scan3 = new Scanner(System.in);
		
		System.out.println("1. 올인한다 | 2. 진짜 올인한다");
		System.out.print("입력 : ");
		
		int select = Integer.parseInt(scan3.nextLine());
		
	if(select == 1) {
		for(int i = 0; i < 5; i++) {
			System.out.println("ROUND. " + i + " ▶ 패배 .. 자산이 감소합니다.");
			Thread.sleep(800);
		}
		
	}else if(select == 2) {
		for(int i = 0; i < 5; i++) {
			System.out.println("ROUND. " + i + " ▶ 패배 .. 자산이 감소합니다.");
			Thread.sleep(800);
		}
		
	}
		money -= 999999999;
		System.out.println("자산(하락) ⇨⇨⇨ 현재 자산 : " + money);
	}
	
	
	// 자산 0
	public boolean nomoney() {
		if(money <= 0) {
			System.out.println("한순간에 모든 재산을 탕진했습니다.");
			System.out.println("☠☠☠GAME OVER☠☠☠");
			return true;
		}
		return false;
	}
	
	// 현재 상태 보기 메소드
	public void state2() {
		System.out.println("현재 나의 상태");
	}
	
	// 종료 메소드
	public void end2() {
		System.out.println("프로그램을 종료합니다.");
	}
	
	// 시작 문구 메소드
	public void start2() {
			System.out.println("===================================");
			System.out.println("===================================");
			System.out.println("===================================");
			System.out.println("@      !!   주의 사항    !!         @");
			System.out.println("@ ▶ 스탯은 랜덤으로 상승/하락합니다  @ ");
			System.out.println("@ ▶ 자산을 다 잃으면 GAME OVER ..   @");
			System.out.println("===================================");
			System.out.println("===================================");
			System.out.println("===================================");
		
	}
	
	
	
	
	@Override
	public String toString() {
		return "내 정보 ▶▶ 이름 : " + name + ", 나이 : " + age + ", 자산 : " + money + ", 행복지수 : " + happiness + " ◀◀";
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public int getMoney() {
		return money;
	}

	public void setMoney(int money) {
		this.money = money;
	}

	public int getHappiness() {
		return happiness;
	}

	public void setHappiness(int happiness) {
		this.happiness = happiness;
	}
	
	
	
	
	
	
	
	
	
}
