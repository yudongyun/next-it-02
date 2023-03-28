package dongyun.submit04;

import java.util.Scanner;

public class submit04 {

	public static void main(String[] args) {
		
		
		
		Scanner scan = new Scanner(System.in);
		System.out.println("거꾸로 뒤집을 문자열 입력");
		System.out.print(">>>>    ");
		
		String RR = scan.nextLine();
		
		System.out.println("뒤집은 결과");
		System.out.print(">>>>    ");
		
		
		String stkk = "";
		for(int i = RR.length(); i > 0; i--){
			
			String str = RR.substring(i-1, i);
			stkk += str;
		}
		
		System.out.println(stkk);
		
		
		System.out.println("\n============================\n");
		
		
		
				int EVA = 10;
				int EVB = 4;
				
			while(true) {
			System.out.println("\n===========희영빌딩 엘베=================\n");
			Scanner scanA = new Scanner(System.in);
			
			System.out.println("승강기 A의 현재 위치 :" + EVA + "층");
			System.out.println("승강기 B의 현재 위치 :" + EVB + "층");
			System.out.println("몇층에 있나요 ?[종료하시려면 q 또는 exit 입력] ");
			String strA = scanA.nextLine();
			
			if((EVA - Integer.parseInt(strA)) > (EVB - Integer.parseInt(strA))) {
				System.out.println(EVB + "층에서 엘리베이터를 호출합니다.");
				System.out.println("승강기 B가 " + strA + "층으로 이동했습니다.");
				EVB = Integer.parseInt(strA);
				
			}else if((EVA - Integer.parseInt(strA)) > (EVB - Integer.parseInt(strA))) {
				System.out.println(EVB + "층에서 엘리베이터를 호출합니다.");
				System.out.println("승강기 B가 " + strA + "층으로 이동했습니다.");
				EVB = Integer.parseInt(strA);
				
			}else if(Math.abs((EVA - Integer.parseInt(strA))) == Math.abs((EVB - Integer.parseInt(strA)))) {
				if(EVA > EVB || EVA == EVB) {
					System.out.println(EVA + "층에서 엘리베이터를 호출합니다.");
					System.out.println("승강기 A가 " + strA + "층으로 이동했습니다.");
					EVA = Integer.parseInt(strA);
				}else if(EVA < EVB) {
					System.out.println(EVB + "층에서 엘리베이터를 호출합니다.");
					System.out.println("승강기 B가 " + strA + "층으로 이동했습니다.");
					EVB = Integer.parseInt(strA);
				}
		
			}
		
		
		
		
			}
		
	}

}
