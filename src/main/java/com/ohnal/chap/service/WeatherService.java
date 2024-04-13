package com.ohnal.chap.service;

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

    public void getShortTermForecast(String area1, String area2) {

        LocalDateTime now = LocalDateTime.now();
        String baseDate = DateTimeFormatter.ofPattern("yyyyMMdd").format(now);
        log.info("baseDate: {}", baseDate);

        // nx(map의 키가 컬럼값) nx의 value가 map의 value다.
        Map<String, Integer> map = mapper.getCode(area1, area2);
        log.info("좌표 결과: {}", map);

        try {

            StringBuilder urlBuilder = new StringBuilder("http://apis.data.go.kr/1360000/VilageFcstInfoService_2.0/getVilageFcst"); /*URL*/
            urlBuilder.append("?" + URLEncoder.encode("serviceKey", "UTF-8") + "=8LF4JSqJGbyzomL5iWo1ETi%2FcSmIbBi%2B%2BpgAK0OWEtoE41lgJHyGCBaKsdY07jLNQcvh%2FQM2CmkKd%2Bgqvwk0mQ%3D%3D"); /*Service Key*/
            urlBuilder.append("&" + URLEncoder.encode("pageNo", "UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*페이지번호*/
            urlBuilder.append("&" + URLEncoder.encode("numOfRows", "UTF-8") + "=" + URLEncoder.encode("300", "UTF-8")); /*한 페이지 결과 수*/
            urlBuilder.append("&" + URLEncoder.encode("dataType", "UTF-8") + "=" + URLEncoder.encode("JSON", "UTF-8")); /*요청자료형식(XML/JSON) Default: XML*/
            urlBuilder.append("&" + URLEncoder.encode("base_date", "UTF-8") + "=" + URLEncoder.encode(baseDate, "UTF-8")); /*‘21년 6월 28일 발표*/
            urlBuilder.append("&" + URLEncoder.encode("base_time", "UTF-8") + "=" + URLEncoder.encode("0200", "UTF-8")); /*06시 발표(정시단위) */
            urlBuilder.append("&" + URLEncoder.encode("nx", "UTF-8") + "=" + URLEncoder.encode(String.valueOf(map.get("nx")), "UTF-8")); /*예보지점의 X 좌표값*/
            urlBuilder.append("&" + URLEncoder.encode("ny", "UTF-8") + "=" + URLEncoder.encode(String.valueOf(map.get("ny")), "UTF-8")); /*예보지점의 Y 좌표값*/

            log.info("완성된 URL: {}", urlBuilder.toString());

            URL url = new URL(urlBuilder.toString());
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");
            conn.setRequestProperty("Content-type", "application/json");
            System.out.println("Response code: " + conn.getResponseCode());

            BufferedReader rd;
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

                if (category.equals("TMX") || category.equals("TMN")) {
                    log.info("category: {}, value: {}", category, fcstValue);
                }

            }


        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
