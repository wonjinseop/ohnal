package com.ohnal.util;

import org.apache.ibatis.annotations.Param;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.text.DecimalFormat;
import java.time.LocalDateTime;
import java.util.SortedMap;
import java.util.UUID;

public class FileUtils {

public static String uploadFile(MultipartFile file, String rootPath){
String newFileName= UUID.randomUUID()+"_"+file.getOriginalFilename();
String newUploadPath= makeDateFormatDirectory(rootPath);
String fullPath= newUploadPath+"/"+newFileName;
    try {
        file.transferTo(new File(newUploadPath, newFileName));
    } catch (IOException e) {
        e.printStackTrace();
    }

    return fullPath.substring(rootPath.length());
}

    private static String makeDateFormatDirectory(String rootPath) {
        LocalDateTime now = LocalDateTime.now();
        int year = now.getYear();
        int month = now.getMonthValue();
        int day = now.getDayOfMonth();
        String[] dateInfo = {year + "", len2(month), len2(day)};

        String directoryPath = rootPath;
        for (String s : dateInfo) {
            directoryPath += "/" + s;
            File f = new File(directoryPath);
            if (!f.exists()) f.mkdir();
        }

        return directoryPath;


    }

    private static String len2(int n) {
    return new DecimalFormat("00").format(n);
    }


}
