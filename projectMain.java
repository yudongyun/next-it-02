package dongyun.project01;

import java.util.ArrayList;
import java.util.Scanner;

public class projectMain {

	public static void main(String[] args) throws InterruptedException {

		
		// 동윤이 객체 생성
		codingdy dy = new codingdy("동윤", 27, 1, 50, 60, 40);
		
		System.out.println(dy);
		
		
		Scanner scan = new Scanner(System.in);
		
		System.out.println("오늘 뭐하지 ?");
		
		while(true) {
			System.out.println("1. 넥스트 가서 공부 | 2. 둔산동에서 술한잔 | 3. 드라이브 | 4. 휴식");
			System.out.println("입력 : ");
			
			int command = Integer.parseInt(scan.nextLine());
			
			if(command == 1) {
				// TODO 공부하기
				dy.study();
			}else if(command == 2) {
				// TODO 놀기
				dy.party();
			}else if(command == 3) {
				// TODO 드라이브
			}
			
			
			
			
			
			
			
			
			
			
		}
		
		
		
		
		
		
		
		
		
		
	}

}
