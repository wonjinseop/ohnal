package com.ohnal.chap.service;

import com.ohnal.chap.dto.response.WeatherInfoResponseDTO;
import com.ohnal.chap.mapper.WeatherMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.stereotype.Service;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;

@Service
@Slf4j
@RequiredArgsConstructor
public class WeatherService {
    private final WeatherMapper mapper;

    public WeatherInfoResponseDTO getShortTermForecast(String area1, String area2) {

        LocalDateTime now = LocalDateTime.now();
        String baseDate = DateTimeFormatter.ofPattern("yyyyMMdd").format(now);

        // 요청 시간을 기준으로 날씨를 받아오기 위해 요청 시간 얻기, 분 단위는 절삭
        String presentTime = DateTimeFormatter.ofPattern("HH00").format(now);

        double tmx = 0; // 최고기온
        double tmn = 0; // 최저기온
        int tmp = 0; // 현재기온
        int pty = 0; // 현재 강수 형태
        int sky = 0; // 현재 하늘 상태


        // map의 키가 컬럼값임. nx의 value가 map의 value다.
        Map<String, Object> map = mapper.getCode(area1, area2.replace(" ", ""));
        log.info("map에 담긴 값 {}", map);
        String newArea1 = map.get("area1").toString();
        String newArea2 = map.get("area2").toString();
        log.info("new Area1: {}", newArea1);
        log.info("new Area2: {}", newArea2);

        try {

            StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst"); /*URL*/
            urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=8LF4JSqJGbyzomL5iWo1ETi%2FcSmIbBi%2B%2BpgAK0OWEtoE41lgJHyGCBaKsdY07jLNQcvh%2FQM2CmkKd%2Bgqvwk0mQ%3D%3D"); /*Service Key*/
            urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
            urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("300", "UTF-8")); /*한 페이지 결과 수*/
            urlBuilder.append("&" + URLEncoder.encode("dataType", "UTF-8") + "=" + URLEncoder.encode("JSON", "UTF-8")); /*요청자료형식(XML/JSON) Default: XML*/
            urlBuilder.append("&" + URLEncoder.encode("base_date", "UTF-8") + "=" + URLEncoder.encode(baseDate, "UTF-8")); /*'클라이언트 요청일 발표*/
            urlBuilder.append("&" + URLEncoder.encode("base_time", "UTF-8") + "=" + URLEncoder.encode("0200", "UTF-8")); /*02시 발표(정시단위) */
            urlBuilder.append("&" + URLEncoder.encode("nx", "UTF-8") + "=" + URLEncoder.encode(String.valueOf(map.get("nx")), "UTF-8")); /*예보지점의 X 좌표값*/
            urlBuilder.append("&" + URLEncoder.encode("ny", "UTF-8") + "=" + URLEncoder.encode(String.valueOf(map.get("ny")), "UTF-8")); /*예보지점의 Y 좌표값*/

            log.info("완성된 URL: {}", urlBuilder.toString());

            URL url = new URL(urlBuilder.toString());
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-type", "application/json");
            System.out.println("Response code: " + conn.getResponseCode());

            BufferedReader rd;
            // 서비스 코드가 정상이면 200~300사이의 숫자가 나온다. - conn을 이용해 데이터 읽고 쓰기
            if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
                rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
            } else {
                rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
            }

            StringBuilder sb = new StringBuilder();
            String line;

            while ((line = rd.readLine()) != null) {
                sb.append(line);
            }
            rd.close();
            conn.disconnect();


            // StringBuilder를 String으로 변환
            String jsonString = sb.toString();

            JSONParser parser = new JSONParser();

            // String 객체를 JSON객체로 변경해 줌.
            JSONObject jsonObject = (JSONObject) parser.parse(jsonString);

            // "response"라는 이름의 키에 해당하는 JSON 데이터를 가져옵니다.
            JSONObject response = (JSONObject) jsonObject.get("response");

            // response 안에서 body 키에 해당하는 JSON 데이터를 가져옵니다.
            JSONObject body = (JSONObject) response.get("body");

            // body에서 items를 꺼내세요.
            JSONObject items = (JSONObject) body.get("items");
//            log.info("items: {}", items);

            // item이라는 키를 가진 JSON 데이터를 가져올건데,
            // item 데이터는 여러 값이기 때문에 배열의 문법을 제공하는 객체로 받습니다.
            JSONArray itemArray = (JSONArray) items.get("item");

            // 반복문을 이용해서 객체를 하나씩 취득한 후에 원하는 로직을 작성합니다.
            for (Object obj : itemArray) {

                // Object를 JSON객체로 변환
                JSONObject item = (JSONObject) obj;
                // "category" 키에 해당하는 단일 값을 가져옵니다.
                String category = (String) item.get("category");
                // "fcstValue" 키에 해당하는 단일 값을 가져옵니다.
                String fcstValue = (String) item.get("fcstValue");

                // TMX - 최고 기온, TMN - 최저 기온, PTY - 강수형태, SKY - 하늘 상태
                if (category.equals("TMX")) {
                    log.info("최고기온 = " + fcstValue);
                    tmx = Double.parseDouble(fcstValue);
                } else if (category.equals("TMN")) {
                    log.info("최저기온 = " + fcstValue);
                    tmn = Double.parseDouble(fcstValue);
                }

                if (item.get("baseDate").equals(baseDate) && item.get("fcstTime").equals(presentTime)) {
                    if (category.equals("TMP")) {
                        tmp = Integer.parseInt(fcstValue);
                        log.info(String.valueOf(tmp));
                    } else if (category.equals("SKY")) {
                        sky = Integer.parseInt(fcstValue);
                        log.info(String.valueOf(sky));
                    } else if (category.equals("PTY")) {
                        pty = Integer.parseInt(fcstValue);
                        log.info(String.valueOf(pty));
                    }
                }
            }

            String clothesInfo = mapClothes(tmx, tmn); // 옷 정보 담기
            String weatherIcon = mapIcon(sky, pty, now); // sky(현재 하늘 상태), pty(현재 강수 형태) 기반으로 Icon 담기
            if (newArea2.length() >= 5) { // area2 지역명 띄어쓰기가 필요한 경우 공백 삽입하기 예) 청주시 상당구
                newArea2 = newArea2.substring(0, 3) + " " + newArea2.substring(3);
            }

            return WeatherInfoResponseDTO
                    .builder()
                    .area1(newArea1)
                    .area2(newArea2)
                    .comment(clothesInfo)
                    .maxTemperature(tmx)
                    .minTemperature(tmn)
                    .styleImage(clothesInfo)
                    .presentTemperature(tmp)
                    .weatherIcon(weatherIcon)
                    .build();

        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    private String mapIcon(int sky, int pty, LocalDateTime present) {

        log.info(String.valueOf(present.getHour()));
        String weatherIcon = "";
        if (present.getHour() >= 6 && present.getHour() <= 18) { // day(태양 그림 6~18시 노출)
            if (sky == 1 && pty == 0) {
                weatherIcon = "sunny-day";
            } else if (sky == 1 && (pty == 1 || pty == 4)) {
                weatherIcon = "sunny-cloudy-rainy-day";
            } else if (sky == 1 && pty == 2) {
                weatherIcon = "sunny-cloudy-rainy-day";
            } else if (sky == 1 && pty == 3) {
                weatherIcon = "sunny-cloudy-snowy-day";
            } else if (sky == 3 && pty == 0) {
                weatherIcon = "sunny-cloudy-day";
            } else if (sky == 3 && (pty == 1 || pty == 4)) {
                weatherIcon = "sunny-cloudy-rainy-day";
            } else if (sky == 3 && pty == 2) {
                weatherIcon = "sunny-cloudy-rainy-day";
            } else if (sky == 3 && pty == 3) {
                weatherIcon = "sunny-cloudy-snowy-day";
            } else if (sky == 4 && pty == 0) {
                weatherIcon = "only-cloudy";
            } else if (sky == 4 && (pty == 1 || pty == 4)) {
                weatherIcon = "only-cloudy-rainy";
            } else if (sky == 4 && pty == 2) {
                weatherIcon = "only-cloudy-rainy";
            } else if (sky == 4 && pty == 3) {
                weatherIcon = "only-cloudy-snowy";
            }
        } else { // night(달, 혹은 태양 그림 없이 노출)
            if (sky == 1 && pty == 0) {
                weatherIcon = "sunny-night";
            } else if (sky == 1 && (pty == 1 || pty == 4)) {
                weatherIcon = "sunny-cloudy-rainy";
            } else if (sky == 1 && pty == 2) {
                weatherIcon = "sunny-cloudy-rainy";
            } else if (sky == 1 && pty == 3) {
                weatherIcon = "sunny-cloudy-snowy";
            } else if (sky == 3 && pty == 0) {
                weatherIcon = "sunny-cloudy-night";
            } else if (sky == 3 && (pty == 1 || pty == 4)) {
                weatherIcon = "only-cloudy-rainy";
            } else if (sky == 3 && pty == 2) {
                weatherIcon = "sunny-cloudy-rainy";
            } else if (sky == 3 && pty == 3) {
                weatherIcon = "sunny-cloudy-snowy";
            } else if (sky == 4 && pty == 0) {
                weatherIcon = "only-cloudy";
            } else if (sky == 4 && (pty == 1 || pty == 4)) {
                weatherIcon = "only-cloudy-rainy";
            } else if (sky == 4 && pty == 2) {
                weatherIcon = "only-cloudy-rainy";
            } else if (sky == 4 && pty == 3) {
                weatherIcon = "only-cloudy-snowy";
            }
        }
        return weatherIcon + ".svg"; // 파일 확장자 붙임

    }

    private String mapClothes(double tmx, double tmn) {
        // 일교차가 10 이상이면 따로 구성 필요
//        double temparatureDiff = tmx - tmn;
//        log.info("일교차: {}", temparatureDiff);

        String clothesInfo = ""; // 옷 정보 담는 변수
        String clothesCode = ""; // 코드 번호 담는 변수

        // 평균 기온 구해서 반올림 적용
        int averageTemperature = (int) Math.round((tmx + tmn) / 2);
        log.info("average temparature: {}", averageTemperature);

        // 기온에 따라 옷 맵핑하기
        if (averageTemperature >= 28) {
            log.info("민소매, 반팔, 반바지, 치마");
            clothesCode = "9";
        } else if (averageTemperature >= 23) {
            log.info("반팔, 얇은 셔츠, 반바지, 면바지");
            clothesCode = "8";
        } else if (averageTemperature >= 20) {
            log.info("얇은 가디건, 긴팔티, 면바지, 청바지");
            clothesCode = "7";
        } else if (averageTemperature >= 17) {
            log.info("얇은 니트, 가디건, 맨투맨, 얇은 재킷, 면바지, 청바지");
            clothesCode = "6";
        } else if (averageTemperature >= 12) {
            log.info("재킷, 가디건, 야상, 맨투맨, 니트, 스타킹, 청바지, 면바지");
            clothesCode = "5";
        } else if (averageTemperature >= 9) {
            log.info("재킷, 트렌치코드, 야상, 니트, 스타킹, 청바지, 면바지, 겉옷 안에 가디건 필수");
            clothesCode = "4";
        } else if (averageTemperature >= 5) {
            log.info("코트, 히트텍, 니트, 청바지, 레깅스, 반드시 겹쳐 입을 것");
            clothesCode = "3";
        } else if (averageTemperature >= 0) {
            log.info("패딩, 두꺼운 코트, 목도리, 기모제품, 최대한 많이 껴입자");
            clothesCode = "2";
        } else if (averageTemperature >= -5) {
            log.info("모자 달린 두꺼운 패딩, 안에는 스웨터, 귀마개, 부츠 등 방한 제품");
            clothesCode = "1";
        } else {
            log.info("파카 코트 등 방한 아웃도어 제품");
            clothesCode = "0";
        }
        return clothesCode;

    }
}
