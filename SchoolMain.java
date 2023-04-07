package ch09_class.school;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;

import ch09_class.commons.UtilClass;
import ch09_class.nextit.NextStudent;

public class SchoolMain {

	public static void main(String[] args) {
		// 국어, 영어, 수학, 평균 점수를 가지는 학생 객체
		Student yesl = new Student("예슬", 85, 80, 87, (85 + 80 + 87) / 3.0);

		System.out.println(yesl);

		// 캡슐화 적용
		// 같은 폴더 내에 있는 클래스라면 private 빼곤 다 접근 가능

		// avg에 대한 setter를 지워서 평균은 수정이 불가능하도록 함
//		yesl.setAvg(100);

		System.out.println(yesl);

		System.out.println(yesl.getGuk());
		System.out.println(yesl.getAvg());

		// 국어 점수 바꾸기
		yesl.setGuk(93);
		System.out.println(yesl);

		System.out.println("\n----------------------\n");

		Student jihye = new Student("지혜", 20, 25, 36, UtilClass.weRound((20 + 25 + 36) / 3.0, 1));

		System.out.println(jihye);

		jihye.setEng(86);
		System.out.println(jihye);

		// 평균을 넣지 않아도 적용되도록 생성자 추가
		Student taeyun = new Student("태윤", 92, 83, 78);
		System.out.println(taeyun);

		System.out.println("\n----------------------\n");

		ArrayList<Student> stuList = new ArrayList<>();

		stuList.add(yesl);
		stuList.add(jihye);
		stuList.add(taeyun);
		stuList.add(new Student("찬웅쌤", 30, 40, 23));
		stuList.add(new Student("동윤", 90, 95, 97));

		for (int i = 0; i < stuList.size(); i++) {

			System.out.println(stuList.get(i));

		}

		System.out.println("\n----------------------\n");

		// 학생들의 평균을 이용해서 1등. 동윤 ......
		// 정렬하기

		for (int k = 0; k < stuList.size() - 1; k++) {

			for (int i = 0; i < stuList.size() - 1; i++) {
				// i > i+1 하면 오름차순
				// i < i+1 하면 내림차순
				if (stuList.get(i).getAvg() < stuList.get(i + 1).getAvg()) {
					Student t = stuList.get(i);
					stuList.set(i, stuList.get(i + 1));
					stuList.set(i + 1, t);
				}
			}
		}
		for (int i = 0; i < stuList.size(); i++) {
			System.out.println((i + 1) + "등. " + stuList.get(i));
		}

		System.out.println("\n----------------------\n");

		// Collections.sort()

		Collections.sort(stuList, new Comparator<Student>() {

			@Override
			public int compare(Student stuA, Student stuB) {
				double diff = stuA.getAvg() - stuB.getAvg();
				// 양의 소수, 음의 소수
				if (diff < 0) {
					// 음의정수
					return -1;
				}
				return 1;

			}
		});
		
		Collections.sort(stuList, (stuA, stuB)
				-> (stuA.getAvg() - stuB.getAvg() > 0) ? (1) : (-1));

		for (int i = 0; i < stuList.size(); i++) {
			System.out.println((i + 1) + "등. " + stuList.get(i));
		}

		
		
	}

}
