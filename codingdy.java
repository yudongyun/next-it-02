package dongyun.project01;

public class codingdy {

	private String name;
	private int age;
	private int codinglevel;
	private int confidence;
	private int strength;
	private int happiness;
	
	
	
	public codingdy() {}
	
	
	public codingdy(String name, int age, int codinglevel, int confidence, int strength, int happiness) {
		super();
		this.name = name;
		this.age = age;
		this.codinglevel = codinglevel;
		this.confidence = confidence;
		this.strength = strength;
		this.happiness = happiness;
	}

	// 공부하기 메소드
	public void study() throws InterruptedException {
		for(int i = 0; i < 5; i++) {
			System.out.println("java ch"+ i + " 마스터 !!");
			Thread.sleep(1200);
		}
		
		System.out.println("       ↓      ");
		System.out.println("java를 공부했다.");
		System.out.println("동윤이에게 변화가 생겼습니다.");
		System.out.println("      ↓      ");
		codinglevel++;
		happiness -= (int)(Math.random() * 10);;
		strength -= (int)(Math.random() * 15);;
		
		System.out.println("코딩레벨(상승) ⇨⇨⇨ 현재 레벨 : " + codinglevel);
		System.out.println("행복지수(하락)   ⇨⇨⇨ 현재 행복지수 : " + happiness);
		System.out.println("체력(하락)     ⇨⇨⇨ 현재 체력 : " + strength);
	}
	
	// 놀기 메소드
	public void party() throws InterruptedException {
		System.out.println("🍺▶◀▶◀▶◀▶◀▶◀▶◀▶◀▶◀▶◀▶◀▶◀▶◀▶◀ ");
		Thread.sleep(400);
		System.out.println("🍺빰 빰 빰 빰 빰 빰 빰 빠바 ! ");
		Thread.sleep(400);
		System.out.println("🍺술이 들어간다 쭉쭉쭉쭉쭉 !  ");
		Thread.sleep(400);
		System.out.println("🍺으우웩 ");
		Thread.sleep(400);
		System.out.println("🍺빰 빰 빰 빰 빰 빰 빰 빠바 ! ");
		Thread.sleep(400);
		System.out.println("🍺▶◀▶◀▶◀▶◀▶◀▶◀▶◀▶◀▶◀▶◀▶◀▶◀▶◀ ");
		Thread.sleep(400);
		System.out.println("🍺동윤이에게 변화가 생겼습니다. ");
		System.out.println("             ↓      ");
		codinglevel -= 1;
		strength -= (int)(Math.random() * 20);
		happiness += (int)(Math.random() * 15);
		
		System.out.println("코딩레벨(하락) ⇨⇨⇨ 현재 레벨 : " + codinglevel);
		System.out.println("체력(하락)     ⇨⇨⇨ 현재 체력 : " + strength);
		System.out.println("행복지수(상승)  ⇨⇨⇨ 현재 행복지수: " + happiness);
		
	}
	
	// 운동 메소드
	public void hellth() throws InterruptedException {
		for(int i = 1; i < 7; i++) {
			System.out.println(i+"0 kg ..");
			Thread.sleep(800);
		}
		System.out.println("운동이 끝났다.");
		System.out.println("동윤이에게 변화가 생겼습니다.");
		System.out.println("             ↓      ");
		confidence += (int)(Math.random() * 8);
		strength -= (int)(Math.random() * 15);
		happiness += (int)(Math.random() * 10);
		
		System.out.println("자신감(상승) ⇨⇨⇨ 현재 자신감 : " + confidence);
		System.out.println("체력(하락)     ⇨⇨⇨ 현재 체력 : " + strength);
		System.out.println("행복지수(상승)  ⇨⇨⇨ 현재 행복지수: " + happiness);
		
	}
	
	// 휴식 메소드
	public void free() {
		System.out.println("휴식이 끝났다.");
		System.out.println("동윤이에게 변화가 생겼습니다.");
		System.out.println("             ↓      ");
		
		codinglevel -= (int)(Math.random() * 2);;
		strength += (int)(Math.random() * 15);
		
		System.out.println("코딩레벨(??) ⇨⇨⇨ 현재 레벨 : " + codinglevel);
		System.out.println("체력(상승)     ⇨⇨⇨ 현재 체력 : " + strength);
	}
	
	// 현재 상태 보기 메소드
	public void state() {
		System.out.println("현재 나의 상태");
		}
	
	// 종료 메소드
	public void end() {
		System.out.println("프로그램을 종료합니다.");
	}
	
	
	// 체력 0 
	public boolean endstreng() {
		if(strength <= 0) {
			System.out.println("체력이 전부 소진 되었습니다.");
			System.out.println("☠☠☠GAME OVER☠☠☠");
			return true;
		}
		return false;
		
	}
	
	// 헁복지수 0
	public boolean unhappy() {
		if(happiness <= 0) {
			System.out.println("동윤이는 더 이상 행복하지 않습니다..");
			System.out.println("☠☠☠GAME OVER☠☠☠");
			return true;
		}
		return false;
	}
	
	// 코딩레벨 max
	public boolean codingmaster() {
		if(codinglevel >= 10) {
			System.out.println("동윤이는 정식 개발자가 되었습니다.");
			System.out.println("☠☠☠VICTORY☠☠☠");
			return true;
		}
		return false;
	}
	
	// 코딩레벨 0
	public boolean nocodingmaster() {
		if(codinglevel <= 0) {
			System.out.println("동윤이는 개발자를 포기했습니다.");
			System.out.println("☠☠☠GAME OVER☠☠☠");
			return true;
		}
		return false;
		
	}
	
	
	// 시작 문구 메소드
	public void start() {
		System.out.println("===================================");
		System.out.println("===================================");
		System.out.println("===================================");
		System.out.println("@      !!   주의 사항    !!        @");
		System.out.println("@ ▶ 스탯은 랜덤으로 상승/하락합니다  @ ");
		System.out.println("@ ▶ 체력 = 0 사망                  @");
		System.out.println("@ ▶ 스트레스 = 0 사망              @");
		System.out.println("@ ▶ 코딩레벨 = 0 GAME OVER         @");
		System.out.println("@ ▶ 코딩레벨 = 10 VICTORY !        @");
		System.out.println("===================================");
		System.out.println("===================================");
		System.out.println("===================================");
	}
	
	
	
	
	
	
	@Override
	public String toString() {
		return " 내 정보 ▶▶ 이름 : " + name + ", 나이 : " + age + ", 코딩실력 : " + codinglevel + ", 자신감 : " + confidence
				+ ", 체력 : " + strength + ", 행복지수 : " + happiness + "◀◀";
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


	public int getCodinglevel() {
		return codinglevel;
	}


	public void setCodinglevel(int codinglevel) {
		this.codinglevel = codinglevel;
	}


	public int getConfidence() {
		return confidence;
	}


	public void setConfidence(int confidence) {
		this.confidence = confidence;
	}


	public int getStrength() {
		return strength;
	}


	public void setStrength(int strength) {
		this.strength = strength;
	}


	public int getHappiness() {
		return happiness;
	}


	public void setHappiness(int happiness) {
		this.happiness = happiness;
	}

	
	
	
	
	
	
	
	
	
}
