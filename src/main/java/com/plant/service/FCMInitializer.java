package com.plant.service;

import com.google.auth.oauth2.GoogleCredentials;
import com.google.firebase.FirebaseApp;
import com.google.firebase.FirebaseOptions;
import com.plant.vo.MyplantVo;
import org.apache.ibatis.annotations.Param;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.io.FileInputStream;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;

@Service
public class FCMInitializer {

    @Autowired
    private MyPlantService myPlantService;
    private static final Logger logger = LoggerFactory.getLogger(FCMInitializer.class);

    @PostConstruct
    public void initialize() {
        try {
            FileInputStream serviceAccount =
                    new FileInputStream("src/main/resources/firebase/plant-butler-97f48-firebase-adminsdk-zj3ua-50d19b0665.json");

            FirebaseOptions options = new FirebaseOptions.Builder()
                    .setCredentials(GoogleCredentials.fromStream(serviceAccount))
                    .setProjectId("plant-butler-97f48")
                    .build();

            if (FirebaseApp.getApps().isEmpty()) {
                FirebaseApp.initializeApp(options);
                logger.info("Firebase application has been initialized");
            }
        } catch (IOException e) {
            logger.error("Error initializing firebase", e);
        }
    }
    @PostConstruct
    @Scheduled(cron = "0 0 0 * * ?")
    public void point(){
        Timestamp timestamp = new Timestamp(System.currentTimeMillis());
        long todayInDays = timestamp.getTime()/ (1000 * 60 * 60 * 24);
        boolean flag = myPlantService.point(todayInDays);



    }
}